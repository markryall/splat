class String
  def to_clipboard
    IO.popen('pbcopy','w') { |clipboard| clipboard.print self }
  end
end
