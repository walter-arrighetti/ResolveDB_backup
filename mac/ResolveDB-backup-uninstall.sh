#!/bin/bash
launchctl unload /Library/LaunchAgents/local.ResolveDB_backup.plist
rm /Library/LaunchAgents/local.ResolveDB_backup.plist
rm /usr/local/bin/ResolveDB_backup.sh
