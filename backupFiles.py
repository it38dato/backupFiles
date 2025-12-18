from libs.importKeys import importDataFile
from libs.replaceFiles import replace

listDataFile = importDataFile([])
count = 0
for index in listDataFile:
    print(str(count)+" - "+index)
    count = count + 1

SOURCE_DIR, DEST_DIR = replace(f'{listDataFile[17]}', f'{listDataFile[23]}')
SOURCE_DIR, DEST_DIR = replace(f'{listDataFile[19]}', f'{listDataFile[25]}')
SOURCE_DIR, DEST_DIR = replace(f'{listDataFile[21]}', f'{listDataFile[27]}')
print("Перемещение завершено.")