class String
  def to_launcher
    spawn "start \"#{self}\""
  end
end