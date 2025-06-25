using Microsoft.Playwright;
using NUnit.Framework;

namespace FiableTestAutomation.Pages
{
    public class SearchPage
    {
        private readonly IPage _page;
        private ILocator inputSearchInput => _page.Locator("#SearchText");
        private ILocator btnSearch => _page.Locator("#MainSearchButton");
        private ILocator pageTitle => _page.Locator("#content-main");
        private ILocator activeRows => _page.Locator("tr.active, td.active");
        private ILocator noResults => _page.Locator("//h2[contains(., 'No matching names found')]");
        private ILocator textRequired => _page.Locator("//h2[contains(., 'Search text required')]");
        public SearchPage(IPage page)
        {
            _page = page;
        }

        public async Task NavigateToSearchABN()
        {
            await _page.GotoAsync(TestContext.Parameters["baseUrl"]);
        }

        public async Task SearchABN(string input)
        {
            await inputSearchInput.FillAsync(input);
            await btnSearch.ClickAsync();
        }

        public async Task<string?> GetPageTitle() =>  await pageTitle.GetAttributeAsync("title");

        public async Task<bool> isMessageVisible(string message)
        {
            var locator = _page.Locator($"//h2[contains(., '{message}')]");
            return await locator.IsVisibleAsync();
        }
    }
}