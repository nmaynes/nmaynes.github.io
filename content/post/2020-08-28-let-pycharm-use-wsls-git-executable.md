---
author: nmaynes1
categories:
- Uncategorized
date: "2020-08-28T16:39:19Z"
guid: http://blog.mayn.es/?p=225
id: 225
image: /wp-content/uploads/2020/08/bruce-warrington-X5axAA8Oecw-unsplash-1568x1206.jpg
title: Let Pycharm Use WSL&#8217;s Git Executable
url: /2020/08/28/let-pycharm-use-wsls-git-executable/
---
This post is mostly for me but I ran into a ton of conflicting information while troubleshooting my Windows Subsystem for Linux (WSL) and PyCharm integration and figured it may help someone else. First things first. Versions matter! Before wasting your time trying to get Pycharm and WSL to play nicely, make sure you are running PyCharm2020.2 or greater and WSL 2. If you a) have no idea what those versions mean or b) are not sure what version you are using, allow me a chance to explain. 

Why does WSL 2 matter? WSL 2 is a virtualization tool developed by Microsoft that uses a Microsoft fork of the Linux kernal to utilize way more features than the previous version of WSL. Some highlights from the official documentation:

<blockquote class="wp-block-quote">
  <p>
    WSL 2 is a major overhaul of the underlying architecture and uses virtualization technology and a Linux kernel to enable its new features.
  </p>
  
  <p>
    WSL 2 provides the benefits of WSL 1, including seamless integration between Windows and Linux, fast boot times, a small resource footprint, and requires no VM configuration or management. While WSL 2 does use a VM, it is managed and run behind the scenes, leaving you with the same user experience as WSL 1.
  </p>
  
  <p>
    The Linux kernel in WSL 2 is built by Microsoft from the latest stable branch, based on the source available at kernel.org.
  </p>
  
  <cite>https://docs.microsoft.com/en-us/windows/wsl/wsl2-index</cite>
</blockquote>

Why does this matter for the task of allowing PyCharm to just use the git executable that ships with a Ubuntu (or any other Linux image from the App store) WSL instance? PyCharm is a Windows and we would like to configure it to use the Git executable that will make system calls through the Windows Linux kernal. There is a lot going on to make it possible for PyCharm to call Git in a virtualized Linux environment. PyCharm has [an issue](https://youtrack.jetbrains.com/issue/IDEA-172253) on YouTrack that explains, 

<blockquote class="wp-block-quote">
  <p>
    Unfortunately, Git from WSL1 does not return output reliably when called from Windows, and this could lead to totally incorrect results of git commands&#8230;
  </p>
  
  <cite>https://youtrack.jetbrains.com/issue/IDEA-172253</cite>
</blockquote>

With the understanding that versions matter, make sure you are running the latest PyCharm and use the following commands in Powershell (as an administrator) to see what is going on with WSL. 

<pre class="wp-block-preformatted">> wsl --list --verbose
NAME STATE VERSION
Ubuntu-18.04 Stopped 2
Ubuntu-20.04 Stopped 2</pre>

That output shows that I have two Linux instances using WSL. It also tells me they are stopped and running WSL version 2. If you see that you are using version 1, or you have VirtualBox on your machine and it has not been updated in a while, you will need to get your system ready for WSL 2. <a href="https://docs.microsoft.com/en-us/windows/wsl/install-win10" data-type="URL" data-id="https://docs.microsoft.com/en-us/windows/wsl/install-win10">Read the documentation</a> on how to set up WSL 2. As a quick reference, here are the commands I found myself double checking. Please note, after running the commands in an elevated Powershell prompt, you will need to perform a system restart. 

#### Enable WSL

<pre class="wp-block-preformatted">dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart</pre>

#### Enable Virtual Machine Platform

<pre class="wp-block-preformatted">dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart</pre>

#### Set HyperVisor Launch Option to Auto

<pre class="wp-block-preformatted">bcdedit /set hypervisorlaunchtype auto</pre>

Now you can connect PyCharm to the WSL Git executable. Go to Settings > Version Control > Git and you should be able to point PyCharm 2020.2 to a WSL executable. For example, to use the Ubutnu-20.04 Git executable, the path would look something like: 

<pre class="wp-block-preformatted">\wsl$\Ubuntu-20.04\usr\bin\git</pre>

This post details the &#8220;happy path&#8221; for getting everything set up. You may run into issue, especially if you have been using virtualization software on your system like VirtualBox or VSphere. This post is really a way to consolidate a number of good answers on Github, StackOverflow, and the WSL 2 FAQ into something that gives background as well as an answer to &#8220;How can I configure PyCharm to use the Git executable installed with WSL?&#8221;