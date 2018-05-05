FROM alpine:3.7

MAINTAINER Thorben Brinkmann <thorben@tcbweb.de>

# Update apk packages, install system tools and create workdir and user
RUN apk --update add curl tar unzip && \
    mkdir -p /opt/tcbweb && \
    addgroup -S tcbweb \
    && adduser -S -h /opt/tcbweb -s /bin/false -G tcbweb -D tcbweb

# Set the workdir for further operations of docker
WORKDIR /opt/tcbweb

USER tcbweb