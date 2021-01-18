---
author: nmaynes1
categories:
- Uncategorized
date: "2020-01-16T21:51:26Z"
excerpt: |
  The Windows Subsystem for Linux (WSL) is one of the best features on Windows 10. It makes development so much easier than it used to be but still has a few hiccups. Kinda like Linux, some things don't "just work." One pesky thing is getting SSH to work with a keypair file from WSL. This post details how to get SSH working on WSL.
guid: http://blog.mayn.es/?p=172
id: 172
image: /wp-content/uploads/2020/01/chris-panas-0Yiy0XajJHQ-unsplash-1568x1045.jpg
tags:
- chown
- file system
- linux
- ssh
- windows
- wsl
title: Troubleshooting Windows Subsystem for Linux and SSH
url: /2020/01/16/setting-up-windows-subsystem-for-linux-to-ssh/
---
The Windows Subsystem for Linux (WSL) is one of the best features on Windows 10. It makes development so much easier than it used to be but still has a few hiccups. Kinda like Linux, some things don&#8217;t &#8220;just work.&#8221; One pesky thing that I recently dealt with was getting SSH to work with a keypair file from WSL. Here is how to get SSH working on WSL.

## Goal

Given a keypair file, we want to invoke ssh from the command line and establish a tunnel to another server. This is a common task when connecting to remote servers. Think AWS, Azure, or Digital Ocean. It is a simple command:

`$ ssh -i /path/to/keypair.pem`

But WSL may throw a permissions error similar to:

<pre class="wp-block-preformatted">@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Permissions 0777 for 'keypair.pem' are too open.

It is required that your private key files are NOT accessible by others.

This private key will be ignored.

Load key "keypair.pem": bad permissions

Permission denied (publickey).</pre>

## Why?

Windows and Linux manage file permissions in a different way. For a detailed look at interoperability between a Windows and Linux filesystem see this [blog post](https://docs.microsoft.com/en-us/archive/blogs/wsl/wsl-file-system-support). Some excerpts are included below.

### File systems on Windows {#file-systems-on-windows}

<blockquote class="wp-block-quote">
  <p>
    Windows generalizes all system resources into objects. These include not just files, but also things like threads, shared memory sections, and timers, just to name a few. All requests to open a file ultimately go through the Object Manager in the NT kernel, which routes the request through the I/O Manager to the correct file system driver. The interface that file system drivers implement in Windows is more generic and enforces fewer requirements. For example, there is no common inode structure or anything similar, nor is there a directory entry; instead, file system drivers such as ntfs.sys are responsible for resolving paths and opening file objects.
  </p>
  
  <cite>https://docs.microsoft.com/en-us/archive/blogs/wsl/wsl-file-system-support</cite>
</blockquote>

### File systems on Linux {#file-systems-on-linux}

<blockquote class="wp-block-quote">
  <p>
    Linux abstracts file systems operations through the Virtual File System (VFS), which provides both an interface for user mode programs to interact with the file system (through system calls such as open, read, chmod, stat, etc.) and an interface that file systems have to implement. This allows multiple file systems to coexist, providing the same operations and semantics, with VFS giving a single namespace view of all these file systems to the user.
  </p>
  
  <cite>https://docs.microsoft.com/en-us/archive/blogs/wsl/wsl-file-system-support</cite>
</blockquote>

One of the many things that is handled differently is how file permissions are handled. Linux flips bits to set the various file permissions. For a detailed explanation read the [chmod man page](http://man7.org/linux/man-pages/man1/chmod.1.html) or the [excellent blog](https://nitstorm.github.io/blog/understanding-linux-file-permissions/) post by Nitin V. <figure class="wp-block-image size-large">

![](http://i.imgur.com/SGYIu.png) <figcaption>Table of Linux File Permissions &#8211; https://nitstorm.github.io/blog/understanding-linux-file-permissions/</figcaption></figure> 

Windows stores files as objects. The Windows file system manager provides a general interface for dealing with file objects and leaves fine grained operations to the file system drivers. One of the ways users bump into those differences is through file permissions. WSL, in trying to provide a level of interoperability attempts to support working on files across both systems through a single interface. <figure class="wp-block-image size-large">

![](https://msdnshared.blob.core.windows.net/media/2016/06/file-system-graphic.png) <figcaption>WSL Virtual File System &#8211; https://docs.microsoft.com/en-us/archive/blogs/wsl/wsl-file-system-support#file-systems-in-wsl</figcaption></figure> 

This is cool, complex, and has unintended side effects. One being, SSH can run into file permission problems if the host drive is mounted without file permissions exposed in a Linux friendly format. There are two ways to fix it. Place the `.pem` file in the WSL home directory (cd ~). Once it is there, you should be able to run `$ chmod 600 keyfile.pem` and create an SSH session. The other, more complicated way, is to remount the drive with [metadata enabled](https://devblogs.microsoft.com/commandline/chmod-chown-wsl-improvements/). You will need to unmount the drive, remount it with DrvFs, and verify that the additional metadata is enabled. To do that run:

<pre class="wp-block-preformatted">$ sudo umount /mnt/c<br />$ sudo mount -t drvfs C: /mnt/c -o metadata<br />$ mount -l<br /></pre>

<pre class="wp-block-preformatted">rootfs on / type lxfs (rw,noatime)
root on /root type lxfs (rw,noatime)
home on /home type lxfs (rw,noatime)
data on /data type lxfs (rw,noatime)
cache on /cache type lxfs (rw,noatime)
mnt on /mnt type lxfs (rw,noatime)
none on /dev type tmpfs (rw,noatime,mode=755)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,noatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,noatime)
devpts on /dev/pts type devpts (rw,nosuid,noexec,noatime,gid=5,mode=620)
none on /run type tmpfs (rw,nosuid,noexec,noatime,mode=755)
none on /run/lock type tmpfs (rw,nosuid,nodev,noexec,noatime)
none on /run/shm type tmpfs (rw,nosuid,nodev,noatime)
none on /run/user type tmpfs (rw,nosuid,nodev,noexec,noatime,mode=755)
binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,noatime)
C: on /mnt/c type drvfs (rw,relatime,<strong>metadata</strong>,case=off)</pre>

Confirm that metadata is enabled and you should be able to `chown` the keypair file and initiate an SSH session. WSL is being improved constantly and has become much better over the past couple years. I use it everyday at work and home. Its functionality has me working more in the Windows environment despite my home machine&#8217;s dual boot capabilities.