#!/bin/bash -eu

curl -v -f \
    -u $RD_OPTION_AUTH_USER:$RD_OPTION_AUTH_PASS \
    https://local-horse-racing-trader.u6k.me/api/health
