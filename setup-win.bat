@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cd /d "%~dp0"

:: Install .NET SDK if not found
where dotnet >nul 2>nul
if errorlevel 1 (
    echo Installing .NET SDK...
    winget install -e --id Microsoft.DotNet.SDK.9 -e --silent --accept-package-agreements --accept-source-agreements
) else (
    echo .NET SDK is already installed.
)

:: Install Git if not found
where git >nul 2>nul
if errorlevel 1 (
    echo Installing Git...
    winget install --id Git.Git -e --silent --accept-package-agreements --accept-source-agreements
) else (
    echo Git is already installed.
)

:: Download and extract OpenJDK 24 if not found
where java >nul 2>nul
if errorlevel 1 (
    echo Installing JRE 24...
    set "JDK_DEST=%USERPROFILE%\temp\java"
    if not exist "!JDK_DEST!" mkdir "!JDK_DEST!"
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/adoptium/temurin24-binaries/releases/download/jdk-24.0.1%%2B9/OpenJDK24U-jre_x64_windows_hotspot_24.0.1_9.zip' -OutFile 'OpenJDK24.zip'"
    powershell -Command "Expand-Archive -Path 'OpenJDK24.zip' -DestinationPath '!JDK_DEST!'"
    del OpenJDK24.zip
    for /d %%d in ("!JDK_DEST!\*") do (
        setx JAVA_HOME "%%d"
        setx PATH "%%d\bin;%PATH%"
        echo JAVA_HOME set to: %%d
        goto :done_java
    )
    echo Java is successfully installed.
) else (
    echo Java is already installed.
)
:done_java

:: Download and extract Allure if not found
where allure >nul 2>nul
if errorlevel 1 (
    SET "ALLURE_DEST=%USERPROFILE%\temp\allure"
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/allure-framework/allure2/releases/download/2.34.1/allure-2.34.1.zip' -OutFile 'allure.zip'"
    powershell -Command "Expand-Archive -Path 'allure.zip' -DestinationPath '!ALLURE_DEST!'"
    del allure.zip
    for /d %%d in ("!ALLURE_DEST!\allure-*") do (
        setx ALLURE_HOME "%%d"
        setx PATH "%%d\bin;%PATH%"
        echo ALLURE_HOME set to: %%d
        goto :done_allure
    )
    echo Allure is successfully installed.
) else (
    echo Allure is already installed.
)
:done_allure

echo Restoring NuGet packages...
dotnet restore

echo "Cleaning and building the project..."
dotnet clean
dotnet build

echo Setup complete! Restart your terminal to apply changes.
pause