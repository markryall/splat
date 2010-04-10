class Splat
  attr_reader :platform

  def try_load feature, params
    begin
      params.each {|gem, req| require req }
      yield
    rescue Exception
      puts "for #{feature} support with splat on #{@platform}:"
      params.each {|gem, req| puts " * gem install #{gem}" }
    end
  end

  def initialize
    @path_cleaner = Object.new
    def @path_cleaner.clean path
      path
    end
    case Config::CONFIG['host_os']
      when /mswin|win32|dos|cygwin|mingw/i
        @platform = :win32
        try_load 'text to speech', 'win32-sapi' => 'win32/sapi5' do
          require 'splat/win32_tts'
          @tts = Splat::Win32Tts.new
        end
        try_load 'clipboard', 'win32-clipboard' => 'win32/clipboard' do
          require 'splat/win32_clipboard'
          @clipboard = Splat::Win32Clipboard.new
        end
        require 'splat/win32_launcher'
        @launcher = Splat::Win32Launcher.new
        require 'splat/win32_player'
        @player = Splat::Win32Player.new
        try_load 'browser automation', 'watir' => 'watir' do
          @browser_class = Watir::IE
        end
        def @path_cleaner.clean path
          path.to_s.gsub('/','\\')
        end
      when /darwin/i
        @platform = :macosx
        require 'splat/darwin_tts'
        @tts = Splat::DarwinTts.new
        require 'splat/darwin_clipboard'
        @clipboard =  Splat::DarwinClipboard.new
        require 'splat/darwin_launcher'
        @launcher = Splat::DarwinLauncher.new
        require 'splat/darwin_player'
        @player = Splat::DarwinPlayer.new
        try_load 'browser automation', 'rb-appscript' => 'appscript', 'safariwatir' => 'safariwatir' do
          @browser_class = Watir::Safari
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

  def play path
    @player.play path if @player
  end

  def clean_path path
    @path_cleaner.clean path
  end

  def say text
    @tts.say text
  end
end
