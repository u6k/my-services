#!/bin/sh -eu

WORK_DIR=`mktemp -d`
cd ${WORK_DIR}

echo "Dump github activity"
curl -v -o github-contributions.`date +%Y%m%d-%H%M%S`.atom "https://github-contributions-api.now.sh/v1/${GITHUB_USER_ID}"

echo "Upload to s3"
aws --profile ${S3_PROFILE} --endpoint-url ${S3_ENDPOINT} s3 sync . s3://${S3_BUCKET}

echo "Cleanup"
rm -rf ${WORK_DIR}
