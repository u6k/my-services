#!/bin/bash -eu

curl -v -f \
    -u $RD_OPTION_AUTH_USER:$RD_OPTION_AUTH_PASS \
    -H "Content-Type: application/json" \
    -d "{\"asset\":$RD_OPTION_ASSET}" \
    https://local-horse-racing-trader.u6k.me/api/asset/reset
