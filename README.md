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

- [.NET 8 SDK](https://dotnet.microsoft.com/download)
- [Node.js & npm](https://nodejs.org/)  
  _Required to install the Allure CLI._
- [Java JRE](https://adoptium.net/)  
  _Required by Allure for report generation. Make sure `java` is available in your system PATH (see below)._
- [Allure Commandline](https://docs.qameta.io/allure/#_installing_a_commandline)  
  _Install via npm:_
  ```sh
  npm install -g allure-commandline
  ```
- Chrome/Edge/Firefox installed (for Playwright)
- **Git** (for version control, optional but recommended)

---

## Setting JAVA_HOME and PATH (Windows)

1. **Set JAVA_HOME:**
   - Open **System Properties** > **Environment Variables**.
   - Under "System variables", click **New**.
   - Variable name: `JAVA_HOME`
   - Variable value: *(your Java path, e.g.,)*  
     `C:\Program Files (x86)\Java\jre1.8.0_451`

3. **Add Java to PATH:**
   - In "System variables", select `Path` and click **Edit**.
   - Click **New** and add:  
     `%JAVA_HOME%\bin`
   - Click OK to save.

4. **Verify in a new terminal:**
   ```sh
   java -version
   ```

---

## Installation

1. **Clone the repository**
    ```sh
    git clone https://github.com/your-org/FiableTestAutomation.git
    cd FiableTestAutomation
    ```

2. **Restore .NET dependencies**
    ```sh
    dotnet restore
    ```

3. **Install Playwright browsers**
    ```sh
    dotnet playwright install
    ```

4. **Install Allure CLI globally**
    ```sh
    npm install -g allure-commandline
    ```

---

## Running Tests

1. **Run all tests with your desired environment**
    ```sh
    dotnet test --settings Environment/QA.runsettings
    ```

2. **After the run, Allure HTML report will be automatically generated**
    ```sh
    allure generate --single-file --clean -o allure-report
    ```

3. **Open the Allure report using the path provided**

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
- **Could not find testhost**: Use a stable .NET SDK (e.g., net8.0).
- **Allure not generating reports**: Ensure Java is installed and available in your PATH.

---

## Useful Links

- [SpecFlow (BDD for .NET)](https://github.com/SpecFlowOSS/SpecFlow)
- [Reqnroll (SpecFlow fork)](https://github.com/reqnroll/reqnroll)
- [Allure Framework](https://github.com/allure-framework/allure2)
- [Allure C# Integration](https://github.com/allure-framework/allure-csharp)

---