Feature: Buckets config
  Scenario: encryption at rest
    Given I have AWS S3 Bucket defined
    Then encryption at rest must be enabled

  Scenario: resources are tagged
    Given I have AWS S3 Bucket defined
    Then it must contain tags
    And its value must not be null

  Scenario Outline: tags convention
    Given I have AWS S3 Bucket defined
    Then it must contain tags
    And its value must match the "<value>" regex
    Examples:
      | tags        | value      |
      | Name        | terraform  |
      | Environment | compliance |
