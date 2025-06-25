# FiableTestAutomation

Automated end-to-end testing for [https://abr.business.gov.au/](https://abr.business.gov.au/) using Playwright, Reqnroll (SpecFlow fork), NUnit, and Allure reporting.

---

## Features

- **ABN/ACN Search**: Verifies search results for valid and invalid ABN/ACN numbers.
- **BDD Scenarios**: Written in Gherkin for easy readability and collaboration.
- **Cross-browser Support**: Easily configurable via `.runsettings`.
- **Allure Reporting**: Generates rich HTML reports for every test run.

---

## Prerequisites

- [.NET 8 SDK](https://dotnet.microsoft.com/download)
- [Node.js & npm](https://nodejs.org/) (for Allure CLI)
- [Java JRE](https://adoptium.net/) (required by Allure for report generation)
- Chrome/Edge/Firefox installed (for Playwright)

---

## Project Structure

```
FiableTestAutomation/
├── Features/           # Gherkin feature files
├── Pages/              # Page Object Models
├── StepDefinitions/    # Step definitions for BDD
├── Utilities/          # Browser driver and helpers
├── Environment/        # .runsettings files for different environments
├── TestResults/        # Test and report outputs
└── FiableTestAutomation.csproj
```

---

## Getting Started

### 1. Install Dependencies

```sh
dotnet restore
npm install -g allure-commandline
```

> **Note:** Allure requires Java to be installed and available in your system PATH.

### 2. Run Tests

```sh
dotnet test --settings Environment/QA.runsettings
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