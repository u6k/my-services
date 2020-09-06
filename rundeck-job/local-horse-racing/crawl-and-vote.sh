#!/bin/bash -eu

echo crawl
curl -v -f \
    -u $RD_OPTION_AUTH_CRAWLER_USER:$RD_OPTION_AUTH_CRAWLER_PASS \
    -H "Content-Type: application/json" \
    -d "{\"start_url\":\"https://www.oddspark.com/keiba/RaceList.do?$RD_OPTION_RACE_ID\",\"recache_race\":true}" \
    https://local-horse-racing-crawler.u6k.me/api/crawl

echo vote
curl -v -f \
    -u $RD_OPTION_AUTH_TRADER_USER:$RD_OPTION_AUTH_TRADER_PASS \
    -H "Content-Type: application/json" \
    -d "{\"race_id\":\"$RD_OPTION_RACE_ID\",\"vote_cost_limit\":$RD_OPTION_VOTE_COST_LIMIT,\"dry_run\":$RD_OPTION_DRY_RUN}" \
    https://local-horse-racing-trader.u6k.me/api/vote
