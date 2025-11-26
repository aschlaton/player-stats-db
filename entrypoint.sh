#!/bin/bash
set -e

# Start cron in the background
crond -b -l 2

echo "Cron started for automated backups"

# Execute the original PostgreSQL entrypoint
exec docker-entrypoint.sh "$@"
