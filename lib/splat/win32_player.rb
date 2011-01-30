class String
  def to_player
    spawn "mpg123 -q \"#{self}\""
  end
end