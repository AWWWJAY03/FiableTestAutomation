using System.Diagnostics;
using Allure.Net.Commons;
using Microsoft.Playwright;
using NUnit.Framework;
using FiableTestAutomation.Utilities;
using Reqnroll;

namespace CSharpPlaywrightSpecFlow.Hooks
{
    /*
    Hooks for test automation with C#, Playwright, and SpecFlow.
    This code defines actions before and after test scenarios on the website "https://www.demoblaze.com".
    */
    [Binding]
    public sealed class Hooks
    {
        private static IBrowser? _browser;
        private IBrowserContext? _context;
        public static IPage? Page;

        [BeforeTestRun]
        public static async Task BeforeAll()
        {
            _browser = await Driver.CreateBrowser();
        }

        [BeforeScenario]
        public async Task BeforeScenario()
        {
            if (_browser != null)
            {
                _context = await _browser.NewContextAsync(new BrowserNewContextOptions
                {
                    ViewportSize = ViewportSize.NoViewport
                });

                Page = await _context.NewPageAsync();
            }
            else
            {
                throw new NullReferenceException("The browser is not initialized.");
            }
        }

        [AfterScenario]
        public async Task AfterScenario(ScenarioContext context)
        {
            if (context.TestError != null)
            {
                byte[] screenshot = Array.Empty<byte>();
                if (Page != null)
                {
                    screenshot = await Page.ScreenshotAsync();
                }
                AllureApi.AddAttachment($"Failed Scenario: {context.ScenarioInfo.Title}",
                    "application/png", screenshot);
            }

            if (Page != null)
            {
                await Page.CloseAsync();
            }
            else
            {
                throw new NullReferenceException("The page is not initialized.");
            }

            if (_context != null)
            {
                await _context.CloseAsync();
            }
            else
            {
                throw new NullReferenceException("The context is not initialized.");
            }

            string outputPath = TestContext.CurrentContext.WorkDirectory;
            string reportIndex = Path.Combine(outputPath, "allure-report", "index.html");
            TestContext.WriteLine($"Allure report: file:///{reportIndex.Replace("\\", "/")}");

        }

        [AfterTestRun]
        public static async Task AfterAll()
        {
            if (_browser != null)
            {
                await _browser.CloseAsync();
            }
            else
            {
                throw new NullReferenceException("The browser is not initialized.");
            }

            string outputPath = TestContext.CurrentContext.WorkDirectory;
            string allureResults = Path.Combine(outputPath, "allure-results");
            string allureReport = Path.Combine(outputPath, "allure-report");
            string reportIndex = Path.Combine(allureReport, "index.html");
            var process = Process.Start("allure.cmd", $"generate --single-file {allureResults} --clean -o {allureReport}");
            process.WaitForExit();
        }
    }
}