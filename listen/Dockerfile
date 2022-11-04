FROM ubuntu
RUN apt-get update && apt-get install tor socat -y && \
    apt-get clean 
COPY torrc /etc/tor/torrc
COPY entrypoint.sh /entrypoint.sh 
ENTRYPOINT [ "/entrypoint.sh" ]


