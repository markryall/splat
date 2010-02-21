class Splat::DarwinClipboard
  def content= text
    `echo "#{text}" | pbcopy`
  end
end
