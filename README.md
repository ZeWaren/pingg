pingg
=====

Introduction
------------
This tool performs a simple action: it prefixes calls to the ping utility of windows with `192.168.`.

Why this?
---------
At first I wanted to use a simple BATCH file. Unfortunately, when I used long sequences of pings (`ping -t`), pressing CTRL+C poped-up a very annoying dialog asking if I wanted to stop the script.

Usage
-----
	Usage : pingg x.x [original ping params]
	Will execute ping 192.168.x.x [params]

![pingg in action](https://raw.github.com/ZeWaren/pingg/master/pingg.png "pingg in action")

License
-------
Public Domain.