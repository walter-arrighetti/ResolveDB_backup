#!/bin/bash
crontab -l |{ cat; echo "0 2 * * * /usr/local/bin/ResolveDB_backup.sh"; } |crontab -
