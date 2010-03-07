class Splat::DarwinPlayer
  def play path
    `afplay #{path}`
  end
end
