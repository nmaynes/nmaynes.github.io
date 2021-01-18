---
author: nmaynes1
categories:
- Tutorials
date: "2020-08-01T03:02:22Z"
guid: http://blog.mayn.es/?p=208
id: 208
image: /wp-content/uploads/2020/08/avi-waxman-Lq9vlEn8Cl8-unsplash-1568x936.jpg
tags:
- API
- concurrent
- python
- REST
title: Speed Up Your REST Workflows with asyncio
url: /2020/08/01/speed-up-your-rest-workflows-with-asyncio/
---
I have been waiting for a project that would allow me to dig into the Python&#8217;s [asyncio](https://docs.python.org/3/library/asyncio.html) library. Recently, such a project presented itself. I was tasked with hitting a rate limited REST API with just under 4 million requests. My first attempt was simple. Gather and build a block of search queries, POST each one to the API, process the results, and finally insert them in a database. Here is what the code looked like: 

<pre class="wp-block-code"><code>import json

import requests
import pandas as pd

from external.module import Pipeline

HEADERS = {"Accept": "application/JSON",
           "Authorization": "Bearer-token",
           "Content-Type": "application/json"}

// Instantiate and override an external module
// This loads the database connection methods that are used
class ApiConnector(External.Module):
    def location_from_id(self, request_id):
        return self.request.get(f"https://rate-limited-api.com/api/v2/entities/{request_id}?select=id,label,location",
                                headers=HEADERS)

def main():

    start = 0
    batch_size = 10000

    try:
        pipe = Pipeline()
        pipe.connect_to_snowflake()
        rest_api = ApiConnector()
        pipe.paramstyle = 'qmark'
        cur = pipe.cursor
        cur.arraysize = batch_size
        for offset in range(start, 4000000, batch_size):
            sql = f"""select ID
                from MASTER_TABLE
                limit {batch_size} offset {offset}"""
            cur.execute(sql)

            // Allocate Lists to store the results

            ids = &#91;]
            labels = &#91;]
            admin_labels = &#91;]
            addresses = &#91;]
            cities = &#91;]
            postalcodes = &#91;]
            countries = &#91;]
            lats = &#91;]
            longs = &#91;]

            for result in cur.fetchmany():

                for id in result:
                    api_response = rest_api.location_from_id(i)
                    response_json = json.loads(api_response.text)

                    // Check whether a location entry exists for processing
                    if response_json.get('location') is not None:
                        labels.append(response_json.get('label', None))
                        ids.append(id)
                        admin_labels.append(response_json&#91;'location'].get('geoLabel', None))
                        addresses.append(response_json&#91;'location'].get('streetAddress', None))
                        cities.append(response_json&#91;'location'].get('cityLabel', None))
                        postalcodes.append(response_json&#91;'location'].get('postalCode', None))
                        countries.append(response_json&#91;'location'].get('countryLabel', None))
                        lats.append(response_json&#91;'location'].get('latitude', None))
                        longs.append(response_json&#91;'location'].get('longitude', None))

            results_df = pd.DataFrame.from_dict(
                {"ID": ids,
                 "LABEL": labels,
                 "GEO_LABEL": admin_labels,
                 "CITY_LABEL": cities,
                 "POSTAL_CODE": postalcodes,
                 "COUNTRY_LABEL": countries,
                 "LATITUDE": lats,
                 "LONGITUDE": longs,
                 "STREET_ADDRESS": addresses,})

            pipe.put_copy_file(stage='~', file_format='SNOWFLAKE_SCHEMA.CSV_WITH_HEADER',
                               schema="MASTER_TABLES", table="STANDARDIZED_LOCATIONS",
                               file_path=None, data=results_df, timeout=100, verbose=True)



    except requests.exceptions.RequestException as e:
        print(f"ERROR:{e}")
    
    cur.close()

if __name__ == '__main__':
    main()
</code></pre>

The code above is in need of a refactor. It is slow. Why? Every time we call the API with a query, the CPU waits for the API to respond, which could take a few hundredths of a second or longer. While that may not seem like a lot of time, it really adds up. Remember, we are going to make nearly 4 million queries. To explain the problem, let&#8217;s think about how a fast food restaurant like McDonald&#8217;s works. 

McDonalds makes burgers concurrently. That means they work on more than one burger at a time. Imagine how long it could take if they waited to start an order until the previous order was complete. What happens when an ingredient goes missing? All of the upcoming orders in the queue are stuck waiting for the missing ingredient! That is not efficient. McDonald&#8217;s breaks the burger making process into small, repeatable processes. Grill station, condiment station, wrapping station, etc. The code above suffers from the need to complete an HTTP request before moving on to the next. asyncio can break that process into concurrent tasks which will complete much faster.

I am not going to explain everything about asyncio. Event loops, coroutines, futures, work queues are all words that can scare off developers who have yet to encounter concurrent workflows. For more details on concurrency, threads, and asyncio check out the [asyncio developer documentation](https://docs.python.org/3/library/asyncio-dev.html#concurrency-and-multithreading), [RealPython&#8217;s post on AsyncIO](https://realpython.com/async-io-python/#async-io-design-patterns), or the [excellent chapter](http://pages.cs.wisc.edu/~remzi/OSTEP/threads-intro.pdf) from _Operating Systems in Three Easy Pieces, &#8220;Concurrency and Threads.&#8221;_ Instead, I will attempt to explain why running these API requests concurrently is a good idea and something you too could implement. 

Lets change the code to use asyncio for the HTTP requests. We will change the function responsible for calling the API to an asynchronous function and add the keyword pair async/await to a few locations. This change in code is because we need to convert functions to [**coroutine** **functions**](https://docs.python.org/3/library/asyncio-task.html#awaitables) ****and then await the execution of each coroutine. The relevant changes are included below.

<pre class="wp-block-code"><code>...
// New imports
import asyncio
import aiohttp

...
async def call_api(session, fid):
    async with session.get(f"https://rate-limited-api.com/api/v2/entities/{fid}/?select=id,label,location"
                                   ) as response:
        return await response.text()

...

async def main():

    ...

    try:
    ...
            // Change the connection to use the aiohttp version which is non-blocking
            // Set a limit appropriate for the API
            conn = aiohttp.TCPConnector(limit=100)

            // Use the keyword async with a context manager for the aiohttp.ClientSession
            async with aiohttp.ClientSession(connector=conn, headers=HEADERS, trust_env=True) as session:
                for fid in cur.fetchmany():

                    tasks.append(call_api(session, fid&#91;0]))
                // Use the partner keyword await to allow the program to 
                // "gather" the tasks for further processing.
                concurrent_responses = await asyncio.gather(*tasks)
                for cr in concurrent_responses:
                    ...
                    // process responses
                    ...

if __name__ == "__main__":

    // Create an event loop and add the function main() to it.
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())

    // Or even better if you are using Python > 3.7
    asyncio.run(main())</code></pre>

The updated code defines the functions that were previously waiting on network responses as **awaitable coroutine functions**. Notice we had to use different libraries for http objects. The http module in the standard library is blocking and not appropriate for asyncio, so we use aiohttp. We also use the keyword **gather** to collect the coroutines that were awaited. What does **gather** do?

<blockquote class="wp-block-quote">
  <p>
    Run <a href="https://docs.python.org/3/library/asyncio-task.html#asyncio-awaitables">awaitable objects</a> in the <em>aws</em> sequence <em>concurrently</em>.
  </p>
  
  <p>
    If any awaitable in <em>aws</em> is a coroutine, it is automatically scheduled as a Task.
  </p>
  
  <p>
    If all awaitables are completed successfully, the result is an aggregate list of returned values. The order of result values corresponds to the order of awaitables in <em>aws</em>.
  </p>
  
  <p>
    If <em>return_exceptions</em> is <code>False</code> (default), the first raised exception is immediately propagated to the task that awaits on <code>gather()</code>. Other awaitables in the <em>aws</em> sequence <strong>won’t be cancelled</strong> and will continue to run.
  </p>
  
  <cite>https://docs.python.org/3/library/asyncio-task.html#asyncio.gather</cite>
</blockquote>

In short, it simplifies handling coroutines. 

The new code runs much faster than the first attempt. It processes blocks of 10,000 requests in seconds instead of minutes. 

With great power comes added responsibility. Debugging asyncio programs is less straight forward than adding inline print statements. Use of the logging library and asyncio&#8217;s DEBUG functionality will really help when developing concurrent programs. Take care to not overwhelm webservers. Seriously. Understand the terms of use and follow the limits provided by the provider. 

Using asyncio makes writing concurrent programs much simpler than juggling system calls yourself. A few code changes will improve performance for almost any operation that is I/O bound. The library is a powerful one and I have only scratched its surface. I encourage you to check out the resources linked to in the article to learn more.