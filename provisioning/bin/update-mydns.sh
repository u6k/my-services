#!/bin/bash -eu

source /home/u6k/.env

curl -v -f http://${MYDNS_USER}:${MYDNS_PASS}@www.mydns.jp/login.html
