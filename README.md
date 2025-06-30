# FiableTestAutomation

Automated end-to-end testing for [https://abr.business.gov.au/](https://abr.business.gov.au/) using Playwright, Reqnroll (SpecFlow fork), NUnit, and Allure reporting.

---

## Features

- **ABN/ACN Search**: Verifies search results for valid and invalid ABN/ACN numbers.
- **BDD Scenarios**: Written in Gherkin for easy readability and collaboration.
- **Cross-browser Support**: Easily configurable via `.runsettings`.
- **Allure Reporting**: Generates rich HTML reports with embedded screenshots for every test run.

---

## Prerequisites

Make sure the following are installed **before running the tests**:
- [.NET 9 SDK](https://dotnet.microsoft.com/download/dotnet/9.0) (Installed via [mac-install-tools.sh](./mac-install-tools.sh) or [win-install-tools.bat](./win-install-tools.bat))
- [Java (OpenJDK)](https://formulae.brew.sh/formula/openjdk) (Installed via [mac-install-tools.sh](./mac-install-tools.sh) or [win-install-tools.bat](./win-install-tools.bat))
- [Allure CLI](https://docs.qameta.io/allure/#_installing_a_commandline) (Installed via [mac-install-tools.sh](./mac-install-tools.sh) or [win-install-tools.bat](./win-install-tools.bat))
- [Playwright](https://playwright.dev/dotnet/docs/intro) (Installed via [mac-install-tools.sh](./mac-install-tools.sh) or [win-install-tools.bat](./win-install-tools.bat))
- [Git](https://git-scm.com/downloads) (Installed via [mac-install-tools.sh](./mac-install-tools.sh) or [win-install-tools.bat](./win-install-tools.bat))
- [Chrome](https://www.google.com/chrome/), [Edge](https://www.microsoft.com/edge), or [Firefox](https://www.mozilla.org/firefox/) installed (for Playwright)
- [Visual Studio Code](https://code.visualstudio.com/) (Recommended editor)

---

## Installation

1. **Clone the repository**
    ```sh
    git clone https://github.com/AWWWJAY03/FiableTestAutomation.git
    ```

2. **Macbook**
    ```sh
    chmod +x mac-install-tools.sh
    ./mac-install-tools.sh
    ```

3. **Windows**
    ```sh
    ./win-install-tools.bat
    ```

---

## Running Tests Using a `.runsettings` File with VS Code or Visual Studio Test Runner

### VS Code

1. **Ensure you have the C#, C# Dev Kit, Playwright Test for VSCode extensions are installed.**
2. Place your `.runsettings` file in the project root or a known location.
3. In your workspace settings (`.vscode/settings.json`), add or update:
    ```json
    {
      "dotnet.unitTests.runSettingsPath": "Environment/qa.runsettings"
    }
    ```
4. Use the Test Explorer sidebar or run tests via the terminal:
    ```
    dotnet test --settings Environment/qa.runsettings
    ```
---

### Visual Studio

1. **Open your solution in Visual Studio.**
2. Go to `Test` > `Configure Run Settings` > `Select Solution Wide Run Settings File...`
3. Browse and select `Environment > qa.runsettings` file from your project directory.
4. Run your tests as usual (`Test` > `Run All Tests` or using the Test Explorer).

> **Tip:** The selected `.runsettings` file will be used for all test runs until you change it.

---

**Note:**  
- The `.runsettings` file allows you to configure environment variables, test timeouts, data collectors, and more.
- Always verify the correct `.runsettings` file is selected before running your tests to ensure the intended configuration is applied.

---

## Reports

1. **After the run, Allure HTML report will be automatically generated**

2. **Open the Allure report using the path provided**

---

## Project Structure

```
FiableTestAutomation/
├── Features/           # Gherkin feature files
├── Pages/              # Page Object Models
├── StepDefinitions/    # Step definitions for BDD
├── Hooks/              # Hooks
├── Utilities/          # Browser driver and helpers
├── Environment/        # .runsettings files for different environments
├── TestResults/        # Test and report outputs
├── FiableTestAutomation.csproj
└── FiableTestAutomation.sln
```

---

## Configuration

- **Environment/QA.runsettings**: Set browser, headless mode, and baseUrl.
- **Features/**: Add or modify Gherkin scenarios.
- **Pages/**: Update selectors and page logic as needed.

---

## Troubleshooting

- **NullReferenceException**: Ensure `[BeforeScenario]` initializes all objects.
- **BoDi.ObjectContainerException**: Check that all required NuGet packages are installed and versions are compatible.
- **Could not find testhost**: Use a stable .NET SDK (e.g., net9.0).
- **Allure not generating reports**: Ensure Java is installed and available in your PATH.

---

## Useful Links

- [SpecFlow (BDD for .NET)](https://github.com/SpecFlowOSS/SpecFlow)
- [Reqnroll (SpecFlow fork)](https://github.com/reqnroll/reqnroll)
- [Allure Framework](https://github.com/allure-framework/allure2)
- [Allure C# Integration](https://github.com/allure-framework/allure-csharp)

---