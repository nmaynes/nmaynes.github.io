---
author: nmaynes1
categories:
- Uncategorized
date: "2020-01-30T22:35:08Z"
guid: http://blog.mayn.es/?p=184
id: 184
image: /wp-content/uploads/2020/01/jonathon-young-hYDBcGGXrUo-unsplash-1568x1045.jpg
title: Search for a String in a list of Encrypted Values
url: /2020/01/30/search-for-a-string-in-a-list-of-encrypted-values/
---
Imagine a scenario where one party wants to check whether a name they have exists in a list of names kept by the another party. But I do not want the other party to know what name I am searching. This problem may seem unrealistic but imagine a data breach where tons of personal information is leaked. You want to check whether you were impacted in the breach but do not trust the party hosting the personal information to keep your query safe. This is possible with the help of homomorphic encryption, specifically [Paillier](https://en.wikipedia.org/wiki/Paillier_cryptosystem) encrytption. 

Python provides library that will allow you to use the Paillier system, an additive [homomorphic cryptosystem](https://en.wikipedia.org/wiki/Homomorphic_encryption), to perform arithmetic on encrypted integers. It is called [phe](https://python-paillier.readthedocs.io/en/stable/usage.html#usage). So if we want to search a list of names to see whether it includes &#8220;nathan&#8221; we need to convert our python strings to binary. Once those values are converted to binary, we need to encrypt the values using a public or private key. For the purposes of this example, let&#8217;s assume I am reaching out to a service that has encrypted information and I want to check my value against their encrypted values. Once our value is encrypted with the service&#8217;s public key, we can check whether the difference between our encrypted value and the values provided by the service is equal to zero. If it is, we got a hit! 

Start a python console which has access to the standard library and `phe`. `pip install phe` should work if you have not installed the library already. Follow along in your console session.

Generate the public/private keypair

<pre class="wp-block-code"><code>>>> import binascii
>>> from phe import paillier
>>> public_key, private_key = paillier.generate_paillier_keypair()</code></pre>

Create binary versions of our strings and put them in a list. For more information on working with ascii to binary see the documentation for [binascii](https://docs.python.org/3/library/binascii.html).

<pre class="wp-block-code"><code>>>> n1 = binascii.crc32(b"nathan")
>>> n2 = binascii.crc32(b"nathan")
>>> n3 = binascii.crc32(b"Nathan")
>>> name_list = &#91;n1, n2, n3]</code></pre>

Encrypt the values:

<pre class="wp-block-code"><code>>>> encrypted_list = &#91;public_key.encrypt(x) for x in name_list]
>>> encrypted_list&#91;0]
&lt;phe.paillier.EncryptedNumber object at 0x00000209D238AC18>
>>> d1 = private_key.decrypt(encrypted_list&#91;0])
>>> d1
1394289310
>>> d1 == n1
True
>>> d1 - n1
0</code></pre>

Now we can perform operations on encrypted values. Notice how with our list, values 0 and 1 are equal but 1 and 2 are not.

<pre class="wp-block-code"><code>>>> encrypted_list&#91;0] - encrypted_list&#91;1]
&lt;phe.paillier.EncryptedNumber object at 0x00000209D2383128>
>>> n12_compare = encrypted_list&#91;0] - encrypted_list&#91;1]
>>> private_key.decrypt(n12_compare)
0
>>> n13_compare = encrypted_list&#91;0] - encrypted_list&#91;2]
>>> private_key.decrypt(n13_compare)
-27002122</code></pre>

The next thing to demonstrate is search the encrypted values for a hidden value. This would likely not be decrypted client side, instead, the encrypted values would be sent back to the service and decrypted. The service would receive a bunch of encrypted numbers that did not mean anything to them. They would decrypt and return the results which could be decoded. In this example we subtract our search value from the encrypted one for simplicity&#8217;s sake. We are looking for 0 which indicates a hit.

<pre class="wp-block-code"><code>>>> search_value = public_key.encrypt(n1)
>>> results = &#91;private_key.decrypt(i - search_value) for i in encrypted_list]
>>> results
&#91;0, 0, 27002122]</code></pre>

This exercise is pretty straight forward, a toy example. The real world uses for this are still developing and research around homomorphic encryption is actively growing. Please let me know if you have any other examples of asymmetric cryptosystems in the real world, I would love to hear about them!