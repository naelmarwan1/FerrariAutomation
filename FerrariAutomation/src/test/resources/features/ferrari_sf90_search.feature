Feature: Ferrari SF90 Search Validation
  As a user
  I want to search for Ferrari SF90 on Google
  So that I can validate the Ferrari official website

  @ferrari @smoke
  Scenario: Search for Ferrari SF90 and verify official website
    Given I am on the Google homepage
    When I search for "ferrari sf90"
    And I click on the first search result
    Then I should be redirected to the Ferrari SF90 official page
