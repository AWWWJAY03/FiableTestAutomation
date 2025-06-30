@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Check and install Scoop
where scoop >nul 2>nul
if errorlevel 1 (
    echo Installing Scoop...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb get.scoop.sh | iex"
) else (
    echo Scoop already installed.
)

:: Refresh environment
set PATH=%PATH%;%USERPROFILE%\scoop\shims
setx PATH "%PATH%;%USERPROFILE%\scoop\shims"

:: Install .NET SDK if not found
where dotnet >nul 2>nul
if errorlevel 1 (
    echo Installing .NET SDK...
    scoop install dotnet-sdk
) else (
    echo .NET SDK already installed.
)

@REM :: Install Node.js if not found
@REM where node >nul 2>nul
@REM if errorlevel 1 (
@REM     echo Installing Node.js...
@REM     scoop install nodejs-lts
@REM ) else (
@REM     echo Node.js already installed.
@REM )

:: Install Git if not found
where git >nul 2>nul
if errorlevel 1 (
    echo Installing Git...
    scoop install git
) else (
    echo Git already installed.
)

:: Install Java JDK if not found
where java >nul 2>nul
if errorlevel 1 (
    echo Installing OpenJDK 24...
    scoop install openjdk
) else (
    echo Java is already installed.
)

:: Set JAVA_HOME and add to PATH if not set
for /f "delims=" %%j in ('where java') do (
    set "JAVA_BIN=%%~dpj"
    set "JAVA_HOME=%%~dpj.."
    setx JAVA_HOME "!JAVA_HOME!" /M
    setx PATH "!JAVA_HOME!\bin;%PATH%" /M
    goto :done_java
)
:done_java

:: Install Allure if not installed
where allure >nul 2>nul
if errorlevel 1 (
    echo Installing Allure...
    scoop install allure
) else (
    echo Allure is already installed.
)

:: Set ALLURE_HOME and add to PATH
for /f "delims=" %%i in ('where allure') do (
    set "ALLURE_BIN=%%~dpi"
    setx PATH "%%~dpi;%PATH%" /M
    goto :done_allure
)
:done_allure

echo Restoring NuGet packages...
dotnet restore

echo "Cleaning and building the project..."
dotnet clean
dotnet build

echo Setup complete! You can now run your tests with:
echo   dotnet test --settings Environment\qa.runsettings