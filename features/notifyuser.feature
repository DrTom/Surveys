Feature: Notifying users

  So that we will many summited questionnaires
  A manager must be able to invide and remind users that have not submitted yet

  Scenario: Notify users to submit
    Given a set of users with desktops
    And the standard set of users admin, manager, and client
    When I login as "manager"
    Then I should see a link "Notify users"
    When I follow "Notify users"
    Then I should see the Send an eMail link
    And I should see a list of to be notified users

