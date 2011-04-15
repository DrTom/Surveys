Feature: Viewing Reports

  So that we can intepret the turned in reports
  A manager must be able to view the results

  Scenario: Viewing the survey summary and survey detailed reports
    Given a set of submitted questionnaires
    And the standard set of users admin, manager, and client
    When I login as "manager"
    Then I should see a link "Reports"
    When I follow "Reports"
    Then I should see the survey summary for "Survey-1"
    And I should see a link "Survey-1" 
    And I should see a link "Survey-2"
    When I follow "Survey-1"
    Then I should see the survey summary for "Survey-1"
    #    Then I should see the masterimage summary for "I don't know yet"
    Then I should see the Individual Reports 
    Then show me the page
    Then I should see the Comments
