Feature: User Administration

  So that we can create, assign and rundown virtualdesktops
  As a admin
  I need to perform all those tasks

  Scenario: Listing Virtualdesktop
    Given the standard set of users admin, manager, and client
    And a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    When I login as "admin"
    Then I should see a link "Virtualdesktops"
    When I follow "Virtualdesktops"
    Then I should see "Desk1"
    And I should see "client"
    And I should see "master"
    And I should see "running"

  
  Scenario: Creating a Virtualdesktop
    Given the standard set of users admin, manager, and client
    And a masterimage "master1"
    When I login as "admin"
    Then I should see a link "Virtualdesktops"
    When I follow "Virtualdesktops"
    Then I should see a link "New Virtualdesktop"
    When I follow "New Virtualdesktop"
    And I select "client" from "User"
    And I select "master1" from "Masterimage"
    And I fill in "Name" with "Name"
    And I press "Create Virtualdesktop"
    Then I should see "Virtualdesktop was successfully created."


  Scenario: Rundown a Virtualdesktop
    Given the standard set of users admin, manager, and client
    And a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    When I login as "admin"
    Then I should see a link "Virtualdesktops"
    When I follow "Virtualdesktops"
    Then I should see a link "Rundown"
    When I follow "Rundown"
    And I acknowledge the prompt
    Then I should see "is down."
    When I follow "Virtualdesktops"
    Then I should see "down"
    
      

