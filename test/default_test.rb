require 'test_helper'

class DefaultTest < Test::Unit::TestCase
  def test_version_comes_back_successfully
    assert FentonShell::VERSION
  end
end
