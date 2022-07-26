#!/bin/bash
set -e

APP_PATH="/usr/src/app"

# 임시 파일 제거
echo "Cleaning temp files"
rm -rf $APP_PATH/tmp/pids/server.pid
echo "done"

# first install
#echo "Rails database setting"
#rails db:create
#rails db:migrate

echo "Rails database setting done"

exec "$@"