@Echo Off
:: YOURDIR - Место храненние БЭКАПА
:: YOURIP - IP адрес ftp сервера
:: YOURUSER - имя пользователя ftp сервера
:: YOURPASSWD - пароль ftp сервера
:: ~Параметры соединения
Set server=YOURIP
Set user=YOURUSER
Set pass=YOURPASSWD
:: ~Что и куда копируем
:: SET $SRC=/Backups/Nokia/MRBTS/BS/IRK/*.xml
SET src=/Backups/MRBTS/BS/IRK
SET dst=\\YOURDIR\
:: Формат текущей даты
SET dd=%date:~0,2%
SET mm=%date:~3,2%
SET yyyy=%date:~6,4%
SET curdate=%dd%_%mm%_%yyyy%
:: ~Временные файлы
::Set $FFtp=%~dpn0.cfg
:: Готовим CFG-файл
Echo open %server%>tempfile.txt
Echo %user%>>tempfile.txt
Echo %pass%>>tempfile.txt
Echo lcd %dst%>>tempfile.txt
Echo cd %src%>>tempfile.txt
Echo mget *.xml /Y>>tempfile.txt
Echo bye>>tempfile.txt
:: Выполняем команду
FTP -s:tempfile.txt
:: Добавим в архив скопированные файлы
"C:\Program Files\7-Zip\7z.exe" a -tzip \\YOURDIR\Test_%curdate%.zip \\YOURDIR\*.xml
:: Удалим лишние файлы
del \\YOURDIR\*.txt
rem exit
pause
