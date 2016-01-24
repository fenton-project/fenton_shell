Feature: Client Functions
  Scenario: Create a client
  When I create a client for "Fooz Bar" with a public key
  Then the stdout should contain "Client created!"
  Then the exit status should be 0
