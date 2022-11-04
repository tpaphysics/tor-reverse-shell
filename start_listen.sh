#!/bin/bash
cd ./listen
docker build -t listen-tor/socat .
docker run -it --name listen listen-tor/socat
