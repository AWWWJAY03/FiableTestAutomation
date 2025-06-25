using Microsoft.Playwright;
using NUnit.Framework;
using FiableTestAutomation.Pages;
using CSharpPlaywrightSpecFlow.Hooks;
using Reqnroll;

namespace FiableTestAutomation.StepDefinitions
{
    [Binding]
    public class SearchSteps
    {
        public IPage? page { get; set; }
        private SearchPage searchPage;

        [BeforeScenario]
        public async Task BeforeScenario()
        {
            page = Hooks.Page;
            searchPage = new SearchPage(page);
        }

        [StepDefinition(@"I launch ABN search website")]
        public async Task GivenIlaunchABNsearchwebsiteusing()
        {
            await searchPage.NavigateToSearchABN();
        }

        [StepDefinition(@"I search for ""(.*)""")]
        public async Task WhenIsearchfor(string input)
        {
            await searchPage.SearchABN(input);
        }

        [StepDefinition(@"I should see the ABN/ACN details for ""(.*)""")]
        public async Task GivenIshouldseetheABNACNdetailsfor(string input)
        {
            input = input.Length == 11 ? $"91 {input}" : input;
            string? title = await searchPage.GetPageTitle();
            Assert.That(title, Is.EqualTo($"Current details for ABN {input}"), $"Expected title to be 'Current details for ABN {input}' but was '{title}'");
        }

        [StepDefinition(@"I should see the error message ""(.*)""")]
        public async Task ThenIshouldseetheerrormessage(string message)
        {
            bool isMessageVisible = await searchPage.isMessageVisible(message);
            Assert.That(isMessageVisible, Is.True, $"Expected error message '{message}' to be visible but it was not.");
        }
    }
}