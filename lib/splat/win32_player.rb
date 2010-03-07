class Splat::Win32Player
  def play path
    `mpg123 #{path}`
  end
end
