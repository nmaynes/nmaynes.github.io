---
author: nmaynes1
categories:
- Uncategorized
date: "2020-04-14T18:38:57Z"
guid: http://blog.mayn.es/?p=196
id: 196
image: /wp-content/uploads/2020/04/900GBjson.png
tags:
- big files
- bytes
- linux
- powershell
- tutorial
- wc
title: How to Get the First N Bytes of a File
url: /2020/04/14/how-to-get-the-first-n-bytes-of-a-file/
---

There comes a time when you just need to take a little off the top of a file, see what you are working with. That is where knowing how to use a utility like `<a href="http://man7.org/linux/man-pages/man1/head.1.html">head</a>` can help. Just running:

<pre class="wp-block-preformatted">$ head filename.txt</pre>

Will get you

<blockquote class="wp-block-quote">
  <p>
    Print the first 10 lines of each FILE to standard output.
  </p>
  
  <cite>http://man7.org/linux/man-pages/man1/head.1.html</cite>
</blockquote>

But what if that file does not have nice lines? Large SQL dump files come to mind. `head` has an answer. Use the `-c` flag to print the beginning bytes of a file instead of lines. Change the command above to:

<pre class="wp-block-preformatted">$ head -c 512 filename.txt</pre>

and you will get the first 512 bytes of the file! This comes in handy when trying to see what the file looks like or figure out what kind of encoding the file is using. And don&#8217;t worry, you can do something similar on Windows using PowerShell. 

<pre class="wp-block-preformatted">PS$ Get-Content .\filename.txt -Encoding byte -TotalCount .5KB | Set-Content bytetest.txt -Encoding byte</pre>

That will place the output in a file called bytetest.txt. For more information on the Get-Content module call:

<pre class="wp-block-preformatted">PS$ Get-Help Get-Content</pre>

PS: In case you stumbled on this post and are looking for ways to figure out what encoding you are working with, might I recommend [Joel Spolsky](https://www.joelonsoftware.com/author/joelonsoftware/) &#8220;[The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/)&#8221; and Jeff Atwood&#8217;s &#8220;[There Ain&#8217;t No Such Thing as Plain Text.](https://blog.codinghorror.com/there-aint-no-such-thing-as-plain-text/)&#8221; It offers great insight into file encodings and why they matter.