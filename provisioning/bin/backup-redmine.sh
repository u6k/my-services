#!/bin/sh -eu

WORK_DIR=`mktemp -d`
cd ${WORK_DIR}

echo "Dump db data"
SQL_FILE=redmine.`date +%Y%m%d-%H%M%S`.sql
docker exec ${DB_CONTAINER} pg_dump -U ${DB_USERNAME} ${DB_DATABASE} >${SQL_FILE}

echo "Compress db data"
7z a -mx=9 ${SQL_FILE}.7z ${SQL_FILE}
rm ${SQL_FILE}

echo "Dump files"
docker cp ${APP_CONTAINER}:/usr/src/redmine/files/ attachment-file/

echo "upload to s3"
aws --profile ${S3_PROFILE} --endpoint-url ${S3_ENDPOINT} s3 sync . s3://${S3_BUCKET}

echo "cleanup"
rm -rf ${WORK_DIR}
