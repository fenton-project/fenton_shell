Feature: Project Functions
  Background:
    Given an organization named "My Org" is created with key "myorg"

  Scenario: Create a project
    When I create a project named "Production Machines" with key "productionmachines" for "myorg"
    Then the stdout should contain "Project Created! Below is the public key to add to the server"
    Then the exit status should be 0
