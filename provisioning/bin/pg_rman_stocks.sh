#!/bin/bash -eu

source /home/u6k/.env
source /etc/sysconfig/backup-stocks

docker run --rm \
	-v "${DOCKER_VOLUMES}/db/data:/pg_data" \
	-v "/mnt/data/backup/db/backup:/backup" \
	-e "PGHOST=db_db_1" \
	-e "PGUSER=${DOCKER_DB_USERNAME}" \
	-e "PGPASSWORD=${DOCKER_DB_PASSWORD}" \
	-e "PGDATABASE=${DB_DATABASE}" \
	--net=production \
	--link "db_db_1:db_db_1" \
	u6kapps/docker-pg_rman $@
