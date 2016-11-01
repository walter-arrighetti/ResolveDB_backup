#!/bin/bash
echo.
echo **********************************************
echo **  PosgreSQL Backup script for Blackmagic  **
echo **  Design DaVinci Resolve Studio database  **
echo **==========================================**
echo **   Copyright (C) 2016 Walter Arrighetti   **
echo **********************************************
echo.
PGDumpAll=$(which pg_dumpall)
ResolveDBpath=/home/posgres/ResolveDB_backup/
ResolveDBnetpath=/mnt/NAS/ResolveDB_backup/
DOM=$(date +%d)
DOW=($($DOM % 7)) |sed 's/^0*//'
echo Dumping all the PostgreSQL database for week day No.$DOW.....
$PGDumpAll  --oids  --username=postgres  --file=$ResolveDBpath/$DOW.pgSQL
echo [  OK  ]
echo Generating a second (compressed) copy of this backup.....
gzip  $ResolveDBpath/$DOW.pgSQL
rsync  -Pav  $ResolveDBpath/$DOW.*  $ResolveDBnetpath/
