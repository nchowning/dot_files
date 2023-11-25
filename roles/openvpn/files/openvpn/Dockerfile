FROM alpine:latest

RUN apk add --no-cache \
    bash \
    bind-tools \
    iptables \
    ip6tables \
    openvpn

COPY entry.sh /usr/local/bin
COPY killswitch.sh /usr/local/bin

ENTRYPOINT [ "entry.sh" ]
