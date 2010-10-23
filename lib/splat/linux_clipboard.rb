class String
  def to_clipboard
    IO.popen('xclip -sel clip','w') { |clipboard| clipboard.print self }
  end
end
