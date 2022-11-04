#!/bin/bash
cd ./listen
docker rm -f $(docker ps -aq)
docker build -t listen-tor/socat .
docker run -it --name listen listen-tor/socat
