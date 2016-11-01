#!/bin/bash
cp local.ResolveDB_backup.sh /usr/local/bin/
cp local.ResolveDB_backup.plist /Library/LaunchAgents/
chown root:wheel /Library/LaunchAgents/local.ResolveDB_backup.plist /usr/local/bin/ResolveDB_backup.sh
chmod 755 /usr/local/bin/ResolveDB_backup.sh
chmod 644 /Library/LaunchAgents/local.ResolveDB_backup.plist
launchctl load /Library/LaunchAgents/local.ResolveDB_backup.plist
