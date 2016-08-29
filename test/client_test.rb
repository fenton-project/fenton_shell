require 'test_helper'
require 'sshkey'
require 'fileutils'

# Validate client api calls to Fenton
class ClientTest < Test::Unit::TestCase
  def setup
    @client = Client.new
    @public_key_path = 'tmp/test/client_public_key'
    @public_key = File.write(@public_key_path,
                             ::SSHKey.generate(
                               type: 'RSA', bits: 256
                             ).ssh_public_key)
  end

  def teardown
    ::FileUtils.rm_r(@public_key_path)
  end

  def global_options
    {
      fenton_server_url: 'http://localhost:9292',
      directory: "#{Dir.home}/.fenton"
    }
  end

  def options
    {
      username: 'foobarz',
      name: 'Foo Barz',
      email: 'FooBarz@example.com',
      password: 'Foo Barz',
      public_key: @public_key_path
    }
  end

  def test_client_creation
    client_result = @client.create(global_options, options)

    assert client_result
    assert_equal "Client created!\n", @client.message
  end

  def test_client_creation_missing_name
    skewed_options = options
    skewed_options.delete(:name)
    client_result = @client.create(global_options, skewed_options)

    refute client_result
    assert_equal "Name can't be blank\n", @client.message
  end

  def test_client_creation_missing_public_key
    skewed_options = options
    File.write(@public_key_path, '')
    client_result = @client.create(global_options, skewed_options)

    refute client_result
    assert_equal "Public_key can't be blank\n", @client.message
  end
end
