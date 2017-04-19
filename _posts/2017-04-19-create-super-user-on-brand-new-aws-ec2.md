---
title:  "Create Super User on Brand New AWS EC2"
date:   2017-04-19 15:00:00 +0800
categories: deployment
---
## Intro
Say, I just create a new machine and want to deploy some projects on it.
But we only get the super user ubuntu. How can I do to create new user deployer?

## Environment
* OS: Ubuntu 16.04.2 LTS

## Create User
      sudo adduser deployer

## Grant sudo
      sudo usermod -aG sudo deployer

## Set sudo without password
      sudo vi /etc/sudoers.d/90-cloud-init-users

copy the line and change user ubuntu to deployer

## generate ssh key
      su deployer
      ssh-keygen -t rsa
      touch ~/.ssh/authorized_keys

paste your ssh key into ~/.ssh/authorized_keys, and then you can remote ssh with deployer

## Ending
Thanks for reading! Feel free to leave questions, I am willing to reply.
