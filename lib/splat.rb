require 'tempfile'

class String
  def splat_unsupported
    $stderr.puts 'platform not supported'
  end

  alias :to_browser   :splat_unsupported
  alias :to_clipboard :splat_unsupported
  alias :to_speech    :splat_unsupported
  alias :to_launcher  :splat_unsupported
  alias :to_player    :splat_unsupported
  alias :to_os_path   :to_s

  def to_editor
    tmp_file = Tempfile.new('splat')
    tmp_file.close
    begin
      File.open(tmp_file.path, 'w') { |out| out.print self }
      default_editor = Splat.platform == :win32 ? 'notepad' : 'vim'
      editor = ENV["EDITOR"] || default_editor
      system("#{editor} #{tmp_file.path}")
      return unless $?.to_i == 0
      File.read(tmp_file.path)
    ensure
      tmp_file.unlink
    end
  end
end

module Splat
  def self.platform
    @platform
  end

  def self.try_load feature, dependencies={}
    begin
      dependencies.each {|gem_name, require_parameter| require require_parameter }
      require "splat/#{@platform}_#{feature}"
    rescue Exception => e
      $stderr.puts e
      $stderr.puts "for #{feature} support with splat on #{@platform}:"
      dependencies.each {|gem_name, require_parameter| $stderr.puts " * gem install #{gem_name}" }
    end
  end

  case Config::CONFIG['host_os']
    when /mswin|win32|dos|cygwin|mingw/i
      @platform = :win32
      try_load 'tts', 'win32-sapi' => 'win32/sapi5'
      try_load 'clipboard', 'win32-clipboard' => 'win32/clipboard'
      try_load 'launcher'
      try_load 'player'
      try_load 'browser', 'watir' => 'watir'
      try_load 'os_path'
    when /darwin/i
      @platform = :darwin
      try_load 'tts'
      try_load 'clipboard'
      try_load 'launcher'
      try_load 'player'
      try_load 'browser', 'rb-appscript' => 'appscript', 'safariwatir' => 'safariwatir'
    when /linux/i
      @platform = :linux
      try_load 'tts'
      try_load 'clipboard'
      try_load 'launcher'
      try_load 'player'
      try_load 'browser', 'firewatir' => 'firewatir'
    else
      @platform = :unknown
      puts "I have no idea how to cope with \"#{Config::CONFIG['host_os']}\""
  end
end
