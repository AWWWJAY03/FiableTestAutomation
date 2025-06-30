#!/bin/bash

# Exit on error
set -e

echo "Checking and installing prerequisites for FiableTestAutomation..."

# Check for Homebrew
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# .NET SDK
# Detect Apple Silicon (arm64) or Intel (x86_64)
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
  DOTNET_URL="https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.301/dotnet-sdk-9.0.301-osx-arm64.pkg"
  DOTNET_PKG="dotnet-sdk-9.0.301-osx-arm64.pkg"
else
  DOTNET_URL="https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.301/dotnet-sdk-9.0.301-osx-x64.pkg"
  DOTNET_PKG="dotnet-sdk-9.0.301-osx-x64.pkg"
fi

# Install .NET SDK if not present
if ! command -v dotnet &>/dev/null; then
  echo ".NET SDK not found. Downloading and installing the correct version for $ARCH..."
  curl -L -o "$DOTNET_PKG" "$DOTNET_URL"
  sudo installer -pkg "$DOTNET_PKG" -target /
  rm "$DOTNET_PKG"
fi

# Ensure dotnet symlink exists
if [ ! -f /usr/local/bin/dotnet ]; then
  # Try x64 location first (most common for recent SDKs)
  if [ -f /usr/local/share/dotnet/x64/dotnet ]; then
    sudo ln -sfn /usr/local/share/dotnet/x64/dotnet /usr/local/bin/dotnet
    echo "Symlink for dotnet created at /usr/local/bin/dotnet (from x64)"
  # Fallback to default location if present
  elif [ -f /usr/local/share/dotnet/dotnet ]; then
    sudo ln -sfn /usr/local/share/dotnet/dotnet /usr/local/bin/dotnet
    echo "Symlink for dotnet created at /usr/local/bin/dotnet (from default)"
  else
    echo "dotnet binary not found in expected locations."
  fi
fi

# Java (OpenJDK)
if ! command -v java &>/dev/null; then
  echo "Java not found. Installing OpenJDK..."
  brew install openjdk
  # Add OpenJDK to PATH for current session
  export PATH="/usr/local/opt/openjdk/bin:$PATH"
  # Optionally, add to shell profile for future sessions
  if ! grep -q 'openjdk/bin' ~/.zshrc; then
    echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' >> ~/.zshrc
    echo "Added OpenJDK to PATH in ~/.zshrc"
  fi
fi

# Allure CLI
if ! command -v allure &>/dev/null; then
  echo "Allure CLI not found. Installing Allure..."
  brew install allure
fi

# Check for Git
if ! command -v git &>/dev/null; then
  echo "Git not found. Installing Git..."
  brew install git
fi

echo "Restoring NuGet packages..."
dotnet restore

echo "Cleaning and building the project..."
dotnet clean
dotnet build

echo "Setup complete! You can now run your tests with:"
echo "  dotnet test --settings Environment/qa.runsettings"
