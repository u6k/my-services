#!/bin/sh -eu

docker run --rm \
           --net production \
           --name crawl-stocks \
           -e APP_LOGGER_LEVEL=INFO \
           u6kapps/investment-stocks-crawler $1 \
             --s3-access-key=${S3_ACCESS_KEY} \
             --s3-secret-key=${S3_SECRET_KEY} \
             --s3-region=${S3_REGION} \
             --s3-bucket=${S3_BUCKET} \
             --s3-endpoint=${S3_ENDPOINT} \
             --s3-force-path-style=${S3_FORCE_PATH_STYLE} \
             --s3-object-name-prefix=${S3_OBJECT_NAME_PREFIX} \
             --db-database=${DB_DATABASE} \
             --db-host=${DB_HOST} \
             --db-port=${DB_PORT} \
             --db-username=${DB_USERNAME} \
             --db-password=${DB_PASSWORD} \
             --entrypoint-url $2
