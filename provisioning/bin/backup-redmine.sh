#!/bin/bash -eu

source /home/u6k/.env

/usr/local/bin/pg_rman_redmine.sh backup --backup-mode=incremental --with-serverlog --compress-data --verbose
/usr/local/bin/pg_rman_redmine.sh validate

echo "rsync to raspi"
rsync -av -e "ssh -p 64330 -i /root/.ssh/id_rsa_job" /mnt/data/backup/redmine/backup/ u6k@s3.u6k.me:/mnt/data/backup/redmine/backup/
rsync -av -e "ssh -p 64330 -i /root/.ssh/id_rsa_job" ${DOCKER_VOLUMES}/redmine/wal_archive/ u6k@s3.u6k.me:/mnt/data/backup/redmine/wal_backup/
rsync -av -e "ssh -p 64330 -i /root/.ssh/id_rsa_job" ${DOCKER_VOLUMES}/redmine/files/ u6k@s3.u6k.me:/mnt/data/backup/redmine/files/
