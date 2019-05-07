#!/bin/sh -eu

WORK_DIR=`mktemp -d`
cd ${WORK_DIR}

echo "Dump redmine activity"
curl -v -o redmine-activity.`date +%Y%m%d-%H%M%S`.atom "https://redmine.u6k.me/activity.atom?key=${REDMINE_ATOM_KEY}&user_id=${REDMINE_USER_ID}"

echo "Upload to s3"
aws --profile ${S3_PROFILE} --endpoint-url ${S3_ENDPOINT} s3 sync . s3://${S3_BUCKET}

echo "Cleanup"
rm -rf ${WORK_DIR}
