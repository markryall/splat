class Splat::Win32Clipboard
  def content= text
    Win32::Clipboard.set_data(text)
  end
end
