#!/bin/bash
cp ResolveDB_backup.sh /usr/local/bin/
chmod 775 /usr/local/bin/ResolveDB_backup.sh
crontab -l |{ cat; echo "0 2 * * * /usr/local/bin/ResolveDB_backup.sh"; } |crontab -
