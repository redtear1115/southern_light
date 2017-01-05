---
layout: post
title:  "Nginx Setup"
date:   2017-01-05 11:00:00 +0800
categories: deployment
---
## Intro
Nginx is a web server, which can also be used as a reverse proxy, load balancer and HTTP cache...
This post will introduce some useful notes such as install, setup ssl and block certain route by IP address

## Environment
* OS: Ubuntu 16.04.1 LTS
* Nginx: 1.10.0

## Install
      sudo apt-get install nginx

## Default
After installation, you can visit [localhost](http://localhost) via your browser *(such as: Chrome, Firefox or Safari)* and find the nginx welcome page.
Which located at **/var/www/html/**. You can also check the default setting at **/etc/nginx/sites-enabled/default**.
If you are using amazon ec2 and allowing all IP address to access 80 port, your pages are opened to every body on the world.
Additionally, it also set up a service on the OS. It means every time you reboot, nginx will be executed as daemon automatically.

## Setup SSL

## Block

## Ending
Thanks for reading! Feel free to leave questions, I am willing to reply.
