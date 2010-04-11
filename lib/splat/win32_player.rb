class String
  def to_player
    `mpg123 -q #{self}`
  end
end