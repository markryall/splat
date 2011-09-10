HERE = File.dirname(__FILE__)
$: << HERE+'/../lib'

require 'splat'

class VerificationMatcher
  def initialize method, description
    @method, @description = method, description
  end

  def matches? string
    t = string.send @method
    @description = @description.gsub('%s', string).gsub('%t', t.to_s)    
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

  it { 'clipboard content'.should have_method(:to_clipboard, 'set the contents of the clipboard to "%s"') }
  it { 'something out loud'.should have_method(:to_speech, 'say "%s"') }
  it { '.'.should have_method(:to_launcher, 'launch the default application for "%s"') }
  it { 'http://www.google.com'.should have_method(:to_launcher, 'launch the default application to browse to "%s"') }
  it { 'some text content'.should have_method(:to_editor, 'launch the default editor with initial content "%s" and final content "%t"') }
  it { 'a/b/c'.should have_method(:to_os_path, 'convert unix path "%s" to platform path "%t"')}
  it { (HERE+'/bicycle1.mp3').should have_method(:to_player, 'send "%s" to to audio player spawning process %t')}
end