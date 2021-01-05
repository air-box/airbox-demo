#/bin/bash

KV_PATH=~/air-box/keyvisor
KC_PATH=~/air-box/keycentral

export LD_PRELOAD=$KV_PATH/keyvisor.so
export KEYVISOR_DEBUG=1
export KEYCENTRAL_DEBUG=1
