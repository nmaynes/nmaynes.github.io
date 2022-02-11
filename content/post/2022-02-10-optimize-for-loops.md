+++
title = "Timing Execution to Help Optimize for Loops"
categories:
- Tutorials
  tags:
- python
- optimization
date = 2022-02-10T22:03:13-05:00
+++

I was working on optimizing some code that contained a series of loops. I began my analysis by running a few different versions of the program and timing each execution. The results were enlightening! I decided to share the approach with my team along with an [essay on the topic](https://www.python.org/doc/essays/list2str/) by [Guido Van Rossem](https://gvanrossum.github.io/).

- General Rules of Thumb by Which to Develop Loops
  
    - 1) Never optimize before you have proven a speed bottleneck exists. Then, only optimize the innermost loop. If you have a bunch of loops, consider breaking the function apart.
    - 2) Python incurs significant lookup charges for bytecode instructions and variable lookup, it rarely improves code to add extra conditionals/checks to a function to save a little work e.g. handling known scenarios with unpythonic case-like statements.
    - 3) Use intrinsic operations. An implied loop in `map()` is faster than an explicit for loop; An explicit for loop is faster than a while loop with a loop counter.
    
![Photo by Daniele Franchi on Unsplash](/daniele-franchi-WyJ0rahs_2k-unsplash.jpg)

### Timing Programs
Timing can help identify speed bottlenecks by comparing execution time between different approaches to the same task.
For timing small snippets of code use [timeit](https://docs.python.org/3/library/timeit.html?highlight=timeit).

For everything else there's, a Timing Decorator.

```python
from functools import wraps
from time import time_ns

def timing(f):
"""
Use functools wraps to ensure the inner function handles the
function used inside the decorator appropriately. 
We want the decorator to copy over the function name, docstring, arguments list,
etc of the inner function.

The use of time.perf_counter() enables millisecond 
pecision from epoch, avoiding some rounding errors 
that may occur with a Float data type.
"""
@wraps(f)
def wrap(*args, **kw):
    r = range(10)
    ts = time.perf_counter_ns()
    for i in r:
        f(*args, **kw); f(*args, **kw); f(*args, **kw); f(*args, **kw); f(*args, **kw)
    te = time.perf_counter_ns()
    print('func:%r took: %s nano sec' % \
      (f.__name__, te-ts))
return wrap
```    

## Helpful rules of thumb for clean, fast loops - By Example
- Ask whether you can use [built-in functions](https://docs.python.org/3.10/library/functions.html?highlight=built#map) eg `map`, `reduce`, `filter`
    - "[A] map with a built-in function beats for loop, but a for loop with in-line code beats map with a lambda function!" - [Source](https://www.python.org/doc/essays/list2str/)
- Use local variables wherever possible. Python accesses local variables much more efficiently than global variables.
    - Example using the Timing decorator from above:
```python
@timing
def gv_f1(list_):
    for item in list_:
        global_list.append(item)
@timing
def gv_f2(list_):
    local_list = []
    for item in list_:
        local_list.append(item)


gv_f1(wordlist)
func:'gv_f1' took: 233604000 nano sec

gv_f2(wordlist)
func:'gv_f2' took: 154450300 nano sec
```


The following example demonstrates how the decorator can be used to compare various functions that loop over a list of words to replace the '-' character with ''. 
The way I built a list for this example was by downloading an [English language wordlist](http://www-personal.umich.edu/~jlawler/wordlist.html), and then reading the contents of the file into a list.

```python
wordlist = []
with open('path/to/wordlist.txt', 'r', newline='\n') as f:
    for line in f.readlines():
        l = line.replace('\r\n', '')
        wordlist.append(l)``` 
            - ```python
@timing
def f1(list_):    
    l_map = map(lambda s: s.replace('-', ''), list_)
    return list(l_map)

@timing
def f2(list_):
    return [item.replace('-', '') for item in list_]
        

@timing
def f3(list_):
    l = []
    for item in list_:
        l.append(item.replace('-', ''))
    return l
  
@timing
def f4(list_):
    return [item.translate({'-': ''}) for item in list_]

import re
@timing
def f5(list_):
    return [re.sub('-', '', item) for item in list_]

f1(wordlist)
func:'f1' took: 386078600 nano sec
f2(wordlist)
func:'f2' took: 243369200 nano sec
f3(wordlist)
func:'f3' took: 306987800 nano sec
f4(wordlist)
func:'f4' took: 1471997300 nano sec
f5(wordlist)
func:'f5' took: 1957422600 nano sec
```

## Conclusion
Getting comfortable with timing techniques will help you feel more confident in the code you write. Execution time provides one input when optimizing functions. Remember to only optimize when you know there is a problem and defer optimizing until the code is working and stable.
