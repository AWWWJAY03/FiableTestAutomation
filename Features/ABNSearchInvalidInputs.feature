Feature: ABN Search Functionality - Negative Scenarios

This feature allows users to search for invalid Australian Business Numbers (ABN) or Australian Company Numbers (ACN) and verify the error handling.

    Scenario Outline: Verify ABN Search using an invalid input2
    Given I launch ABN search website
    When I search for "<input>"
    Then I should see the error message "<message>"
    Examples:
      | input        | message                               |
      |              | Search text required                  |
      | *&*#&*!#*!&& | No matching names found               |
      | 123456789    | The number entered is not a valid ACN |
      | 12345678901  | The number entered is not a valid ABN |
