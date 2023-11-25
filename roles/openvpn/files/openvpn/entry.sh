#!/usr/bin/env bash

set -e

cleanup() {
    kill TERM "$openvpn_pid"
    exit 0
}

openvpn \
    --config /config/config.ovpn \
    --cd /config \
    --script-security 2 \
    --route-up "/usr/local/bin/killswitch.sh $ALLOWED_SUBNETS"\
    --auth-user-pass /config/pass.txt \
    &

openvpn_pid=$!
trap cleanup TERM
wait $openvpn_pid
