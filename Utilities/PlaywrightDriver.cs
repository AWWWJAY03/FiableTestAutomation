using Microsoft.Playwright;
using NUnit.Framework;

namespace FiableTestAutomation.Utilities
{
    public class PlaywrightDriver : IAsyncDisposable
    {
        public IPlaywright? WebDriver { get; private set; }
        public IBrowser? Browser { get; private set; }
        public IBrowserContext? Context { get; private set; }
        public IPage? Page { get; private set; }

        public async Task InitializeAsync()
        {
            WebDriver = await Playwright.CreateAsync();
            string browserType = TestContext.Parameters["browser"]?.ToLower() ?? "chrome";
            browserType = browserType == "random" ? new[] { "edge", "firefox", "chrome" }[new Random().Next(3)] : browserType;
            switch (browserType)
            {
                case "edge":
                    Browser = await WebDriver.Chromium.LaunchAsync(new BrowserTypeLaunchOptions
                    {
                        Headless = Convert.ToBoolean(TestContext.Parameters["headless"]),
                        Channel = "msedge"
                    });
                    break;
                case "safari":
                    Browser = await WebDriver.Webkit.LaunchAsync(new BrowserTypeLaunchOptions
                    {
                        Headless = Convert.ToBoolean(TestContext.Parameters["headless"]),
                    });
                    break;
                case "firefox":
                    Browser = await WebDriver.Firefox.LaunchAsync(new BrowserTypeLaunchOptions
                    {
                        Headless = Convert.ToBoolean(TestContext.Parameters["headless"])
                    });
                    break;
                default:
                    Browser = await WebDriver.Chromium.LaunchAsync(new BrowserTypeLaunchOptions
                    {
                        Headless = Convert.ToBoolean(TestContext.Parameters["headless"]),
                        Channel = "chrome"
                    });
                    break;
            }
            Context = await Browser.NewContextAsync();
            Page = await Context.NewPageAsync(); 
        }
        public async ValueTask DisposeAsync()
        {
            if (Page != null) await Page.CloseAsync();
            if (Context != null) await Context.CloseAsync();
            WebDriver?.Dispose();
        }
    }
}