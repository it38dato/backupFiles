from ftplib import FTP
import os
import zipfile
import datetime
from libs.importKeys import importDataFile

listDataFile = importDataFile([])
count = 0
for index in listDataFile:
    print(str(count)+" - "+index)
    count = count + 1

ftp = FTP(listDataFile[3])
ftp.login(user=listDataFile[7], passwd=listDataFile[9])
files = ftp.nlst(listDataFile[5])
local_dir = f'{listDataFile[11]}'
xml_files_ftp = [file for file in files if file.endswith(listDataFile[13])]
#print(xml_files_ftp)
archive = zipfile.ZipFile(f"{listDataFile[11]}{listDataFile[15]}{''}_{datetime.date.today().strftime('%d-%m-%y')}.zip", 'w')
for file in xml_files_ftp:
    local_file = os.path.join(local_dir, os.path.basename(file))
    with open(local_file, 'wb') as tempfile:
        ftp.retrbinary(f'RETR {file}', tempfile.write)
    for loc_dir, loc_subdir, files_local in os.walk(local_dir):
        #print(loc_dir)
        for all_files_local in files_local:
            #print(all_files_local)
            if all_files_local.endswith(listDataFile[13]):
                xml_files_local=os.path.join(loc_dir, all_files_local)
                archive.write(xml_files_local, os.path.relpath(xml_files_local, local_dir), compress_type = zipfile.ZIP_DEFLATED)
                #print(xml_files_local)
                os.remove(xml_files_local)
archive.close()
ftp.quit()