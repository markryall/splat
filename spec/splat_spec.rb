$: << File.dirname(__FILE__)+'/../lib'

require 'splat'

class VerificationMatcher
  def initialize method, description
    @method, @description = method, description
  end

  def matches? string
    @description = @description.gsub('%s', string)
    string.send @method
    $stderr.print "Did it #{description}? "
    $stdin.gets =~ /^y/i
  end

  def description
    "#{@description}"
  end

  def failure_message
    "Did not #{@description}"
  end
end

describe 'splat' do
  def have_method method, description
    VerificationMatcher.new method, description
  end

  it { "http://www.google.com".should have_method(:to_browser, "launch a browser and go to %s") }
end