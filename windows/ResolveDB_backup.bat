@Echo OFF
Echo.
Echo **********************************************
Echo **  PosgreSQL Backup script for Blackmagic  **
Echo **  Design DaVinci Resolve Studio database  **
Echo **==========================================**
Echo **   Copyright (C) 2016 Walter Arrighetti   **
Echo **********************************************
Echo.
Set ResolveDBpath=C:\Users\Default\Documents\
Set ResolveDBnetpath=\\NAS\ResolveDB\
dir %ResolveDBnetpath% >> dirL.out
del dirL.out
FOR /F %%a in ('WMIC Path Win32_LocalTime Get DayOfWeek /format:list ^| findstr "="') DO (set %%a)
Echo Dumping all the PostgreSQL database for %DayOfWeek%th day of current week.....
"C:\Program Files\PostgreSQL\9.2\bin\pg_dumpall.exe" --oids --username=postgres --file=%ResolveDBpath%\%DayOfWeek%.pgSQL
Echo [  OK  ]
Echo Generating a second (compressed) copy of this backup.....
"C:\Program Files\7-Zip\7z.exe"  a  %ResolveDBpath%\%DayOfWeek%.7z  %ResolveDBpath%\%DayOfWeek%.pgSQL
Move  /Y  %ResolveDBpath%\%DayOfWeek%.7z  %ResolveDBnetpath%
Echo [  OK  ]
