Feature: Project Functions
  Project methods

  Scenario: Create a project
  When I create a project for "Production Machines"
  Then the stdout should contain "Project created!"
  Then the exit status should be 0
