require 'test_helper'
require 'sshkey'
require 'tempfile'
require 'fileutils'

class CertificateTest < Test::Unit::TestCase
  def setup
    @certificate = Certificate.new
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
      client: 'Foo Barz',
      project: 'Production Machines'
    }
  end

  def test_certificate_creation
    certificate_result = @certificate.create(global_options, options)

    assert certificate_result
    assert_equal "Certificate created!\n", @certificate.message
  end
end
