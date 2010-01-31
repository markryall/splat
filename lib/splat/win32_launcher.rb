class Splat::Win32Launcher
  def launch text
    `start #{text}`
  end
end
