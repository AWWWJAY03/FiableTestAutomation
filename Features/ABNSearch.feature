Feature: ABN Search Functionality

This feature allows users to search for Australian Business Numbers (ABN) or Australian Company Numbers (ACN) and verify their details.
    
    Scenario Outline: Verify ABN search using an existing ABN/ACN number
    Given I launch ABN search website
    When I search for "<input>"
    Then I should see the ABN/ACN details for "<input>"
    Examples:
      | input           |
      | 91 620 623 341  |
      | 620 623 341     |
