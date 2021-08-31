---
author: nmaynes1
categories:
- Tutorials
tags:
- hugo
- website
- hosting
title: "Moving My Personal Blog From Wordpress to Hugo"
date: 2021-08-16T11:13:00-04:00
---

I started the process of moving my personal blog over a year ago, when the global pandemic 
brought on by the COVID-19 virus sent my local area into lock down.
The reasons for doing so were simple enough, my web hosting bill had grown north of 
$200 dollars a month for my personal blog. Don't get me wrong, Wordpress is great! I just 
wanted to get my blog onto something more appropriate for the audience (read, pretty small). 

* Hosting costs for my small sites went from $50 dollars a year to over $250 dollars a year
* I no longer wanted to play with plugins
* Managing comments became tedious. Spam, spam, and more spam. 
* I wanted something simple that could be hosted on Github Pages.

I used a wordpress plugin to export my content and moved it into a Hugo site. Once I had that process completed, 
I needed to figure out how to get the site to update properly on Github. Figuring it out was pretty easy. All I needed
to do was follow the [great documentation at Hugo](https://gohugo.io/hosting-and-deployment/hosting-on-github/). The 
trickiest part of the process was updating settings to get my domain name pointing to the blog. 
I had to follow the directions of my registrar which differed slightly
from the Hugo documentation and the Github documentation. Keep that in mind if you are planning on
making the switch. 

One thing that I had to spend a bit of time troubleshooting was getting
the urls to match on my local machine and the deployed Github repository. I was 
able to solve the problem by setting the baseURL config.yaml value to:

`baseURL: /`

Instead of my first guess which was:

`baseURL: mayn.es`

This is a little theme dependant. You will know you have the same problems as I did if the CSS and images do not load. 
Check the href values and if they look similar to `href=https://mayn.es/mayn.es` you probably need
to update your baseURL setting. 

## Next Steps

I would like to add a few things to the blog. Instead of writing up a post on why or detailing
what they are, I am just going to drop a list of things that I would like to do in the future. 

- Add a [neofeed](https://neofeed.dev/)

- Connect [Webmention](https://webmention.io/) to the site.

- Join the [IndieWeb](https://indieweb.org/)