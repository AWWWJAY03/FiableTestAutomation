@echo off
setlocal

REM Get project bin directory (relative to script location)
set "BIN_DIR=%~dp0bin"

REM --- Check .NET SDK ---
where dotnet >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo .NET SDK not found. Downloading .NET 9 SDK installer...
    powershell -Command "Start-Process 'https://download.visualstudio.microsoft.com/download/pr/3b7e8e2c-8b6e-4b3a-8e7a-3e6e2e8e2e8e/3b7e8e2c8b6e4b3a8e7a3e6e2e8e2e8e/dotnet-sdk-9.0.301-win-x64.exe' -Wait"
    echo Please complete the .NET SDK installation, then re-run this script.
    pause
    exit /b
) else (
    echo .NET SDK is already installed.
)

REM --- Check Node ---
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Node.js not found. Downloading Node.js installer...
    powershell -Command "Start-Process 'https://nodejs.org/dist/v20.14.0/node-v20.14.0-x64.msi' -Wait"
    echo Please complete the Node.js installation, then re-run this script.
    pause
    exit /b
)

-- Check Git ---
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Git not found. Downloading Git installer...
    powershell -Command "Start-Process 'https://github.com/git-for-windows/git/releases/latest/download/Git-2.45.2-64-bit.exe' -Wait"
    echo Please complete the Git installation, then re-run this script.
    pause
    exit /b
)

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

echo Restoring NuGet packages...
dotnet restore

echo Installing Playwright browsers...
npx playwright install

echo Setup complete! You can now run your tests with:
echo   dotnet test --settings Environment\qa.runsettings