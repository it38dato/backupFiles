set sSizeFile=C:\YOUR-DIR\YOUR-DB.GDB
set sLogFile=C:\YOUR-DIR\LogSize.txt
if exist "%sSizeFile%" for %%i in ("%sSizeFile%") do set sSize=%%~zi
>> %sLogFile% echo LOG %date% %time% %sSizeFile% %sSize%
