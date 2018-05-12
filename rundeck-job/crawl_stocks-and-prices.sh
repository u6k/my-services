#!/bin/sh

BUILD_TIMESTAMP=$(date +%Y%m%d-%H%M%S)

WORK_DIR=$(mktemp -d)
cd $WORK_DIR

# download and import
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:download_nikkei_averages[${RD_OPTION_YEAR},${RD_OPTION_MISSING_ONLY}]
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:import_nikkei_averages[${RD_OPTION_YEAR}]

docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:download_topixes[${RD_OPTION_YEAR}]
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:import_topixes[${RD_OPTION_YEAR}]

docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:download_dow_jones_industrial_averages[${RD_OPTION_YEAR}]
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:import_dow_jones_industrial_averages[${RD_OPTION_YEAR}]

docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:download_stocks[${RD_OPTION_MISSING_ONLY}]
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:import_stocks

docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:download_stock_prices[${RD_OPTION_TICKER_SYMBOL},${RD_OPTION_YEAR},${RD_OPTION_MISSING_ONLY}]
docker exec ${RD_OPTION_APP_CONTAINER_NAME} rails crawl:import_stock_prices[${RD_OPTION_TICKER_SYMBOL},${RD_OPTION_YEAR}]
