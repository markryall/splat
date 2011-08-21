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

  it { 'http://www.google.com'.should have_method(:to_browser, 'launch a browser and go to "%s"') }
  it { 'clipboard content'.should have_method(:to_clipboard, 'set the contents of the clipboard to "%s"') }
  it { 'something out loud'.should have_method(:to_speech, 'say "%s"') }
  it { '.'.should have_method(:to_launcher, 'launch the default application for "%s"') }
end