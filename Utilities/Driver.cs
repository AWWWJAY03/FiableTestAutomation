using NUnit.Framework;
using Microsoft.Playwright;


namespace FiableTestAutomation.Utilities
{
    [TestFixture]
    public class Driver
    {
        public static IBrowser? browser;
        public static async Task<IBrowser> CreateBrowser()
        {
            var playwright = await Playwright.CreateAsync();

            switch (TestContext.Parameters["browser"])
            {
                case "safari":
                    browser = await playwright.Webkit.LaunchAsync(new BrowserTypeLaunchOptions
                    {
                        Headless = Convert.ToBoolean(TestContext.Parameters["headless"]),
                    });
                    break;
                case "firefox":
                    browser = await playwright.Firefox.LaunchAsync(new BrowserTypeLaunchOptions
                    {
                        Headless = Convert.ToBoolean(TestContext.Parameters["headless"])
                    });
                    break;
                default:
                    browser = await playwright.Chromium.LaunchAsync(new BrowserTypeLaunchOptions
                    {
                        Headless = Convert.ToBoolean(TestContext.Parameters["headless"]),
                        Channel = "chrome"
                    });
                    break;
            }
            return browser;
        }

        public static async Task CloseBrowser()
        {
            if (browser != null)
            {
                await browser.CloseAsync();
            }
        }
    }
}