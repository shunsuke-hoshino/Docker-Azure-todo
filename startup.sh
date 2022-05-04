#!/bin/sh
# startup.sh

set -e

echo "startup.sh"

if [ "$NODE_ENV" = "development" ]
then
  # develop環境の処理
  until python manage.py migrate; do
    echo "Postgres is unavailable - sleeping"
    sleep 1
  done
  >&2 echo "Postgres is up - executing command"
  python manage.py runserver 0.0.0.0:8000
else
  # それ以外の処理
  # python manage.py migrate
  python manage.py runserver 0.0.0.0:8000
fi