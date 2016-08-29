require 'test_helper'

# Validate project api calls to Fenton
class ProjectTest < Test::Unit::TestCase
  def setup
    @project = Project.new
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
      name: 'Production Machines',
      description: 'Machines in production',
      passphrase: 'Foobar',
      key: 'productionmachines',
      organization: 'myorg'
    }
  end

  def test_project_creation
    project_result = @project.create(global_options, options)

    assert project_result
    assert_match %r{Project Created!}, @project.message
  end

  def test_project_creation_missing_name
    skewed_options = options
    skewed_options.delete(:name)
    project_result = @project.create(global_options, skewed_options)

    refute project_result
    assert_equal "Name can't be blank\n", @project.message
  end

  def test_project_creation_missing_description
    skewed_options = options
    skewed_options.delete(:description)
    project_result = @project.create(global_options, skewed_options)

    refute project_result
    assert_equal "Description can't be blank\n", @project.message
  end

  def test_project_creation_missing_passphrase
    skewed_options = options
    skewed_options.delete(:passphrase)
    project_result = @project.create(global_options, skewed_options)

    refute project_result
    assert_equal "Passphrase can't be blank\n", @project.message
  end
end
