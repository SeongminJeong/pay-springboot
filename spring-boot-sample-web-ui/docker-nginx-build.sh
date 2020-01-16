#!/bin/bash

docker build --no-cache --build-arg APP_VERSION=1.0 -f Dockerfile-nginx  -t spring-boot/nginx:1.0 .