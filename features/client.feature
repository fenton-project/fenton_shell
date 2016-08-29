Feature: Client Functions
  Scenario: Signup a client
    When I signup a client with username "foobar" named "Fooz Bar" with a public key
    Then the output should contain:
    """
    Client created
    """
    Then the exit status should be 0
    Given a file named "tmp/aruba/config"
    Then the output should contain:
    """
    ---
    :email: foobar@example.com
    :fenton_server_url: http://localhost:9292
    :name: Fooz Bar
    """
