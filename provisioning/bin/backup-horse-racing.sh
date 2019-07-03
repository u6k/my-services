#!/bin/bash -eu

source /home/u6k/.env

/usr/local/bin/pg_rman_horse_racing.sh backup --backup-mode=incremental --with-serverlog --compress-data
/usr/local/bin/pg_rman_horse_racing.sh validate

echo "rsync to raspi"
rsync -av -e "ssh -p 64330 -i /root/.ssh/id_rsa_job" ${DOCKER_VOLUMES}/db_horse_racing/backup/ u6k@s3.u6k.me:/mnt/data/backup/horse-racing/backup/
rsync -av -e "ssh -p 64330 -i /root/.ssh/id_rsa_job" ${DOCKER_VOLUMES}/db/wal_archive/ u6k@s3.u6k.me:/mnt/data/backup/horse-racing/wal_backup/
