# ResolveDB_backup
Scripts for weekly dumps and backups of centralized Blackmagic Design *DaVinci Resolve* QPSQL database; for Windows, macOS and Linux.
N.B.: No proficiencies of SQL databases are required to use these tools !

Please only run from within the *DaVinci Resolve* database server host. For Windows and macOS, the installation of the centralized server must include the PostgreSQL software included in the installer package from Blackmagic Design and the use of the default database user `postgres`; for all OSs, these tools must be run as a superuser/administrator account (real 'root' or 'Administrator' user).

Instead, the *DaVinci Resolve Studio* clients can be deployed on *any* available operating systems. Preferably, shared media should be located in centralized or co-located storage (SAN, NAS, Cloud). Consult [Blackmagic Design *DaVinci Resolve Reference Manual*](https://www.blackmagicdesign.com/support/family/davinci-resolve-and-fusion) for instructions on media storage and path management across heterogeneous OS clients with centralized database(s).

Whatever OS is used, this script enables a task to be automatically run every day at 2:00am on the database server alone, where a complete dump of the PostgreSQL database ('QPSQL') is written in a single file and stored on a tier-1 path (usually meant to be on a freely accessible folder in the db server's local storage), pointed to by 'ResolveDBpath' variable in the `ResolveDB_backup.[sh|bat]` OS-aware scripts.

The single-dump file created as per above is called `0.pgSQL` for the first day-of-week backup (according to your server OS' locale), `1.pgSQL` for the second day-of-week, and so on up to `6.pgSQL` for the last day-of-week. These files are also compressed (using gzipped-TAR archives for Linux and macOS, or using _7-Zip_ for Windows, which must be installed beforehand).
The dumps are also copied on a tier-2 path (usually meant to be a network folder on a remote redundant file server, which at that time should be already mounted with write permissions by the script's run-as user); this path is pointed to by 'ResolveDBnetpath' variable in the `ResolveDB_backup.[sh|bat]` OS-aware scripts.

WARNING: By design, Windows version moves only the compressed copies of the dump in the tier-2 storage and keeps the uncompressed copies in tier-1 only.

Existing files are always overwritten, so only the latest 7 daily backups are retained.

*Resolve Studio* clients can be active in the meantime, although access to database might be slower for a few minutes.


Linux installation
------------------
 * Edit lines #11-12 of `ResolveDB_backup.sh` to change variables 'ResolveDBpath' and 'ResolveDBnetpath' to two paths where local and remote copies/dumps of the whole PostgreSQL database will be saved. For example (and by default), former is `/home/posgres/ResolveDB/`, while latter is on a network share `/mnt/NAS/ResolveDB_backup/`. N.B.: These paths should already exist [and be mounted]!
 * Run the command `chmod +x ResolveDB-backup-install.sh` in the folder there this script is (temporarily) hosted; the sript thus becomes executable.
 * Run script `ResolveDB-backup-install.sh` from a 'root' or similar superuser account (that both has permission to run PostgreSQL *`pg_dumpall`* binary and has write access to the paths described in the above bullet-point). This also sets a relevant cron-job up.

Windows installation
--------------------
 * Make sure your *DaVinci Resolve* server's installation included the embedded PostgreSQL toolkit from the installer EXE.
 * Install free _7-Zip_ archiver (64-bit binary) from "http://www.7-zip.org/" in the default path `C:\Program Files\7-Zip`.
 * Edit lines #10-11 of `ResolveDB_backup.bat` to change variables 'ResolveDBpath' and 'ResolveDBnetpath' to two paths where local and remote copies/dumps of the whole PostgreSQL database will be saved, respectively. For example (and by default), former is `C:\Users\Default\Documents\ResolveDB`, while latter is on a network share `\\FileServerIPaddr\NetworkShareName\ResolveDB`. N.B.: These paths should already exist and [be logged into]!
 * If needed, edit line #16 of `ResolveDB_backup.bat` to change the path and/or version number of *DaVinci Resolve* PostgreSQL database (currently it is version 9.2 for Windows).
 * Edit line #52 of `ResolveDB_backup.xml` by putting the pathname where your final version of script `ResolveDB_backup.bat` will be definitely copied in (currently is `C:\Users\Default\ResolveDB_backup.bat`). This path should not be easily accessible to standard users (to avoid unwanted file corruption/deletion).
 * Edit line #16 of `ResolveDB_backup.bat` by changing the ` "resolve" part of the --database` variable
 * Copy your modified copy of file `ResolveDB_backup.bat` in the path specified in the above bullet-point.
 * Import file `ResolveDB_backup.xml` as a _Scheduled Task_ (from an administrative account, e.g. 'Administrator'). Edit the just-imported task and re-enter run-as user credentials for an administrative account (that has permissions to run PostgreSQL *'pg_dumpall'* binary and has write access to the storage described in the third bullet-point).

macOS installation
------------------
 * Make sure your *DaVinci Resolve* server's installation included the embedded PostgreSQL toolkit from the installer DMG.
 * If needed, edit line #10 of `ResolveDB_backup.sh` to change the path and/or version number of *DaVinci Resolve* PostgreSQL database (currently it is version 8.4 for macOS).
 * Edit lines #11-12 of `ResolveDB_backup.sh` to change variables 'ResolveDBpath' and 'ResolveDBnetpath' to two paths where local and remote copies/dumps of the whole PostgreSQL database will be saved, respectively. For example (and by default), former is `/Users/Default/Documents/ResolveDB`, while latter is on a network share `/Volumes/ResolveDB_backup`. N.B.: These paths should already exist or be mounted!
 * Make sure to run installation/uninstallation scripts from 'root' user or similar superusers from the 'wheel' group. Usually macOS' default-first-user administrative privileges are not enough; consult Apple macOS documentation to enable and configure the real 'root' account.
 * If 'root' user is enabled/available (as per above bullet-point), open Terminal, type `sudo su - root`, hit Enter, then type the root password and make sure no error messages appear.
 * Make the script `ResolveDB-backup-install.sh` executable by typing command `chmod +x ResolveDB-backup-install.sh` from the path where all these files are.
 * Run the above script as `./ResolveDB-backup-install.sh` and check no error messages are output. This also configures macOS *`launchd`* daemon to run the scheduled task.
 
 
 To uninstall, repeat all the above passages related to the script `ResolveDB-backup-uninstall.[sh|bat]` instead, for the relevant server's OS.
