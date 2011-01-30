class String
  def to_player
    spawn "afplay \"#{self}\""
  end
end
