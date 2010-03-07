class Splat::Win32Player
  def play path
    `mpg123 -q #{path}`
  end
end
