Feature: Submitting and Handling Questionnaire for Clients

  So that we can evaluate a survey
  A client must be able to submit a questionnaire for his virtualdesktop to the survey

  Scenario: Being invited to submit a questionnaire
    Given a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    And a open survey "TestSurvey"
    Given I login as "client"
    Then I should see the invitation to a submit to a survey
  
  Scenario: Submitting a questionnaire
    Given a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    And a open survey "TestSurvey"
    Given I login as "client"
    When I go to the questionnaires page
    Then I should see a link "Submit New Questionnaire"
    When I follow "Submit New Questionnaire"
    Then I should see "New questionnaire"
    When I fill out the questionnaire form
    And  I submit  the questionnaire form
    Then I should see "Questionnaire was successfully created."

  Scenario: Editing a questionnaire
    Given a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    And a open survey "TestSurvey"
    And a submitted questionnaire for the user "client", the survey "TestSurvey" and the virtualdesktop "Desk1"
    Given I login as "client"
    When I go to the questionnaires page
    Then I should see a link "Show"
    Then I should see a link "Edit"
    Then I should see a link "Destroy"
    When I follow "Edit"
    When I fill out the questionnaire form
    And  I submit  the questionnaire form
    Then I should see "Questionnaire was successfully updated."

  Scenario: Destroying a questionnaire
    Given a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    And a open survey "TestSurvey"
    And a submitted questionnaire for the user "client", the survey "TestSurvey" and the virtualdesktop "Desk1"
    Given I login as "client"
    When I go to the questionnaires page
    Then I should see a link "Show"
    Then I should see a link "Edit"
    Then I should see a link "Destroy"
    When I follow "Destroy"
    And I acknowledge the prompt
    Then show me the page
    Then I should see "Questionnaire was successfully destroyed."

  Scenario: Client sees only "Show" for questionnaire of a closed survey 
    Given a virtualdesktop "Desk1" assigned to the client "client" and to the masterimage "master1"
    And a open survey "TestSurvey"
    And a submitted questionnaire for the user "client", the survey "TestSurvey" and the virtualdesktop "Desk1"
    Given I login as "client"
    Given the survey "TestSurvey" is being closed
    When I go to the questionnaires page
    Then I should see a link "Show"
    Then I should not see a link "Edit"
    Then I should not see a link "Destroy"

  Scenario: Clients can only see their own questionnaires
    Given a open survey "TestSurvey"
    And a virtualdesktop "Desk1" assigned to the client "client1" and to the masterimage "master"
    And a submitted questionnaire for the user "client1", the survey "TestSurvey" and the virtualdesktop "Desk1"
    And a virtualdesktop "Desk2" assigned to the client "client2" and to the masterimage "master"
    And a submitted questionnaire for the user "client2", the survey "TestSurvey" and the virtualdesktop "Desk2"
    When I login as "client1"
    When I go to the questionnaires page
    Then I should only see exactly one questionnaire

