#!/bin/sh

BUILD_TIMESTAMP=$(date +%Y%m%d-%H%M%S)

WORK_DIR=$(mktemp -d)
cd $WORK_DIR

# download google news rss
curl -v -L -o google-news.us.world.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=w&output=rss'
curl -v -L -o google-news.us.us.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=n&output=rss'
curl -v -L -o google-news.us.business.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=b&output=rss'
curl -v -L -o google-news.us.technology.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=tc&output=rss'
curl -v -L -o google-news.us.entertainment.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=e&output=rss'
curl -v -L -o google-news.us.sports.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=s&output=rss'
curl -v -L -o google-news.us.science.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=snc&output=rss'
curl -v -L -o google-news.us.health.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=m&output=rss'
curl -v -L -o google-news.us.spotlight.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=en&ned=us&topic=ir&output=rss'

curl -v -L -o google-news.ja.world.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=ja&ned=us&topic=w&ie=UTF-8&oe=UTF-8&output=rss'
curl -v -L -o google-news.ja.business.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=ja&ned=us&topic=b&ie=UTF-8&oe=UTF-8&output=rss'
curl -v -L -o google-news.ja.politics.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=ja&ned=us&topic=p&ie=UTF-8&oe=UTF-8&output=rss'
curl -v -L -o google-news.ja.entertainment.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=ja&ned=us&topic=e&ie=UTF-8&oe=UTF-8&output=rss'
curl -v -L -o google-news.ja.sports.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=ja&ned=us&topic=s&ie=UTF-8&oe=UTF-8&output=rss'
curl -v -L -o google-news.ja.technology.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=ja&ned=us&topic=t&ie=UTF-8&oe=UTF-8&output=rss'
curl -v -L -o google-news.ja.pickup.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=ja&ned=us&topic=ir&ie=UTF-8&oe=UTF-8&output=rss'
curl -v -L -o google-news.ja.japan.${BUILD_TIMESTAMP}.rss.xml 'http://news.google.com/news?cf=all&hl=ja&ned=us&topic=n&ie=UTF-8&oe=UTF-8&output=rss'

# upload to s3
aws --endpoint-url ${AWS_S3_ENDPOINT} s3 sync . s3://${RD_OPTION_AWS_S3_BUCKET}/
