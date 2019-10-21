Feature: NavigateToUserProfilePage
  This feature validates the ability for users to edit and update their profile page
  
  Scenario: New users can login to the system and view profile button
    Given I answer the questions as follows on the login page:
      |Question     |Answer             |
      | EUSENAME    |<EUSERNAME_ANS>    |
      | EPASSWORD   |<EPASSWORD_ANS>    |
      | EMPLOYEE    |Yes                |
      When I click the Save & Contibue Button on the login oage
      Then I see my user profule button at the top right of the Welcome page
