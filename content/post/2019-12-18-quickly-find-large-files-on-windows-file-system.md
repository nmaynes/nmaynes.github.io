---
author: nmaynes1
categories:
- Uncategorized
date: "2019-12-18T17:11:48Z"
guid: http://blog.mayn.es/?p=147
id: 147
image: /wp-content/uploads/2019/12/louis-smith-PuUmvymwYS4-unsplash-1568x853.jpg
tags:
- cleaning
- disk space
- file system
title: Quickly Find Large Files On Windows File System
url: /2019/12/18/quickly-find-large-files-on-windows-file-system/
---
Once a year I need to free up space on my work machine. Once a year I find myself searching for an efficient way to identify the largest files that I do not need any longer without installing third party software. Here is the solution I stumbled on this year and it couldn&#8217;t be simpler.  


  * Open File Explorer 
  * Navigate to the drive you want to search. Normally, C:\
  * Type &#8220;size:gigantic&#8221; in the search bar
  * Wait for the search to complete
  * Sort the results by size

This search will scan your computer&#8217;s file system for files that are larger than 128mb. You can then identify files that are no longer needed.

Ignore all the large files in the C:\Windows\ directory. You want to keep those. Look for files that are in your Documents or Downloads directories first. I always find one or two multi gigabyte files I forgot to delete.