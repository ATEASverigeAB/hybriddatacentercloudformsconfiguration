#!/bin/sh

## Prerequisites
[ -d /backup                   ] || mkdir -m 777 /backup
[ -f /etc/cron.daily/backup.sh ] || cp $0 /etc/cron.daily/backup.sh

## Remove old Backups
rm -f /backup/`date -d 'last month' +%Y-%m`-*.sql

## Create new daily backup
su - postgres bash -c "pg_dump vmdb_production >/backup/`date +%Y-%m-%d.sql`"
