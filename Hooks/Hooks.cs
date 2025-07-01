using System.Diagnostics;
using Allure.Net.Commons;
using Microsoft.Playwright;
using NUnit.Framework;
using Reqnroll;
using System.Runtime.InteropServices;
using Reqnroll.BoDi;
using FiableTestAutomation.Utilities;

namespace FiableTestAutomation.Hooks
{
    [Binding]
    public class Hooks
    {
        private readonly IObjectContainer _container;
        private PlaywrightDriver? _driver;

        public Hooks(IObjectContainer container)
        {
            _container = container;
        }
        [BeforeTestRun]
        public static void BeforeAll()
        {
            // Clean up Allure results directory before each scenario (optional, usually done once per run)
            AllureLifecycle.Instance.CleanupResultDirectory();
        }

        [BeforeScenario]
        public async Task BeforeScenario()
        {
            _driver = new PlaywrightDriver();
            await _driver.InitializeAsync();
            _container.RegisterInstanceAs(_driver);
        }

        [AfterScenario]
        public async Task AfterScenario(ScenarioContext context)
        {
            // Get the driver instance from the container
            var driver = _container.Resolve<PlaywrightDriver>();
            var page = driver.Page;

            // Attach screenshot to Allure if scenario failed
            if (context.TestError != null && page != null)
            {
                var screenshot = await page.ScreenshotAsync();
                AllureApi.AddAttachment($"Failed Scenario: {context.ScenarioInfo.Title}", "image/png", screenshot);
            }

            // Dispose Playwright resources
            if (driver != null)
                await driver.DisposeAsync();

            // Print Allure report path
            string outputPath = TestContext.CurrentContext.WorkDirectory;
            string reportIndex = Path.Combine(outputPath, "allure-report", "index.html");
            TestContext.WriteLine($"Allure report: file:///{reportIndex.Replace("\\", "/")}");
        }

        [AfterTestRun]
        public static void AfterAll()
        {
            // Generate Allure report after all tests
            string outputPath = TestContext.CurrentContext.WorkDirectory;
            string allureResults = Path.Combine(outputPath, "allure-results");
            string allureReport = Path.Combine(outputPath, "allure-report");
            string allureCmd = RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? "allure.cmd" : "allure";
            var process = Process.Start(allureCmd, $"generate --single-file {allureResults} --clean -o {allureReport}");
            process.WaitForExit();
        }
    }
}