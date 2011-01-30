class String
  def to_player
     spawn "mplayer \"#{self}\""
  end
end