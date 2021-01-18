---
author: nmaynes1
categories:
- Uncategorized
date: "2020-01-19T21:25:12Z"
guid: http://blog.mayn.es/?p=156
id: 156
image: /wp-content/uploads/2020/01/182041.jpg
tags:
- audio
- family history
- FLAC
- formats
- getting started
- interviews
- ocen audio
- ocenaudio
- oral history
- process
- WAV
title: Your Simple Guide to Collecting Oral History
url: /2020/01/19/your-simple-guide-to-collecting-oral-history/
---
Collecting memories from people is an excellent way to celebrate the experience of others. I have found it helps me learn more about why people hold certain beliefs, how they overcame hardships, and the world we live in. Interviewing other people has helped me learn more about myself, which is why I wanted to write up a guide for collecting the stories of other people. 



The most obvious aspect of collecting stories is interviewing. There are a ton of resources by people much more experienced than myself on how to conduct an oral history interview. It is important to come up with a sample outline and use that as a starting point. I continue to consult the following resources to help me prepare for interviews.

  * Ancestry.org&#8217;s &#8211; [The Oral History Interview: Don’t Miss a Chance to Record Family Stories](https://blogs.ancestry.com/ancestry/2017/09/10/the-oral-history-interview-dont-miss-a-chance-to-record-family-stories/)
  * Southern Oral History Program &#8211; [A Practical Guide to Oral History](https://sohp.org/files/2013/11/A-Practical-Guide-to-Oral-History_march2014.pdf)
  * UCLA &#8211; [Family History Sample Outline](http://oralhistory.library.ucla.edu/familyHistory.html)
  * NYTimes &#8211; [Record and Share Your Family History in 5 Steps](https://www.nytimes.com/2018/11/21/technology/personaltech/family-history-record-share.html)

But the interview is only part of the process. I wanted to provide a quick write up on how anyone can get started collecting oral histories without worrying about whether they are doing it &#8220;right.&#8221; The following sections lay out what equipment you will need, what software to use, the digital formats you will deal with, a simple way to edit the audio, and finally how to share it. It is not the &#8220;right&#8221; way or the &#8220;best&#8221; way. Instead it is a process that anyone with motivation and access to a few resources should be able to recreate.

## Equipment

The equipment needed is pretty straightforward. You will need something to collect the interviews with, and something to process them. For processing, you will want a computer. While it is possible to capture and process audio files on a tablet, smartphone, or even tape, this post assumes you would like a little more freedom in working with the files. Let&#8217;s look at three options for capturing audio.

**Good**: Use a recorder application and microphone, like the one on iPhone headphones, to capture the person speaking. This option will allow you to capture a single interviewee&#8217;s responses at a fairly decent quality. It may not work well in an environment with lots of ambient noise or when interviewing multiple people at once, for example Grandma and Grandpa.

**Better**: Use a multichannel field recorder. The [TASCAM DR-40X](https://www.sweetwater.com/store/detail/DR40X--tascam-dr-40x-handheld-recorder?&mrkgcl=28&mrkgadid=3332697332&product_id=DR40X&campaigntype=shopping&campaign=aaShopping%2520-%2520SKU%2520-%2520Studio%2520%26%2520Recording&adgroup=Recorders%2520-%2520TASCAM%2520-%2520dr40x&placement=google&creative=337614397436&device=c&matchtype=&network=g&gclid=Cj0KCQiAr8bwBRD4ARIsAHa4YyIs_dBs6icoX2NLMadvUbaS_c3nUqyiFPV5EVJIhf0V0oukypiMBxcaAhJPEALw_wcB&gclsrc=aw.ds) allows for capturing stereo samples from the device itself and can be mounted on a tripod near the interviewee for more consistent levels. It also takes up to two microphone inputs for easy portable recording. These devices cost between $100 and $400 dollars which can be cost prohibitive for some projects. The also require configuration which can seem daunting to people who consider themselves, &#8220;nontechnical.&#8221; 

**Best**: Multi-channel mixer with multiple microphones. Something similar to the [Zoom F6 Multitrack Field Recorder](https://www.sweetwater.com/store/detail/F6--zoom-f6-multitrack-field-recorder) enables capturing multiple sources in a compact recording device. This option is more expensive and has more to set up. It is ideal when interviewing a small group, 3 or four people, since each speaker can have their own microphone which isolates their responses into a single channel. Having the audio on a single channel helps in post production. It allows the various channels to be edited in greater isolation. Pops and lip smacks can be removed from the source channel instead of tease apart various input signals from a single audio file. 

All of these options will require a computer to collect, edit, and post the audio files. Depending on your project, you may have to convert files that other people provide or even old tapes. File conversion can be performed by various audio editing tools, however, I will refrain from describing that process as it is outside the scope of this tutorial. Before stepping though how to edit or share audio files, an overview of how audio signals are stored digitally is worthwhile. 

## Digital Audio Formats in 1 minute 

The process of capturing an audio signal in the real world, converting it to a digital file, and then saving that for use later is complex. There are [many file formats](https://en.wikipedia.org/wiki/Audio_file_format) designed to encode sound into data useful to various digital tools. Learning digital audio formats, even on a basic level, will help you make choices about how to capture, edit, store, and share the stories you record. 

**Lossy versus Lossless**  
A lossless file format stores all the data captured from the capturing device. A lossy file format generally utilizes a compression algorithm to remove &#8220;unnecessary&#8221; data from the file in order to make it smaller. Understanding the difference is easier visually than digitally. The following photos demonstrate the impact lossless vs lossy formats can have on images.

A size versus quality compromise also exists with audio files. When capturing audio, storing it as lossless is ideal. For example, I use a TASCAM field recorder and save the audio as 24bit, 96KHz WAV files which means the files are large. The stereo signal being captured writes 576 KB of data per second which is 34.56 MB a minute, and 2.0736 GB an hour. A multi hour interview can quickly take up storage space. When transferring the interviews to my computer, I convert them to [FLAC files](https://en.wikipedia.org/wiki/FLAC) which reduces the size of the file through compression. FLAC is extra cool because it is lossless compression, meaning, the original files can be reconstructed but storing it in FLAC is 50-70% smaller. 

What does this mean to your project? Record in a lossless format like WAV. When you finish editing the audio, convert it to FLAC which will save you disk space and make uploading and-or sharing the files much easier. Luckily, free software exists to help with the editing and conversion process. 

## Software

The free audio editing software of choice for years has been [Audacity](https://www.audacityteam.org/). If you have experience using it, go right ahead. If you do not, I find the program [OcenAudio](http://www.ocenaudio.com/) to be much more straightforward to use for editing interviews. The way OcenAudio tracks edits is non-destructive which means it does not overwrite the original files with the edits you make. Instead, you create a new audio artifact by saving and exporting your changes. You can also use GarageBand if you are on a Mac. If you decide to use GarageBand or Audacity, you will need to do some homework to perform the actions I describe in the editing section. 

## Edit It

Editing is probably the most difficult step in this whole process. It requires you to listen to the audio in its entirety, multiple times. The goal with editing the interviews is not to editorialize them, but to make them simple to consume. I recommend creating roughly 10 minute chunks of audio that have pauses, ticks, and other distracting elements removed. This will make the final product easy to digest which means it is more likely to get listened to. The steps for editing a sound file in OcenAudio are pretty simple. 

  * Load a clip
  * Normalize the Audio
  * Fade in the beginning
  * Fade out the ending
  * Clip out pauses
  * Export

This process takes time. OcenAudio has a pretty easy to use interface but knowing what the buttons do and how to use them can be daunting. There are helpful Youtube videos on basic editing in OcenAudio including [this one](https://www.youtube.com/watch?v=vLZd0JZFmNA) that goes through a quick oral history workflow. I recommend watching one or two before getting started with your own project. Normalizing, fading, and clipping are the more repetitive tasks. To help give you confidence for tackling your project, I will describe how to fade audio in and out, perform volume normalization, and clipping.

**Fade Audio In/Out**

Adding a fade to the beginning and end of the audio helps ease the transition between silence and the recording. It is very simple to do in OcenAudio. Simply select the region to add the fade in to. Once selected, the fade in quick icon becomes available. See the demonstration below.


**Normalize** 

This is one of the most important steps and can take a ton of time. The method I will describe is a quick fix. It will not make your interviews ready for NPR or the national archives. It will however, make them much easier to listen to. OcenAudio provides a normalization shortcut that attempts to smooth out the volume of the track. You know how when watching TV, some commercials are WAY to loud? It is annoying! In fact, it bothered enough people to get a law passed in the United States called the [CALM act](https://www.govinfo.gov/content/pkg/PLAW-111publ311/pdf/PLAW-111publ311.pdf). Normalization helps prevent violent jumps in audio volume. To apply the normalization filter, select the audio and apply the effect as shown below.

**Clipping**

Clipping is one way to remove unwanted pops, curse words, embarrassing stories, mistakes, whatever else may exist on the track that should not. It is a common task and simple to perform. The one gotcha is to make sure all channels are selected before performing the clip. Keep in mind you can always undo the last action. <figure class="wp-block-image size-full">

When the audio is at a state you feel comfortable sharing, it can be saved by selecting File > Save As&#8230; and saving the file to a location on your computer. I strongly recommend saving the file in the FLAC format but there are many other formats to choose from. Saving it as an mp3 would be appropriate if you planned on creating an mp3 CD and sharing that with family. In my experience it is easier to share via the web on a service like Soundcloud. The reasons for doing so are detailed in the next section. 

An optional step worth mentioning. Naming the files with a leading numerical indicator will help when trying to organize them later. For example, if I have three tracks that are called &#8220;Early Life&#8221;, &#8220;Middle Life&#8221;, &#8220;Later In Life&#8221;, changing the file names to &#8220;00 &#8211; Early Life&#8221;, &#8220;01 &#8211; Middle Life&#8221;, &#8220;02 &#8211; Later In Life.&#8221; This naming scheme will work on up to ten tracks. If you have more than than, use 000 as your first track number. You can rearrange the track order on Soundcloud but I find naming them with a sequential order makes finding the right file easier.

## Share It

Figuring out how to share the file is largely up to you. For my purposes I wanted to place it in a location that was accessible to anyone with a phone and internet connection. I also wanted the files to be accessible to only those with whom I had shared a link. [Soundcloud](https://soundcloud.com/discover) provides a very simple way to host audio files (up to 180 minutes for free) and share them without requiring everyone to create an account. You can listen to the files hosted there via a web browser or their mobile app. To make your interviews available to only those people you choose, follow these steps:

  * Create a Soundcloud account
  * Upload your audio files 
  * Make sure the private option is selected
  * Once they are uploaded, create a playlist of the related tracks by visiting My Tracks and selecting all of the ones you would like to add to a playlist
  * Share the playlist link with your audience!

## Recap

We just walked through a process for capturing, editing, and sharing oral histories. To provide a TLDR (To Long, Didn&#8217;t Read):

  * Come up with an outline of questions to ask
  * Schedule interview times. Try to keep each session limited to between one and two hours.
  * Procure the necessary recording equipment and practice recording yourself before the first interview.
  * Configure your capture devices to use lossless file formats.
  * Record the interviews. Try and place the microphone as close to the speaker as possible without getting in the way.
  * Edit the audio files and save them in a lossless format.
  * Share the interviews!

The process described above is not the only way. As you get more comfortable, tweaks can allow you tailor the process to your situation and style. My goal in sharing these steps is that hopefully, you will be inspired to collect the stories of people around you. And when you do, please let me know how it goes!