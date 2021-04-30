#! /bin/sh

# Wait for DB services
echo "Waiting for db"
sh ./config/docker/wait-for-services.sh

# Prepare DB (Migrate - If not? Create db & Migrate)
echo "db:migrate, db:seed"
sh ./config/docker/prepare-db.sh

# Start Application
echo "Rails Server!"
rm /app/tmp/pids/server.pid
bundle exec rails s -p 3000 -b '0.0.0.0'