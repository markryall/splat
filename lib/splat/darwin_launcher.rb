class String
  def to_launcher
    `open #{self}`
  end
end
