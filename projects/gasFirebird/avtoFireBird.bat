@echo BackUP SDP %date% START
@ echo off
set gbak="C:\tdir\FireBird_1_5\bin\GBAK.EXE"
set sdpdbgdb="C:\tdir\tdb.GDB"
set user=tuser
set pass=tpassword
set SDPbackupPath=c:\Back_sdp\SDPbackup_%date%
set backup_database=UNIW_%date%.gbk
set log=c:\2\log_%date%.log
title backup_database

echo ******************************************************************
net stop "Firebird Server - DefaultInstance"
md %SDPbackupPath%
copy %sdpdbgdb% %SDPbackupPath%\*.*
net start "Firebird Server - DefaultInstance"
%gbak% -b -v -g -y %log% -user %user% -pass %pass% %sdpdbgdb% %SDPbackupPath%\%backup_database%
@echo BackUP SDP %date% COMPLETE
@pause