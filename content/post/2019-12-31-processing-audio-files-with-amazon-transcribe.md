---
author: nmaynes1
categories:
- Uncategorized
date: "2019-12-31T21:41:36Z"
guid: http://blog.mayn.es/?p=150
id: 150
image: /wp-content/uploads/2019/12/anton-ponomarev-vyzDsy5whUo-unsplash-1568x1045.jpg
tags:
- amazon
- aws
- interviews
- oral history
- transcribe
- transcription
title: Processing Audio Files with Amazon Transcribe
url: /2019/12/31/processing-audio-files-with-amazon-transcribe/
---
I have been working on collecting a family&#8217;s oral history for the past few months. During the process I took notes with simple descriptions of what the speaker was describing or telling and a rough timestamp of when in the file the conversation took place. After collecting hours of stories, I realized that having a transcription would make things much easier to search and perhaps more useful to those interested in these particular histories. Why not get a transcription of the contents via one of the cloud offerings? Amazon offers a service called Transcribe that is available via the AWS suite of services. Since I have a small account and some credits to burn I figured why not kick the tires and see how Transcribe would perform on meandering oral history interviews. But before I jump into the how, let me describe my particular use case.<figure class="wp-block-image size-large">

Over the course of a few months, I have collected several half hour to two hour long interviews via multiple recording set ups. Some files were captured with [Open Broadcast Software](https://obsproject.com/) (OBS) and include video. Others were captured using a TASCAM field recorder and are .wav files. In order to get the audio of each interview put together and normalized, I used a free application called [ocenaudio](https://www.ocenaudio.com/whatis). It allowed me to load .flac, .wav, and other audio formats in the same editing channels and add various effects to sections or the entire workspace. Ocenaudio&#8217;s interface allows for simple drag-and-drop editing of sound files. It is also worth noting that Ocenaudio is non-destructive meaning it leaves the original audio file alone. This can be a little confusing if you are not used to using software that performs non-destructive editing. When a project is saved, is exports the results to a new file. Keep that in mind if you plan on adding additional files later. 

After I collected and normalized all the sound files, I decided to turn to AWS to get a transcription. Transcribe limits the processing size to files to 2GB. The first collection of interviews was about 3 hours long and 2.5GB in size. I split the collection up into two smaller sizes. AWS needs the file to be uploaded to S3 in order for Transcribe to access it. Here is how I set up the S3 bucket with the audio file.

  * Place it in a region near your house. Or don&#8217;t, its up to you.
  * Give the S3 bucket a unique name. You can do what ever you like as long as it conforms to the [S3 naming standard.](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-s3-bucket-naming-requirements.html)
  * Block _all_ public access 
  * Encrypt the bucket. I used AES-256 encryption
  * Give read and write access to your AWS account. 
  * Set the S3 bucket to Intelligent Tiering storage class. It does not matter too much unless you forget to spin the bucket down in which case Intelligent Tiering will push the storage into lower cost, slow storage.
  * Upload the file. As long as the files are less than 50GB, you can use the browser upload tool. Otherwise, you will need to download, configure, and use the [command line utility](https://docs.aws.amazon.com/cli/index.html).

Once your file is uploaded to S3, select the checkbox next to it and copy the &#8220;Object URL.&#8221; Transcribe needs this in order to find and process the file. If these steps do not work, check the [AWS tutorial](https://aws.amazon.com/getting-started/tutorials/create-audio-transcript-transcribe/) on connecting an S3 bucket to a Transcribe instance.<figure class="wp-block-image size-large">

![](https://d1.awsstatic.com/tmt/create-audio-transcript-transcribe/create-audio-transcript-transcribe-step-1l.c161c6a2c1946837a566cae724ce845fab478a3a.png) <figcaption>Screenshot from the AWS tutorial</figcaption></figure> 

Once the files are available in S3, setting up a Transcribe job is straightforward. The following needs to be configured for Transcribe to create a job. 

  * Name of the job
  * The language of the interviews. I processed English but would love to hear someone&#8217;s experience processing other languages. 
  * The location of the input file. That object URL you copied earlier. 
  * The location of where the output should go. I used Amazon&#8217;s default.

That is it! Jobs take a little while to run. Mine took about 20 minutes for audio files that are an hour long. Your mileage may vary. The results can be downloaded as a JSON file. A sample JSON object returned from Transcribe would be:

<pre class="wp-block-preformatted">{"jobName":"fam_interviews",
"accountId":"123456789",
"results":{
    "transcripts":[{"transcript":"A bunch of text returned by the transcribe service...The end of the text.",
                    "items":[{"start_time":"0.22",
                    "speaker_label":"spk_0", //If you have multiple speakers and asked to have Transcribe identify 
                                               them, this object with a speaker_label and start/end time exists.
                    "end_time":"3.45"}, ...
                  }],
    {start_time:          
         "5245.57",         
         "end_time":"5245.64",         
         "alternatives":[{"confidence":"1.0",          
                          "content":"I"}],
         "type":"pronunciation"} </pre>

Parsing the JSON object is all that is left for doing something useful with the transcript. My Transcribe results were not stellar. I believe that was due to the fact that those people I interviewed have an accent and the vocabulary used would sometimes be in another language. The service did do two things well. It identified the various speakers on the tape correctly and when I spoke, as the interviewer, it was able to correctly catch most of what I said. So if your audio files have native English speakers, this service does a fairly decent job. You will likely need to do some significant post processing to transform the transcript into a useful document.