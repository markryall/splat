class String
  def to_clipboard
    Win32::Clipboard.set_data(self)
  end
end
