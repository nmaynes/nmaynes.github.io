---
title: "Working With File Like Objects in Lambda"
categories:
- Tutorials
tags:
- python
- zipfile
- aws
- lambda
date: 2021-12-30T16:35:34-05:00
---

I recently started working on a workflow for picking up files from S3, processing them, and writing the
results to another S3 location. This is a common pattern in data processing pipelines and our team wanted to see whether
we could do it using AWS serverless services. We were able to get it running via Lambda
functions and event triggers published to an AWS EventHub. The entire workflow was fairly easy to stand up once we
grasped how the various services worked together.

AWS recently stood up a site called
[serverlessland.com](https://serverlessland.com) which has a [bunch of resources](https://serverlessland.com/blog)
for building serverless workflows in AWS. I encourage you to take a look at some of the AWS resources to learn more
about how to set up a workflow, properly set permissions, connect the services, or develop with the
[SAM build tool](https://serverlessland.com/blog?tag=AWS%20SAM). For this post, I want to share how to work with
file like objects in Lambda functions.

## The Lambda Function Handler

A Lambda function is "a [...] compute service that lets you run code without provisioning or managing servers"
![Anatomy of a Lambda Function](/lambda_function_anatomy.png)
When setting up a lambda function it is important to note that the code you write will be handled via a function called
`lambda_handler` which is the entrypoint to the code. Currently, the handler function takes two arguments,
`event` and `context`. The event argument contains objects and attributes from the calling process
while the context allows the code to access information about the process that spawned the
event. I'll focus on event objects triggered by `Put` events in an S3 bucket.

## get_object() and its StreamingBody

When an event is passed to a Lambda function from S3, the file contents can be retrieved and manipulated by accessing
the event, pulling out the Bucket and Key names, and finally passing the Bucket and Key names to a function like
[Boto3 s3 client's  `get_object()`](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#S3.Client.get_object).
Pay attention to the fact that this is the client interface and not the resource interface. They have some similar methods
but are not the same! I frequently see questions on StackOverflow asking why code does not work when the poster is
calling a Boto3 client method on a Boto3 resource object. Calling `get_object()` from a Lambda function is pretty easy.
Take care to set up the Lambda function with proper access and permissions. If the S3 bucket is in a VPC, the Lambda
function needs to have access to that VPC. If the S3 bucket is locked to allow specific IAM roles access to specific
objects, the Lambda function needs to be granted the proper IAM roles.

In my experience, getting the permissions right
is the most time consuming task when developing a Lambda workflow. My advice? Develop the Lambda function in a way
that allows you to confirm access to resources in steps. If the workflow is supposed to access one S3 bucket, download
and manipulate a file's contents, and then upload the result to another S3 bucket then the development process should
be split into three stages. One for accessing the S3 bucket when a file will be picked up. The next stage focuses on
manipulating the file's contents. And the final stage focuses on putting a file in its destination. Get the permissions
ironed out for each phase and verify you are able to do each operation before trying to write the whole function.

Calling `get_object()` will return the object and its contents. Take special care to respect the limits of Lambda. Jobs
can live for a maximum of 15 minutes as I write this in November of 2021. The Lambda function has access to the `/tmp`
directory but is only allowed to write 512mb to disk. More details about what a Lambda function is limited to can be
found in the Lambda Getting Started guide under ["limits"](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html).
The contents can then be accessed via the response's "Body" attribute. The Body attribute is a
[StreamingBody](https://botocore.amazonaws.com/v1/documentation/api/latest/reference/response.html#botocore-response) object
and must be handled properly. For small files, `read()` is the method to use in combination with other methods
for working with file like objects.

## An Example

It is easier to demonstrate how this works with an example. The code below was written
to process a zip archive once it was created in a specific S3 bucket. It opens the archive and then parses the
CSV contents. Finally it returns the contents of the files as a json payload if the process succeeded. Otherwise the
function will return a non-success error code and exit.

```python
import csv, json
import os
import urllib.parse
import boto3
from zipfile import ZipFile
import io

s3 = boto3.client("s3")

def extract_zip(input_zip, file_name):
    contents = input_zip.read()
    input_zip = ZipFile(io.BytesIO(contents))
    return {name: input_zip.read(name) for name in input_zip.namelist()}

def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    # Get the object from the event and show its content type
    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    key = urllib.parse.unquote_plus(
        event["Records"][0]["s3"]["object"]["key"], encoding="utf-8"
    )
    try:
        bucket = event['Records'][0]['s3']['bucket']['name']
        key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

        response = s3.get_object(Bucket=bucket, Key=key)
        # This example assumes the file to process shares the archive's name
        file_name = key.split(".")[0] + ".csv"
        print(f"Attempting to open {key} and read {file_name}")
        print("CONTENT TYPE: " + response["ContentType"])
        data = []
        contents = extract_zip(response["Body"], file_name)
        for k, v in contents.items():
            print(v)
            reader = csv.reader(io.StringIO(v.decode('utf-8')), delimiter=',')
            for row in reader:
                data.append(row)
        return {
            "statusCode": 200,
            "body": data
        }

    except Exception as e:
        print(e)
        print(
            "Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.".format(
                key, bucket
            )
        )
        raise e
```

This is very similar to code that would be executed on your local machine or a server. The only real differences are
the `event` and `context` objects passed as arguments to `lambda_handler`. Those two objects are passed from the trigger
that initiates the Lambda function. In this example, the trigger is an S3 event which fires whenever a file is "created"
in a specific directory with a specific file extension. The `event` object is how we extract the bucket and key name.

The bucket

```python
bucket = event["Records"][0]["s3"]["bucket"]["name"]
```

and the key

```python
key = urllib.parse.unquote_plus(
    event["Records"][0]["s3"]["object"]["key"], encoding="utf-8"
)
```

The bucket and key name allow us to call `s3.get_object()` and pull the contents into memory. In this example, the
file contents are processed without writing to disk. This can be tricky if you are used to reading and writing from
disk via [file object commands](https://docs.python.org/3.8/tutorial/inputoutput.html#methods-of-file-objects) like `open()`.
In the example, we operate on the StreamingBody which is a [bytes-like object](https://docs.python.org/3.8/glossary.html#term-bytes-like-object).
That just means we need to access the byte stream the proper way.

In `extract_zip()` We call the `read()` method on the StreamingBody returned by `get_object()`. This example is
expecting a zip archive so the results of read must be passed to a ZipFile in a BytesIO object. The files contained
inside the archive are then looped over, and the contents added to a dictionary. The key of each dictionary entry is
the name of the file from which the content was taken.

Finally, the dictionary is ready for processing. This example is expecting to process CSV files. Using the `csv.reader`
method, we can cast the bytes to a StringIO object and handle the file just like any other CSV file. The rows can then
be placed in a list and returned by the function.


