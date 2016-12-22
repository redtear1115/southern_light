---
layout: post
title:  "Postgres Setup"
date:   2016-12-22 11:00:00 +0800
categories: deployment
---
## Intro
Postgres is an open source database management software. It has been widely using on lots projects.
This post will introduce some useful notes such as install, create user and remote access.

## Environment
* OS: Ubuntu 16.04.1 LTS
* Postgres: 9.5

## Install
      sudo apt-get install postgresql

## Very first login
After installation, you will have a new service named postgresql, which will autorun after reboot.
If you have a user named postgres in your OS, you could login as postgres and simply run

      bash> psql

If you doesn't want to create an user for postgres, follow below steps.

#### let postgres login with trust
Find out pg\_hba.conf. It would be /etc/postgresql/9.5/main/pg\_hba.conf by default. Modify following line: peer => trust

      # Database administrative login by Unix domain socket
      local   all             postgres                                trust

#### restart serveice
      bash> sudo service postgresql restart

#### login psql locally
      bash> psql -U postgres -t postgres

#### alter password
Since it's insecure for let database admin login without any password. We should setup password for postgres by following sql.

      psql> ALTER USER postgres PASSWORD 'YOUR_PASSWORD';

#### let postgres login with password
Back to pg\_hba.conf. Modify following line: trust => md5. **Don't forget to restart service**

      # Database administrative login by Unix domain socket
      local   all             postgres                                md5

#### login psql with password
      bash> psql -U postgres -t postgres -W


## Remote Access
PostgreSQL default only accept local connection. If you want to access it by remote, follow below steps.

#### let postgres listen all addresses (or certain address)
Find out postgresql.conf. It would be /etc/postgresql/9.5/main/postgresql.conf by default. Unmark and modify following line: localhost ==> *

      listen_addresses = '*'

#### let postgres accept remote access
Go to pg\_hba.conf. Add following line.  **Don't forget to restart service**

      host    all             postgres        YOUR_IP/32          md5


#### login psql remotely
      bash> psql -h SERVER_IP -p 5432 -U postgres -t postgres -W

## Ending
Thanks for reading! See you next time. haha
