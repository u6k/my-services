#!/bin/bash -eu

source /home/u6k/.env

docker run --rm \
  -v "${DOCKER_VOLUMES}/stocks/db:/pg_data" \
  -v "${DOCKER_VOLUMES}/stocks/backup:/backup" \
  -e "PGHOST=${DOCKER_STOCKS_DB_HOST}" \
  -e "PGUSER=${DOCKER_STOCKS_DB_USERNAME}" \
  -e "PGPASSWORD=${DOCKER_STOCKS_DB_PASSWORD}" \
  -e "PGDATABASE=${DOCKER_STOCKS_DB_DATABASE}" \
  --net=production \
  --link "${DOCKER_STOCKS_DB_HOST}:${DOCKER_STOCKS_DB_HOST}" \
  u6kapps/docker-pg_rman $@
