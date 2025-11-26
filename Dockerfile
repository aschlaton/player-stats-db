FROM postgres:18-alpine

# Install cron
RUN apk add --no-cache dcron

# Copy backup script and make it executable
COPY backup.sh /backup.sh
RUN chmod +x /backup.sh

# Copy crontab
COPY crontab /etc/crontabs/root

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["postgres"]
