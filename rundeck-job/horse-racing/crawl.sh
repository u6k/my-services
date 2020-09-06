#!/bin/bash -eu

curl -v -f \
    -u $RD_OPTION_AUTH_USER:$RD_OPTION_AUTH_PASS \
    -H "Content-Type: application/json" \
    -d "{\"start_url\":\"$RD_OPTION_START_URL\",\"start_date\":\"$RD_OPTION_START_DATE\",\"end_date\":\"$RD_OPTION_END_DATE\",\"recache_race\":$RD_OPTION_RECACHE_RACE,\"recache_horse\":$RD_OPTION_RECACHE_HORSE}" \
    https://horse-racing-crawler.u6k.me/api/crawl
