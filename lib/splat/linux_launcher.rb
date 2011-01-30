class String
  def to_launcher
    spawn "gnome-open \"#{self}\""
  end
end
