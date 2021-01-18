---
author: nmaynes1
categories:
- Uncategorized
date: "2019-04-18T18:33:32Z"
guid: http://blog.mayn.es/?p=106
id: 106
image: /wp-content/uploads/2018/02/title_banner_2-100x47.png
tags:
- function
- python
- requests
title: A Simple Progress Bar in Python
url: /2019/04/18/a-simple-progress-bar-in-python/
---
Recently, I have been working with the <a rel="noreferrer noopener" aria-label="Requests (opens in a new tab)" href="http://docs.python-requests.org/en/master/" target="_blank">Requests</a> library in Python. I wrote a simple function to pull down a file that took more than a minute to download. While waiting for the download to complete I realized it would be nice to have some insight into the download&#8217;s progress. A quick search on StackOverflow led to an <a href="https://stackoverflow.com/questions/15644964/python-progress-bar-and-downloads/15645088#15645088" target="_blank" rel="noreferrer noopener" aria-label="excellent example (opens in a new tab)">excellent example</a>. Below is a simple way to display a progress bar while downloading a file.

<pre class="wp-block-code"><code>def download_file(url, name):
    '''
    Function takes a url and a filename, creates a request, opens a 
    file and streams the content in chunks to the file system.
    It then writes out an '=' symbol for every two percent of the total
    content length to the console.  
    '''
    filename = 'myfile_' + str(name) + '.ext'
    r = requests.get(url, stream=True)
    with open(filename, 'wb') as f:

        total_length = r.headers.get('Content-Length')

        if total_length is None:  # no content length header
            f.write(r.content)
        else:
            downloaded = 0
            total_length = int(total_length)
            for data in r.iter_content(chunk_size=4096):
                downloaded += len(data)
                f.write(data)
                done = int(50 * dl / total_length)
                sys.stdout.write("\r[%s%s]" % ('=' * done, ' ' * (50 - done)))
                sys.stdout.flush()

    return 1</code></pre>

## What&#8217;s going on?

requests.get() takes a URL and creates an HTTP request. The stream=True flag is an optional argument that can be submitted to the <a rel="noreferrer noopener" aria-label="Request class (opens in a new tab)" href="http://docs.python-requests.org/en/master/api/#requests.request" target="_blank">Request class</a>. It lets the Request know that the content should be downloaded in chunks instead of attempted to be pulled all at once. 

The response headers are then searched for the &#8216;Content-Length&#8217; attribute. We use the &#8216;Content-Length&#8217; value to calculate how much is downloaded and what is left to download. The values are then stored in variables and updated as the chunks are processed. 

The final piece to point out in this little function is the <a rel="noreferrer noopener" aria-label="iter_content()  (opens in a new tab)" href="http://docs.python-requests.org/en/master/api/#requests.Response.iter_content" target="_blank">iter_content() </a>method. iter_content():

<blockquote class="wp-block-quote">
  <p>
    Iterates over the response data. When stream=True is set on the request, this avoids reading the content at once into memory for large responses. The chunk size is the number of bytes it should read into memory.
  </p>
</blockquote>

This helps handle larger files and gives us a way to track progress. As chunks are processed, variables can be updated. If you do not need or want to roll your own, check out the `<a href="https://github.com/tqdm/tqdm">tdqm</a>` [library](https://github.com/tqdm/tqdm).