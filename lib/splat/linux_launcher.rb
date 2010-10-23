class String
  def to_launcher
    `gnome-open #{self}`
  end
end
