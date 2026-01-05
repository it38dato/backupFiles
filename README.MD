<p>
    <strong>Task:</strong><br>
    Написать скрипт на Python, который выполняет бэкап файлов конфигураций базовых станций Иркутска из ftp сервера.<br>
    <strong>Decision:</strong><br>
    для работы с проектом использую скрипты bat.&nbsp;<br>
    Необходимо скачать Python (У меня 3.10) и установить ее. Затем уже использовать скрипты:<br>
    - checkPython.bat для проверки Python.<br>
    - checkBackupFiles.bat для настройки переменного окружения и создания проекта Backup. Скрипт попросит назвать проект, сохранит в домашнюю директорию папку envBackupFiles для работы с переменым окружения, добавит для проекта необходимые библиотеки записанные в файле requirements.txt, из файла config.txt добавит параметры прокси и сохранит папку с вашим названием проекта, откуда будет запускаться проект.<br>
    - startBackupFilesFtp.ps1 запускает скрипт. Скрипт запускается в проекте расположенный в домашней папке. в файле config.txt, нужно добавить свои параметры ftp сервера. Скрипт запуускает проект backupFilesFtp.py. в Log файл записывает процедуру запуска. В планировщике задач можно настроить скрипт startBackupFilesFtp.ps1, чтобы он запускался по расписанию.
</p>
<p>
    <strong>Task:</strong><br>
    Написать для макрорегионов скрипт который выполняет бэкап файлов конфигураций базовых станций из ftp сервера без зависимости от python с подробной инcтрукцией.<br>
    <strong>Decision:</strong><br>
    В папке projects/regionsNokiaFTP по отдельности для макрорегионов лежат скрипты mrbtsbackupREG.ps1. Скрипт запускается без зависимости от python. его можно запускать через планировщик задач. Также прикладывается инструкция для работы со скриптом. необохимо расшарить папку, в которой находится скрипт.<br>
    так же прикладывается скрипт backupFilesFtp.bat, аналогичные действия делает что и mrbtsbackup.ps1.
</p>
<p>
    <strong>Task:</strong><br>
    Написать скрипт на python, который переносит файлы из сетевой папки Nokia\Backup\Week\MRBTS в Nokia\Old\MRBTS &nbsp;и оставляет только последний свежий файл по дате измениния.<br>
    <strong>Decision:</strong><br>
    для работы с проектом использую скрипты powershell startBackupFiles.ps1.<br>
    В планировщике задач можно настроить скрипт startBackupFiles.ps1, чтобы он запускался по расписанию. необходимо расшарить папку. в Log файл записывает процедуру запуска. В самом файле backupFiles.py нужно менять параметры раположение сетевых папок.
</p>
<p>
    <strong>Task:</strong><br>
    Подключиться к ftp и скопировать файлы в сетевую папку.<br>
    <strong>Decision:</strong><br>
    PS C:\Windows\system32&gt; ftp<br>
    ftp&gt; open tipftp<br>
    ftp&gt; tuser<br>
    ftp&gt; ls Backups/tdir<br>
    ftp&gt; get /Backups/tdir/MRBTS2279.xml \\tdomain.ru\tdir\Test.txt<br>
    200 PORT command successful. Consider using PASV.<br>
    150 Opening BINARY mode data connection for /Backups/tdir/MRBTS2279.xml (126410 bytes).<br>
    226 Transfer complete.<br>
    ftp: 126410 байт получено за 0.24 (сек) со скоростью 533.38 (КБ/сек).
</p>
<p>
    <strong>Task:</strong><br>
    Добавить раписание.<br>
    <strong>Decision:</strong><br>
    - Планировщик задач - Создать задачу - Имя - Backup MTBTS - +Выполнить для всех пользователей - Триггеры - +Еженедельно - Начать - суббота - 23:00 - ок - действия - запуск программы - Программа или сценарий - powershell.exe - добавить аргументы<br>
    -file "C:\Users\tuser\Documents\scripts\backups\mrbtsbackup.ps1"<br>
    - ок
</p>
<p>
    <strong>Task:</strong><br>
    Написать скрипт, который &nbsp;перед обновлением системы ГАС правосудие каждой ночью останавливает базу данных, делает бэкап базы на другой сервер и стартует бэкап.<br>
    <strong>Decision:</strong><br>
    Все скрипты для запуска бэкапов находятся в папке projects\gasFirebird.<br>
    Перед бэкапом, необходимо отстановить службы БД.
</p>