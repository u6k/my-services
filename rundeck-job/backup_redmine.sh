#!/bin/sh

BUILD_TIMESTAMP=$(date +%Y%m%d-%H%M%S)

WORK_DIR=$(mktemp -d)
cd $WORK_DIR

# dump data
docker exec ${RD_OPTION_DB_CONTAINER_NAME} pg_dump -U ${RD_OPTION_DB_USER} ${RD_OPTION_DB_NAME} >redmine.${BUILD_TIMESTAMP}.psql.dmp
7z a -t7z -mx=9 redmine.${BUILD_TIMESTAMP}.psql.dmp.7z redmine.${BUILD_TIMESTAMP}.psql.dmp
rm redmine.${BUILD_TIMESTAMP}.psql.dmp

docker cp ${RD_OPTION_APP_CONTAINER_NAME}:/usr/src/redmine/files/ attachement-file/

# upload to s3
aws --endpoint-url ${AWS_S3_ENDPOINT} s3 sync . s3://${RD_OPTION_AWS_S3_BUCKET}/
