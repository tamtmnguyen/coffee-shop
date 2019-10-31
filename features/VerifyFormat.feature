Feature: VerifyFormat

  Scenario:
    Given that I have $40 in my balance
    And my friend has $10 is their balance
    And I transfer $20 to my friend
    When the transfer is complete
    Then I should have $20 in my balance
    And my friend should have $30 in their balance.