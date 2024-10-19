#!/usr/bin/env bash

xhost +local:docker

docker stop $(docker ps -q)
docker rm $(docker ps -a -q)

docker-compose up --abort-on-container-exit
