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

    Scenario Outline: Verify ABN Search using an invalid input
    Given I launch ABN search website
    When I search for "<input>"
    Then I should see the error message "<message>"
    Examples:
      | input        | message                               |
      |              | Search text required                  |
      | *&*#&*!#*!&& | No matching names found               |
      | 123456789    | The number entered is not a valid ACN |
      | 12345678901  | The number entered is not a valid ABN |
