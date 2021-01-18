---
author: nmaynes1
categories:
- Concepts
date: "2018-08-22T13:13:41Z"
guid: http://edgesandvertexes.com/?p=59
id: 59
image: /wp-content/uploads/2018/08/Bayes_Theorem_MMB_01-100x64.jpg
title: A Brief Introduction to Bayes&#8217; Theorem
url: /2018/08/22/a-brief-introduction-to-bayes-theorem/
---
Bayes&#8217; Theorem stated is, &#8220;the conditional probability of A given B is the conditional probability of B given A scaled by the relative probability of A compared to B&#8221;. I find it easier to understand through a practical explanation. Let&#8217;s say you are having a medical test performed at the recommendation of your doctor, who recommends tests to everyone because they get a nice kickback and college tuition is not cheap! You are young and healthy and are being tested for the existence of a new form of cancer that only exists in 1% of the population. These cancer detecting tests accurately detect the cancer 8 out of 10 times in an infected individual. However, they &#8220;detect&#8221; cancer in 1 out of 10 cancer free patients. Your test results come back positive! But before you get worried, let&#8217;s figure out the chance that you actually have cancer.

This is a job for conditional probability. You want to know the probability that the test detected cancer in you, a young healthy individual. &#8220;The chance of an event is the number of ways it could happen given all possible outcomes&#8221;[1]:

<pre>Probability = event / all possibilities</pre>

or

&nbsp;

When the result is considered in conjunction with the likelihood of other outcomes, it is not that troubling. The table below has the likelihood for each of the outcomes:

<table style="width: 100%;">
  <tr>
    <th>
    </th>
    
    <th>
      Cancer (1% of Pop.)
    </th>
    
    <th>
      No Cancer (99% of Pop.)
    </th>
  </tr>
  
  <tr>
    <td>
      Test Positive
    </td>
    
    <td>
      True Positive<br /> 1% x 80% = .8%
    </td>
    
    <td>
      False Positive<br /> 99% x 10% = 9.9%
    </td>
  </tr>
  
  <tr>
    <td>
      Test Negative
    </td>
    
    <td>
      False Negative<br /> 1% x 20% = .2%
    </td>
    
    <td>
      True Negative<br /> 99% x 90% = 89.1%
    </td>
  </tr>
</table>

&nbsp;

The chance of cancer for a true positive is only .8%! A false positive is much more likely at 9.9%. The likelihood you have cancer even with a positive test result is low. You should definitely seek a second opinion.

It is important to keep in mind that we are calculating odds of an event given **_all_** possibilities. You probably do rough versions of this calculation daily. &#8220;Given the dark rain clouds outside and rain in the forecast, I will take an umbrella since I believe it will rain while I am out.&#8221; If that is not enough to get you excited about Bayes and his contribution to statistics, know that he did it all in an effort to prove the existence of God! If you would like to learn more, check out the links below.

[1]A primer on Bayes theorem which I used as inspiration: <https://betterexplained.com/articles/an-intuitive-and-short-explanation-of-bayes-theorem/>

The peer reviewed &#8220;wiki&#8221; entry on Bayesian statistics: <http://www.scholarpedia.org/article/Bayesian_statistics>

Stanford encyclopedia of Philosophy entry on Bayes Theorem: <https://plato.stanford.edu/entries/bayes-theorem/>