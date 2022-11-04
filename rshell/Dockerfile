FROM ubuntu
RUN apt-get update && apt-get install tor socat -y && \
    apt-get clean
COPY hello.txt /    
ENTRYPOINT [ "tor" ]


