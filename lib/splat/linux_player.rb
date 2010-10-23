class String
  def to_player
    `mplayer #{self}`
  end
end
