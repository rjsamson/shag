require 'shag'
require 'fakefs/spec_helpers'
require 'stub_shell'

RSpec.configure do |config|
  config.include StubShell::TestHelpers
end

# Credit to cldwalker for capture_stdout
# From https://github.com/cldwalker/hirb/blob/master/test/test_helper.rb

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end