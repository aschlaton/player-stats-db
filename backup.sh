#!/bin/bash
set -e

# Backup configuration
BACKUP_DIR="/backups"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"
KEEP_BACKUPS=3

echo "Starting database backup at $(date)"

# Create backup
pg_dump -U "$POSTGRES_USER" "$POSTGRES_DB" > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "Backup created successfully: $BACKUP_FILE"

    # Get file size
    SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "Backup size: $SIZE"

    # Remove old backups, keep only the most recent 3
    BACKUP_COUNT=$(ls -1 $BACKUP_DIR/backup_*.sql 2>/dev/null | wc -l)

    if [ $BACKUP_COUNT -gt $KEEP_BACKUPS ]; then
        echo "Found $BACKUP_COUNT backups, removing old ones to keep $KEEP_BACKUPS"
        ls -1t $BACKUP_DIR/backup_*.sql | tail -n +$((KEEP_BACKUPS + 1)) | xargs rm -f
        echo "Old backups removed"
    fi

    echo "Backup completed successfully"
else
    echo "Backup failed!"
    exit 1
fi
