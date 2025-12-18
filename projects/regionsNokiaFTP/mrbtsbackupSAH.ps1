# YOURDIR - Место храненние БЭКАПА
# YOURIP - IP адрес ftp сервера
# YOURUSER - имя пользователя ftp сервера
# YOURPASSWD - пароль ftp сервера
# Переменные
$ftpServer = "ftp://YOURIP/Backups/MRBTS/BS/SAH/"
$ftpUser = "YOURUSER"
$ftpPassword = "YOURPASSWD"
$localFolder = "\\YOURDIR\"
$curdate = Get-Date -Format "_MM_dd_yyyy_HH_mm"
#Write-Output $curdate
# Создание объекта для загрузки
$webclient = New-Object System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPassword)
# Получение списка файлов на FTP-сервере
$ftpRequest = [System.Net.FtpWebRequest]::Create($ftpServer)
$ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
$ftpRequest.Credentials = $webclient.Credentials
$response = $ftpRequest.GetResponse()
$streamReader = New-Object System.IO.StreamReader($response.GetResponseStream())
# Чтение имен файлов
$files = @()
while($file = $streamReader.ReadLine()) {
    $files += $file
}
$streamReader.Close()
$response.Close()
#Write-Output $files
# Скачивание файлов
foreach ($file in $files) {
    $remoteFile = "$ftpServer/$file"
    $localFile = Join-Path $localFolder $file
    $webclient.DownloadFile($remoteFile, $localFile)
}
# Завершение работы
$webclient.Dispose()
$compress = @{
    Path = "\\YOURDIR\*.xml"
    CompressionLevel = "Fastest"
    DestinationPath = "\\YOURDIR\SAH$curdate.zip"
}
Compress-Archive @compress
Remove-Item \\YOURDIR\*.xml
