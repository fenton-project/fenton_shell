Feature: Project Functions
  Background:
    Given an organization named "My Org" is created with key "myorg"

  Scenario: Create a project
    When I create a project named "Production Machines" with key "productionmachines" for "myorg"
    Then the stdout should contain "Project created!"
    Then the exit status should be 0
