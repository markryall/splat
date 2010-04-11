class String
  def to_launcher
    `start #{self}`
  end
end
