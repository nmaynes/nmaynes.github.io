+++
title = "Upload a Pandas Dataframe to AWS S3 With Ease"
date = 2021-08-31T12:24:01-04:00
+++

Uploading a Pandas dataframe to S3 is different from writing the dataframe to a local filesystem.
But have no fear! It is easy once you understand a couple of key concepts. Here is a working example 
using `boto3.resource("s3")` that has been tested against pandas 1.3.2. It is 
worth noting that the following will only work with [pandas versions greater than 1.2.0](https://github.com/pandas-dev/pandas/pull/35129). 

    from io import BytesIO
    import boto3
    import pandas
    from pandas import util
    df = util.testing.makeMixedDataFrame()
    s3_resource = boto3.resource("s3")
    buffer = BytesIO()
    df.to_csv(buffer, sep=",", index=False, mode="wb", encoding="UTF-8")
    df.seek(0)  # Make sure the stream position is at the beginning!
    s3_resource.Object("test-bucket", "test_df_from_resource.csv").put(Body=buffer.getvalue())

Once you make the call to S3, you should receive a confirmation message similar to the one below:

    >> {'ResponseMetadata': {'RequestId': 'request-id-value',
    'HostId': '###########',
    'HTTPStatusCode': 200,
    'HTTPHeaders': {'x-amz-id-2': '############',
    'x-amz-request-id': '00000',
    'date': 'Tue, 31 Aug 2021 00:00:00 GMT',
    'x-amz-server-side-encryption': 'value',
    'etag': '"xxxx"',
    'server': 'AmazonS3',
    'content-length': '0'},
    'RetryAttempts': 0},
    'ETag': '"xxxx"',
    'ServerSideEncryption': 'value'}

What are we doing in each line? Let's run through them. 

- Lines 1-4: Importing packages. Pretty straight forward.

- Line 5: Create a test dataframe via pandas.util.testing.makeMixedDataFrame(). 

- Line 6: Instantiate an S3 `resource` object. We could instantiate a `client` object which allows us
to access a different API which includes lower level functions. This may or may
  not be worth considering for your use case. I found the following description
  in a 
  [StackOverflow answer](https://stackoverflow.com/questions/42809096/difference-in-boto3-between-resource-client-and-session) 
  helpful when determining whether to use `resource` or `client`. 

  > Resource : This is the high-level service class recommended to be used. This allows you to tied particular AWS resources and passes it along, so you just use this abstraction than worry which target services are pointed to.
  
  > Client is a low level class object. For each client call, you need to explicitly specify the targeting resources, the designated service target name must be passed along. You will lose abstraction!

  My takeaway, Go with `resource` when you can.
  
- Line 7: Instantiate a BytesIO() object in order to buffer results. Keep in mind, this will live in memory
and if you are writing giant dataframes to S3, take special care to chunk the dataframe. 
  
- Line 8: Write the dataframe results to the BytesIO buffer. Take care to declare the proper mode and encoding.

- Line 9: Move the stream position back to the beginning. When writing to a stream, the offset is updated automatically. 
That means if you write bytes, the offset points to the next position available for writing, not the beginning of the
  stream! If this is intimidating, take a little time to learn about working with [streams](https://docs.python.org/3/library/io.html#overview).

- Line 10: Write the contents of the buffer into the object in S3. Using the `Object().put()` method,
we declare an S3 object and the S3 Bucket it lives in followed by a call to `put()` which places the contents
  of our buffer into the S3 object. 

That is it! No need to add dependencies. Pandas allows using an S3 uri in the 
`to_csv()` method, but I recommend against doing so for the following reason. 
[It depends on s3fs](https://pandas.pydata.org/pandas-docs/stable/whatsnew/v0.20.0.html#s3-file-handling).
[s3fs](https://s3fs.readthedocs.io/en/latest/) is a great library but has strict dependency requirements. It will pin several packages
to very specific versions. The most troublesome being:

- botocore

- aiobotocore
  
- aiohttp
  
- aioitertools
  
In practice, this leads to difficulty updating boto3 as the release schedule for boto3
is [almost daily](https://github.com/boto/boto3/releases).
- You will need to use a pandas version that [includes the fix][1] "support binary file handles in to_csv". The example below was tested on Pandas 1.3.2, Python 3.8, and boto3 1.17.106.
- The answer by @AKX and the following example use the high level `s3.resource()` API. I will also include an example for using the `s3.client()` API but keep in mind, they provide different methods for performing similar tasks.
- https://stackoverflow.com/questions/42809096/difference-in-boto3-between-resource-client-and-session


You should then receive a confirmation message that looks similar to the following:

    >> {'ResponseMetadata': {'RequestId': 'request-id-value',
    'HostId': '###########',
      'HTTPStatusCode': 200,
      'HTTPHeaders': {'x-amz-id-2': '############',
       'x-amz-request-id': '00000',
       'date': 'Tue, 31 Aug 2021 00:00:00 GMT',
       'x-amz-server-side-encryption': 'value',
       'etag': '"xxxx"',
       'server': 'AmazonS3',
       'content-length': '0'},
      'RetryAttempts': 0},
     'ETag': '"xxxx"',
     'ServerSideEncryption': 'value'}


For the curious, here is an example of how to copy the contents of a dataframe to S3
using `boto3.client("s3")`

    from io import BytesIO
    import boto3
    import pandas
    from pandas import util
    df = util.testing.makeMixedDataFrame()
    s3_client = boto3.client("s3")
    campaign_buffer = BytesIO()
    df.to_csv(campaign_buffer, sep=",", index=False, mode="wb", encoding="UTF-8")
    df.seek(0)
    s3_client.upload_fileobj(campaign_buffer, Bucket="test-bucket", Key="test_df_from_client.csv")

The simple `client()` example is very similar to the `resource()` example. 
I hope seeing both helps highlight the small differences between the two approaches. 
These examples only scratch the surface of what can be done and do not attempt to provide any 
exception handling. My goal with sharing these samples is to jumpstart the development of
anyone looking for an easy way to upload a Pandas dataframe to S3.
