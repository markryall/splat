class Splat
  attr_reader :platform

  def initialize
    case Config::CONFIG['host_os']
      when /mswin|win32|dos|cygwin|mingw/i
        @platform = :win32
        begin
          require 'splat/win32_clipboard'
          @clipboard = Splat::Win32Clipboard.new
        rescue
          puts 'for clipboard with splat on windows:'
          puts ' * gem install win32-clipboard'
        end
        require 'splat/win32_launcher'
        @launcher = Splat::Win32Launcher.new
        begin
          require 'watir'
          @browser_class = Watir::IE
        rescue
          puts 'for browser automation with splat on windows'
          puts ' * gem install watir'
        end
      when /darwin10/i
        @platform = :macosx
        require 'splat/darwin10_clipboard'
        @clipboard =  Splat::Darwin10Clipboard.new
        require 'splat/darwin10_launcher'
        @launcher = Splat::Darwin10Launcher.new
        begin
          require 'safariwatir'
          @browser_class = Watir::Safari
        rescue
          puts 'for browser automation with splat on mac os x:'
          puts ' * gem install safariwatir'
          puts ' * gem install rb-appscript'
        end
      else
        @platform = :unknown
        puts "I have no idea how to cope with \"#{Config::CONFIG['host_os']}\""
    end
  end

  def supported?
    @platform != :unknown
  end

  def clipboard= content
    @clipboard.content = content if @clipboard
  end

  def browser
    @browser_class.new if @browser_class
  end

  def launch content
    @launcher.launch content if @launcher
  end
end
