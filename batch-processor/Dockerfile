FROM debian:10-slim

RUN apt-get update && apt-get install -y \
    python python-opencv libopencv-dev wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app && wget https://gitlab.com/wavexx/facedetect/-/raw/master/facedetect?inline=false -O /app/facedetect