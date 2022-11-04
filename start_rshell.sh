#!/bin/bash
cd ./rshell
docker build -t rshell-tor/socat .
docker run -d --name rshell rshell-tor/socat
docker exec -it rshell /bin/bash
