Feature: User Administration

  So that we can add new users and modify users 
  As a admin
  I need to perform all user administrative tasks

  Scenario: Listing users
    Given the standard set of users admin, manager, and client
    And a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    Given I login as "admin"
    When I follow "Users"
    Then I should see a link "admin"
    And I should see a link "manager"
    And I should see a link "client"


  Scenario: Changing a user property
    Given the standard set of users admin, manager, and client
    And a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    Given I login as "admin"
    When I follow "Users"
    Then I should see a link "manager"
    When I follow "manager"
    Then I should see "Admin: false"
    And I follow "Edit"
    And I check "user_is_admin"
    And I press "user_submit"
    Then I should see "Admin: true"
