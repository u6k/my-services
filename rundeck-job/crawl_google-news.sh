#!/bin/sh

BUILD_TIMESTAMP=$(date +%Y%m%d-%H%M%S)

WORK_DIR=$(mktemp -d)
cd $WORK_DIR

# download google news rss
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:download_rss
