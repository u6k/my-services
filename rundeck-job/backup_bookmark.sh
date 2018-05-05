#!/bin/sh

BUILD_TIMESTAMP=$(date +%Y%m%d-%H%M%S)

WORK_DIR=$(mktemp -d)
cd $WORK_DIR

# dump data
docker cp ${RD_OPTION_APP_CONTAINER_NAME}:/var/lib/bookmark/hsqldb .
7z a -t7z -mx=9 bookmark.${BUILD_TIMESTAMP}.hsqldb.dmp.7z hsqldb/
rm -r hsqldb/

# upload to s3
aws --endpoint-url ${AWS_S3_ENDPOINT} s3 sync . s3://${RD_OPTION_AWS_S3_BUCKET}/
