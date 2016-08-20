#!/bin/bash

if ( docker ps -a -f name=mysql -q ); then
   docker start mysql \
      && docker exec mysql /etc/init.d/mysql start
else
   docker run -di --name=mysql -p 3306:3306 luanoliveira/mysql:1.0 \
      && docker exec mysql /etc/init.d/mysql start
fi

if ( docker ps -a -f name=apache-php -q ); then
   docker start apache-php \
      && docker exec apache-php /etc/init.d/apache2 start
else
   docker run -di --name=apache-php -p 8000:80 -v ~/www:/var/www/html --link=mysql:mysql luanoliveira/apache-php:1.0 \
      && docker exec apache-php /etc/init.d/apache2 start
fi
