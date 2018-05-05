#!/bin/sh

BUILD_TIMESTAMP=$(date +%Y%m%d-%H%M%S)

WORK_DIR=$(mktemp -d)
cd $WORK_DIR

# dump data
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:download_stocks[${RD_OPTION_MISSING_ONLY}]
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:import_stocks
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:download_stock_prices[${RD_OPTION_TICKER_SYMBOL},${RD_OPTION_YEAR},${RD_OPTION_MISSING_ONLY}]
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:import_stock_prices[${RD_OPTION_TICKER_SYMBOL},${RD_OPTION_YEAR}]
