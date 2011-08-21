$: << File.dirname(__FILE__)+'/../lib'

require 'splat'

class VerificationMatcher
  def matches? description
    @description = description
    $stdout.print "Did it #{description}? "
    $stdin.gets =~ /^y/i
  end

  def failure_message
    "Did not #{@description}"
  end
end

describe 'splat' do
  def be_verified
    VerificationMatcher.new
  end

  it do
    "http://www.google.com".to_browser
    "launch a browser and go to google.com".should be_verified
  end
end