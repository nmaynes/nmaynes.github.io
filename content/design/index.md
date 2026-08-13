---
title: "Design"
date: 2026-08-13T00:00:00-04:00
---

{{< riso-dropcap letter="T" scheme="warm" >}}his site runs on [Hugo](https://gohugo.io), a static site generator, and deploys to GitHub Pages via a GitHub Actions workflow that builds when changes are pushed to `main`. 
Why GitHub pages? It is free and it works with my registar. I also set the site up as an expirement so I could recommend simple GitHub pages sites to other people. Our homeowners association saves money by publishing information on a website that is also hosted on GitHub pages.


## Theme

{{< riso-dropcap letter="T" scheme="cool" >}}he site uses "offset," a custom theme I maintain as its own repository and pull in as a Git submodule. The offset theme is designed to be a lightweight theme with risograph inspired touches including dropcaps and decorative blobs. 

### The Design System

{{< riso-dropcap letter="T" scheme="warm" >}}he website's styling is small and CSS first. I wanted to design a system that would be easy to maintain and extend so the process of development had me remove a lot of functionality that I thought would be useful. For example, I developed a way to create events and display a calendar that I later removed from the theme. 
I also wanted to stay close to vanilla Hugo so anyone familiar with Hugo or Jekyll would be able to use the theme and personalize their site with a small learning curve. 

I also wanted to add Dark mode to the theme. Why? Because I noticed a lot of Hugo themes did not have a dark mode setting. 

The blobs are generated at build time. They are seeded from a hash of the page's URL, giving each blob a unique shape and offset, inspired by the imperfection of printing via a risograph printer. There are a few color schemes included in the theme to fit different aesthetic goals. Classic riso colors, fluorescent, cool, warm, and duotone colors can be applied to drop caps and decorative blobs. 
Making sure the text remains accessible was a priority. The drop cap blobs keep the underlying text real and readable by screen readers.

## Ensuring Accessibility

{{< riso-dropcap letter="E" scheme="cool" >}}xperience in Government and Non Profit sectors opened my eyes to what an accessible web experience entails. I have a small checklist to help make sure the site is accessible to a wide audience.

- A skip-to-content link on every page because keyboard and screen-reader users should not have to tab through the nav every time.
- Visible focus states on every interactive element. This has a side effect of making me think about how elements will look when they are focused.
- Decorative effects are visual only. The site's design progressively enhances so dropcaps, blobs, and color offsets are decorative only. I also wanted to give users the ability to turn the decorative elements off. Just in case someone likes my ideas but not my aesthetic.
- Layout breakpoints that scale with smaller screens and display reasonably well at high browser zoom.

For how I use AI tools developing this site, see the [AI Use Disclosure](/ai-use-disclosure/).

{{< riso-blob scheme="warm" >}}