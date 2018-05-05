#!/bin/sh

cd ${RDECK_BASE}/projects
aws --endpoint-url ${AWS_S3_ENDPOINT} s3 sync . s3://${RD_OPTION_AWS_S3_BUCKET}/projects

cd ${RDECK_BASE}/server/data
aws --endpoint-url ${AWS_S3_ENDPOINT} s3 sync . s3://${RD_OPTION_AWS_S3_BUCKET}/data

cd ${RDECK_BASE}/var/logs
aws --endpoint-url ${AWS_S3_ENDPOINT} s3 sync . s3://${RD_OPTION_AWS_S3_BUCKET}/logs
