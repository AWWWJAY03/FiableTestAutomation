using Microsoft.Playwright;

namespace FiableTestAutomation.Pages
{
    public class BasePage
    {
        protected readonly IPage _page;

        public BasePage(IPage page)
        {
            _page = page;
        }

        public async Task NavigateToAsync(string url)
        {
            await _page.GotoAsync(url);
        }

        public async Task<string> GetTitleAsync()
        {
            return await _page.TitleAsync();
        }
    }
}