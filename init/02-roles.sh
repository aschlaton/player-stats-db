#!/bin/bash
set -e

# Substitute environment variable and execute SQL
sed "s/__LLM_READONLY_PASSWORD__/${LLM_READONLY_PASSWORD}/g" /docker-entrypoint-initdb.d/02-roles.sql | psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB"
