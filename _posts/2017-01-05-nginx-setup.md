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
Nginx allowed multiple sites in one nginx server. **/etc/nginx/sites-available/** should hold all sites you set.
Furthermore, **/etc/nginx/sites-enabled/** should hold all sites you want to run. You should use [ln](https://en.wikipedia.org/wiki/Ln_(Unix)) to connect this two folders.

## Setup web socket for web application
First, we should let nginx notice your web app. In this example we are using rails 5 with puma and capistrano.
After deployment, you should find puma.sock in your PROJECT_FOLDER.
If there is not. check [puma#binding-tcp--sockets](https://github.com/puma/puma#binding-tcp--sockets).
Open **/etc/nginx/sites-available/default** and insert following code.

      upstream web_app {
        # Path to Puma SOCK file, as defined previously
        server unix://[PATH_TO_PROJECT]/shared/tmp/sockets/puma.sock fail_timeout=0;
      }


## Setup SSL certificate
If you'd like to hold a popular site, you need to buy SSL certificate.
After your purchasing, you'll get basically two files or more.
One would be public certificate, which describe information of the domain name.
Another would be the secret key, which notify certificate center that you are the owner.
Now, it's time to setup SSL certificate. Open your server configuration, in case: **/etc/nginx/sites-available/default**

      server {
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server ipv6only=on;

        ssl_certificate [PATH_TO_CERTIFICATE];
        ssl_certificate_key [PATH_TO_SECRET_KEY];
      }

## Setup log files
For me, it's good to make logs stay together. Try following settings.

      server {
        access_log /var/log/nginx/[PROJECT]-access.log;
        error_log /var/log/nginx/[PROJECT]-error.log notice;
      }

## Location management
Nginx is a powerful web server, which can let you design policy for each location.
Here are some useful cases.

### Set root as proxy to index
      location = / {
          proxy_pass http://unix:/[PATH_TO_PROJECT]/shared/tmp/sockets/puma.sock:/index/;
      }

### Block all access to pictures except localhost
      location ~* .(jpg|gif|jpeg|png|ico)$ {
        allow localhost;
        deny all;
      }

### Allow certain ip access API
      location ^~ /api/ {
        allow 192.168.1.0/24;
        deny all;
      }

## Ending
Thanks for reading! Feel free to leave questions, I am willing to reply.
