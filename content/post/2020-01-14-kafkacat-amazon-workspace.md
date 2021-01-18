---
author: nmaynes1
categories:
- Uncategorized
date: "2020-01-14T16:16:49Z"
guid: http://blog.mayn.es/?p=167
id: 167
image: /wp-content/uploads/2020/01/DSC09713-1568x1042.jpg
tags:
- amazon
- aws
- epel
- kafka
- linux
- workspace
title: Kafkacat Amazon Workspace
url: /2020/01/14/kafkacat-amazon-workspace/
---
Below are some notes on getting `<a href="https://github.com/edenhill/kafkacat#build">kafkacat</a>` installed on an Amazon workspace with admin access. 

The commands listed on the [GitHub page](https://github.com/edenhill/kafkacat) will not work without a little preparation. A Linux Amazon Workspace image is based on Amazon Linux. Attempts to use a package manager like `yum` go through a plugin, `amzn_workspaces_filter_updates`. This filter only has a handful of packages (30 at the time of this writing) that can be pulled. The first thing to do is add Extra Packages for Enterprise Linux, EPEL, to the instance&#8217;s package repository. Following the instructions on the [Fedora FAQ](https://fedoraproject.org/wiki/EPEL/FAQ#How_can_I_install_the_packages_from_the_EPEL_software_repository.3F) run:

<pre class="wp-block-preformatted">su -c 'rpm -Uvh https://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm' ... (stdout) </pre>

This will add the EPEL repository to Amazon Workspace which allows you to download standard Linux packages that you may miss in a stock Workspace installation. For example, if you want to connect to another machine through VPN, you can install `vpnc` with yum:

<pre class="wp-block-preformatted">sudo yum install vpnc</pre>

In order to get `kafkacat` installed, which enables the Amazon Workspace to connect to a kafka queue. A few changes to the steps outlined in the [Confluent documentation](https://docs.confluent.io/3.1.2/installation.html#installation-yum) will allow a user with elevated privileges to install the package. The first step is to add the Confluent package repository to your list of yum repos. This can be done by adding the repositories to the `/etc/yum.repos.d/` directory in a file named `confluent.repo`. 

<pre class="wp-block-preformatted">$ sudo vim /etc/yum.repos.d/confluent.repo</pre>

Insert the following text into the file:

<pre class="wp-block-preformatted">[Confluent.dist]
name=Confluent repository (dist)
baseurl=http://packages.confluent.io/rpm/3.1/7
gpgcheck=1
gpgkey=http://packages.confluent.io/rpm/3.1/archive.key
enabled=1

[Confluent]
name=Confluent repository
baseurl=http://packages.confluent.io/rpm/3.1
gpgcheck=1
gpgkey=http://packages.confluent.io/rpm/3.1/archive.key
enabled=1</pre>

Then clear the yum caches:

<pre class="wp-block-preformatted">$ sudo yum clean all</pre>

The `kafkacat` library has a dependency that can be installed from the Confluent repo called `librdkafka-devel`. Install that dependency with `yum` and then you can build the `kafkacat` library from source.

<pre class="wp-block-preformatted">$ sudo yum install librdkafka-devel </pre>

To build `kafkacat` follow the instructions on the Github README section on [building from source](https://github.com/edenhill/kafkacat#build). Clone the repository to the desired location.

<pre class="wp-block-preformatted">$ git clone https://github.con/edenhill/kafkacat.git
$ cd kafkacat/
$ ./configure
checking for OS or distribution… ok (Amazon)
 checking for C compiler from CC env… failed
 checking for gcc (by command)… ok
 checking executable ld… ok
 checking executable nm… ok
 checking executable objdump… ok
 checking executable strip… ok
 checking for pkgconfig (by command)… ok
 checking for install (by command)… ok
 checking for rdkafka (by pkg-config)… ok
 checking for rdkafka (by compile)… ok (cached)
 checking for librdkafka metadata API… ok
 checking for librdkafka KafkaConsumer support… ok
 checking for yajl (by pkg-config)… failed
 checking for yajl (by compile)… failed (disable)
 checking for avroc (by pkg-config)… failed
 checking for avroc (by compile)… failed (disable)
 Generated Makefile.config
...
$ make
cc -MD -MP -g -O2 -Wall -Wsign-compare -Wfloat-equal -Wpointer-arith -Wcast-align  -c kafkacat.c -o kafkacat.o
 gcc -MD -MP -g -O2 -Wall -Wsign-compare -Wfloat-equal -Wpointer-arith -Wcast-align  -c format.c -o format.o
 gcc -MD -MP -g -O2 -Wall -Wsign-compare -Wfloat-equal -Wpointer-arith -Wcast-align  -c tools.c -o tools.o
 Creating program kafkacat
 gcc -g -O2 -Wall -Wsign-compare -Wfloat-equal -Wpointer-arith -Wcast-align  kafkacat.o format.o tools.o -o kafkacat -lrdkafka  
$ make install
 Install kafkacat to /usr/local
 install -d $DESTDIR/usr/local/bin && \
 install kafkacat $DESTDIR/usr/local/bin 
 echo install -d $DESTDIR/usr/local/man/man1 && \
 echo install kafkacat.1 $DESTDIR/usr/local/man/man1
 install -d /usr/local/man/man1
 install kafkacat.1 /usr/local/man/man1</pre>

To verify the installation worked correctly, run:

<pre class="wp-block-preformatted">$ kafkacat --help</pre>

If everything went smoothly, the program should be installed and available on your Linux based Amazon Workspace.