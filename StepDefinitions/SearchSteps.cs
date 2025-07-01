using Microsoft.Playwright;
using NUnit.Framework;
using FiableTestAutomation.Pages;
using FiableTestAutomation.Hooks;
using Reqnroll;
using FiableTestAutomation.Utilities;

namespace FiableTestAutomation.StepDefinitions
{
    [Binding]
    public class SearchSteps
    {
        public IPage? _page { get; set; }
        public required SearchPage _searchPage;

        private readonly PlaywrightDriver? _driver;

        public SearchSteps(PlaywrightDriver? driver)
        {
            _driver = driver ?? throw new ArgumentNullException(nameof(driver), "Playwright driver cannot be null. Ensure that Playwright is initialized correctly.");
            _page = driver.Page ?? throw new ArgumentNullException(nameof(_page), "Playwright page cannot be null. Ensure that Playwright is initialized correctly.");
            _searchPage = new SearchPage(_page) ?? throw new ArgumentNullException(nameof(_searchPage), "SearchPage cannot be null. Ensure that Playwright is initialized correctly.");
        }

        [StepDefinition(@"I launch ABN search website")]
        public async Task GivenIlaunchABNsearchwebsiteusing()
        {
            await _searchPage.NavigateToSearchABN();
        }

        [StepDefinition(@"I search for ""(.*)""")]
        public async Task WhenIsearchfor(string input)
        {
            await _searchPage.SearchABN(input);
        }

        [StepDefinition(@"I should see the ABN/ACN details for ""(.*)""")]
        public async Task GivenIshouldseetheABNACNdetailsfor(string input)
        {
            input = input.Length == 11 ? $"91 {input}" : input;
            string? title = await _searchPage.GetPageTitle();
            Assert.That(title, Is.EqualTo($"Current details for ABN {input}"), $"Expected title to be 'Current details for ABN {input}' but was '{title}'");
        }

        [StepDefinition(@"I should see the error message ""(.*)""")]
        public async Task ThenIshouldseetheerrormessage(string message)
        {
            bool isMessageVisible = await _searchPage.isMessageVisible(message);
            Assert.That(isMessageVisible, Is.True, $"Expected error message '{message}' to be visible but it was not.");
        }
    }
}