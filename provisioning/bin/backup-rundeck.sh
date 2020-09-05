#!/bin/bash -eu

source /home/u6k/.env

echo "rsync to raspi"
rsync -av -e "ssh -p 64330 -i /root/.ssh/id_rsa_job" ${DOCKER_VOLUMES}/rundeck/ u6k@s3.u6k.me:/mnt/data/backup/rundeck/
