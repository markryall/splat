class String
  def to_os_path
    self.gsub('/','\\')
  end
end