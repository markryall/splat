class String
  def to_launcher
    spawn "open \"#{self}\""
  end
end
