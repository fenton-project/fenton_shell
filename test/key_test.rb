require 'test_helper'

class KeyTest < Test::Unit::TestCase
  def setup
    @key = Key.new
  end

  def teardown
  end

  def options
    {
      private_key: 'tmp/test/key_private_key',
      type: 'rsa',
      bits: 256,
      passphrase: 'foo_bar'
    }
  end

  def test_key_creation
    key_result = @key.create(options)

    assert key_result
    assert_equal "Key created!\n", @key.message
  end
end
