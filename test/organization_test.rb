require 'test_helper'

class OrganizationTest < Test::Unit::TestCase
  def setup
    @organization = Organization.new
  end

  def teardown
  end

  def global_options
    {
      fenton_server_url: 'http://localhost:9292',
      directory: "#{Dir.home}/.fenton"
    }
  end

  def options
    {
      name: 'My Org',
      key: 'myorg',
    }
  end

  def test_organization_creation
    organization_result = @organization.create(global_options, options)

    assert organization_result
    assert_equal "Organization created!\n", @organization.message
  end

  def test_organization_creation_missing_name
    skewed_options = options
    skewed_options.delete(:name)
    organization_result = @organization.create(global_options, skewed_options)

    refute organization_result
    assert_equal "Name can't be blank\n", @organization.message
  end

  def test_organization_creation_missing_key
    skewed_options = options
    skewed_options.delete(:key)
    organization_result = @organization.create(global_options, skewed_options)

    refute organization_result
    assert_equal "Key can't be blank\n", @organization.message
  end
end
