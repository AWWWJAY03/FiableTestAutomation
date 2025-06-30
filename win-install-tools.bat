@echo off
setlocal

REM Get project bin directory (relative to script location)
set "BIN_DIR=%~dp0bin"

REM --- Check Java ---
set "JAVA_DIR=%BIN_DIR%\java"
set "JAVA_BIN=%JAVA_DIR%\jdk-21.0.7\bin"
echo %JAVA_BIN%
if exist "%JAVA_BIN%\java.exe" (
    echo Java is already installed in %JAVA_BIN%.
) else (
    echo Java not found in project bin. Installing JDK...
    powershell -Command "Invoke-WebRequest -Uri https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.zip -OutFile %BIN_DIR%\jdk.zip"
    powershell -Command "Expand-Archive -Path %BIN_DIR%\jdk.zip -DestinationPath %JAVA_DIR%"
    echo Java installed at %JAVA_BIN%
    REM After extracting Java
    del "%BIN_DIR%\jdk.zip"
)

REM --- Check Allure ---
set "ALLURE_DOWNLOAD_LINK=https://github.com/allure-framework/allure2/releases/download/2.34.1/allure-2.34.1.zip"
set "ALLURE_DIR=%BIN_DIR%\allure
set "ALLURE_BIN=%ALLURE_DIR%\bin"
if exist "%ALLURE_BIN%\allure.bat" (
    echo Allure is already installed in %ALLURE_BIN%.
) else (
    echo Allure not found in project bin. Downloading Allure CLI...
    powershell -Command "Invoke-WebRequest -Uri %ALLURE_DOWNLOAD_LINK% -OutFile %BIN_DIR%\allure.zip"
    powershell -Command "Expand-Archive -Path %BIN_DIR%\allure.zip -DestinationPath %BIN_DIR%"
    echo Allure installed at %ALLURE_BIN%
    REM After extracting Allure
    del "%BIN_DIR%\allure.zip"

    for /D %%D in ("%BIN_DIR%\*allure*") do (
        rename "%%D" "allure"
    )
)

REM Add Java and Allure bin to user PATH permanently
setx PATH "%JAVA_BIN%;%ALLURE_BIN%;%PATH%"

echo Java and Allure are ready in your project's bin directory.
echo To use them in this terminal session, PATH has been updated.
echo For global use, add the following to your system/user PATH:
echo   %JAVA_BIN%
echo   %ALLURE_BIN%