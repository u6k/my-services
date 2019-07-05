#!/bin/bash -eu

source /home/u6k/.env

/usr/local/bin/pg_rman_stocks.sh backup --backup-mode=incremental --with-serverlog --compress-data --verbose
/usr/local/bin/pg_rman_stocks.sh validate

echo "rsync to raspi"
rsync -av -e "ssh -p 64330 -i /root/.ssh/id_rsa_job" ${DOCKER_VOLUMES}/stocks/backup/ u6k@s3.u6k.me:/mnt/data/backup/stocks/backup/
rsync -av -e "ssh -p 64330 -i /root/.ssh/id_rsa_job" ${DOCKER_VOLUMES}/stocks/wal_archive/ u6k@s3.u6k.me:/mnt/data/backup/stocks/wal_archive/
