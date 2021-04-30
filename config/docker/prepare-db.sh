#! /bin/sh

# If the database exists, migrate. Otherwise setup (create and migrate)
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:create db:migrate
echo "DB migrated and Seeded!"