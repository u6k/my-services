#!/bin/bash -eu

echo TARGET_DATE=${RD_OPTION_TARGET_DATE:=`date +%Y-%m-%d`}
echo APP_START_DATE=${APP_START_DATE:=$RD_OPTION_TARGET_DATE}
echo APP_END_DATE=${APP_END_DATE:=`date --date "$APP_START_DATE 1 day" +%Y-%m-%d`}

curl -v -f \
    -u $RD_OPTION_AUTH_USER:$RD_OPTION_AUTH_PASS \
    -H "Content-Type: application/json" \
    -d "{\"start_date\":\"$APP_START_DATE\",\"end_date\":\"$APP_END_DATE\",\"recache_race\":true}" \
    https://local-horse-racing-crawler.u6k.me/api/crawl

curl -v -f \
    -u $RD_OPTION_AUTH_USER:$RD_OPTION_AUTH_PASS \
    -H "Content-Type: application/json" \
    -d "{\"target_date\":\"$RD_OPTION_TARGET_DATE\"}" \
    https://local-horse-racing-crawler.u6k.me/api/schedule_vote_close
