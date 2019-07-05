#!/bin/bash -eu

source /home/u6k/.env

docker run --rm \
  -v "${DOCKER_VOLUMES}/horse-racing/db:/pg_data" \
  -v "${DOCKER_VOLUMES}/horse-racing/backup:/backup" \
  -e "PGHOST=${DOCKER_HORSE_RACING_DB_HOST}" \
  -e "PGUSER=${DOCKER_HORSE_RACING_DB_USERNAME}" \
  -e "PGPASSWORD=${DOCKER_HORSE_RACING_DB_PASSWORD}" \
  -e "PGDATABASE=${DOCKER_HORSE_RACING_DB_DATABASE}" \
  --net=production \
  --link "${DOCKER_HORSE_RACING_DB_HOST}:${DOCKER_HORSE_RACING_DB_HOST}" \
  u6kapps/docker-pg_rman $@
