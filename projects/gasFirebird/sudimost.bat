SET ArcDepth=5
SET DirName=\\tip\backup\sudimost\
MD \\tip\backup\sudimost\%date:~0,2%_%date:~3,2%_%date:~6,4% 
XCOPY /e C:\Voskhod \\tip\backup\sudimost\%date:~0,2%_%date:~3,2%_%date:~6,4%
FOR /f "tokens=1" %%i IN ('DIR /AD /B /O-D "%DirName%"') DO (
	SET /a Index+=1
	IF !Index! LEQ %ArcDepth% (
		echo "%DirName%\%%i" - �??ao?N? >> "%LogFile%"
	) else (
		RMDIR /S/Q "%DirName%\%%i"
		echo "%DirName%\%%i" - ?na?N? >> "%LogFile%"
	)
)
pouse


