#! /bin/sh

# Wait for MySQL
until nc -z -v -w30 $DB_HOST $DB_PORT; do
 sleep 1
done
echo "MySQL is up and running!"