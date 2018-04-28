FROM alpine:latest

# Image tcbweb/base-alpine-java

MAINTAINER Thorben Brinkmann <thorben@tcbweb.de>

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN apk --update add curl tar openjdk8

# Create workdir
RUN mkdir -p /opt/tcbweb

# Add system user 'tcbweb'
RUN addgroup -S tcbweb \
    && adduser -S -h /opt/tcbweb -s /bin/false -G tcbweb -D tcbweb

# Set the workdir for further operations of docker
WORKDIR /opt/tcbweb

USER tcbweb