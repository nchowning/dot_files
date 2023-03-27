FROM ubuntu:22.04

ARG version=12

USER root
RUN apt-get update && apt-get upgrade --yes && apt-get install curl --yes
RUN curl https://apt.releases.teleport.dev/gpg -o /usr/share/keyrings/teleport-archive-keyring.asc
COPY teleport.list /etc/apt/sources.list.d/teleport.list
RUN sed -i "s/VERSION/${version}/" /etc/apt/sources.list.d/teleport.list

RUN apt-get update && apt-get install teleport --yes
