using Microsoft.Playwright;
using NUnit.Framework;

namespace FiableTestAutomation.Pages
{
    public class SearchPage
    {
        private readonly IPage _page;
        private ILocator InputSearchInput => _page.Locator("#SearchText");
        private ILocator BtnSearch => _page.Locator("#MainSearchButton");
        private ILocator PageTitle => _page.Locator("#content-main");
        public SearchPage(IPage page)
        {
            _page = page ?? throw new ArgumentNullException(nameof(page), "Page cannot be null. Ensure that Playwright is initialized correctly.");
        }

        public async Task NavigateToSearchABN()
        {
            string baseUrl = TestContext.Parameters["baseUrl"] ?? throw new ArgumentNullException("baseUrl", "Base URL must be provided in the test context parameters.");
            await _page.GotoAsync(baseUrl);
        }

        public async Task SearchABN(string input)
        {
            await InputSearchInput.FillAsync(input);
            await BtnSearch.ClickAsync();
        }

        public async Task<string?> GetPageTitle() =>  await PageTitle.GetAttributeAsync("title");

        public async Task<bool> isMessageVisible(string message)
        {
            var locator = _page.Locator($"//h2[contains(., '{message}')]");
            return await locator.IsVisibleAsync();
        }
    }
}