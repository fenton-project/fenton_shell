Feature: Key Functions
  Scenario: Create rsa key
  When I create a "256" bit "rsa" key for "/../../tmp/aruba/key_private_key.rsa" with passphrase of "foobars"
  Then the output should contain:
  """
  Key created!
  """
  Then the exit status should be 0

  Scenario: Create dsa key
  When I create a "256" bit "dsa" key for "/../../tmp/aruba/key_private_key.dsa" with passphrase of "foobars"
  Then the output should contain:
  """
  Key created!
  """
  Then the exit status should be 0
