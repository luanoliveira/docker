#!/bin/bash

if [ $(docker ps -f name=apache-php -q) ]; then
    docker kill apache-php
fi

if [ $(docker ps -a -f name=apache-php -q) ]; then
    docker rm apache-php
fi

if [ $(docker ps -f name=mysql -q) ]; then
    docker kill mysql
fi

if [ $(docker ps -a -f name=mysql -q) ]; then
    docker rm mysql
fi

docker run -di --name=apache-php -v ~/www:/var/www/html luanoliveira/apache-php:1.0

docker exec apache-php /etc/init.d/apache2 start

docker run -di --name=mysql -p 3306:3306 luanoliveira/mysql:1.0

docker exec mysql /etc/init.d/mysql start

echo "FLAMENGO SEMPRE!"