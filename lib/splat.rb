class Splat
  attr_reader :platform

  def initialize
    @platform = :unknown
    if Config::CONFIG['host_os'] =~ /mswin|win32|dos|cygwin|mingw/i
      @platform = :win32
      require 'splat/win32_clipboard'
      @clipboard = Splat::Win32Clipboard.new
      require 'splat/win32_launcher'
      @launcher = Splat::Win32Launcher.new
    end
    if Config::CONFIG['host_os'] =~ /darwin10/i
      @platform = :macosx
      require 'splat/darwin10_clipboard'
      @clipboard =  Splat::Darwin10Clipboard.new
      require 'splat/darwin10_launcher'
      @launcher = Splat::Darwin10Launcher.new
    end
  end

  def supported?
    @platform != :unknown
  end

  def clipboard= content
    @clipboard.content = content if @clipboard
  end

  def launch content
    @launcher.launch content if @launcher
  end
end
