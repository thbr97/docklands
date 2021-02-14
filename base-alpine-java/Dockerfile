FROM tcbweb/base:latest

# Image tcbweb/base-alpine-java

MAINTAINER Thorben Brinkmann <thorben@tcbweb.de>

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

USER root

RUN apk --update add openjdk8

USER tcbweb