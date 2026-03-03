@echo off
setlocal
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Python was not found. First, install Python and add it to the PATH.
    pause
    exit /b 1
)
set /p name="Enter the project name: "
SET VENV_NAME=envBackupFiles
SET VENV_PATH=%USERPROFILE%\%VENV_NAME%
SET REQS_FILE=requirements.txt
SET PROJECT_NAME=%name%
echo Home Directory: %USERPROFILE%
echo The path to the virtual environment: %VENV_PATH%
echo Requirements file: %REQS_FILE%
if not exist "%VENV_PATH%" (
    echo Creating a virtual environment "%VENV_NAME%"...
    python -m venv "%VENV_PATH%"
    if %errorlevel% neq 0 (
        echo Error when creating a virtual environment.
        pause
        exit /b 1
    )
    echo The virtual environment has been successfully created.
) else (
    echo The virtual environment "%VENV_NAME%" already exists. Skipping the creation.
)
echo Activating the virtual environment and installing libraries from %REQS_FILE%...
CALL "%VENV_PATH%\Scripts\activate.bat"
if %errorlevel% neq 0 (
    echo Error when activating the environment.
    pause
    exit /b 1
)

if exist "config.txt" (
    for /f "usebackq tokens=1* delims==" %%a in ("config.txt") do (
        if /i "%%a"=="PROXY " (
            set "PROXY_PARAMETR=%%b"
        )
    )
) else (
    echo Warning: config.txt not found.
    set "PROXY_PARAMETR=default_value"
)
:: Убираем возможный ведущий пробел без использования тильды
for /f "tokens=* delims= " %%a in ("%PROXY_PARAMETR%") do set "PROXY_PARAMETR=%%a"

pip install --upgrade pip %PROXY_PARAMETR%
pip install -r "%REQS_FILE%" %PROXY_PARAMETR%
if %errorlevel% neq 0 (
    echo Error when installing libraries.
    pause
    exit /b 1
)
echo Everything is ready! The %VENV_NAME% virtual environment is configured.
echo Libraries from %REQS_FILE% are installed:
pip list
echo To activate the environment manually later, use the command (bat or ps1):
echo CALL "%VENV_PATH%\Scripts\activate.bat"
echo OR
echo CALL "%VENV_PATH%\Scripts\activate.ps1"

echo Creating a project "%PROJECT_NAME%" in the current directory...
mkdir %USERPROFILE%\%PROJECT_NAME%
xcopy /s backupFiles.py %USERPROFILE%\%PROJECT_NAME%
xcopy /s backupFilesFtp.py %USERPROFILE%\%PROJECT_NAME%
xcopy "libs" "%USERPROFILE%\%PROJECT_NAME%\libs" /E /I /H /Y
xcopy /s startBackupFilesFtp.ps1 %USERPROFILE%\%PROJECT_NAME%
xcopy /s startBackupFiles.ps1 %USERPROFILE%\%PROJECT_NAME%
xcopy /s config.txt %USERPROFILE%\%PROJECT_NAME%
if %errorlevel% neq 0 (
    echo Error when creating a project.
    pause
    exit /b 1
)

echo The project "%PROJECT_NAME%" has been successfully created in:
echo %USERPROFILE%\%PROJECT_NAME%
pause
endlocal