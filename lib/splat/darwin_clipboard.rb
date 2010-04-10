class Splat::DarwinClipboard
  def content= text
    IO.popen('pbcopy','w') do |clipboard|
      clipboard.print text
    end
  end
end
