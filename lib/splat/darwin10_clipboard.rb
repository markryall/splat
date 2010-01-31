class Splat::Darwin10Clipboard
  def content= text
    `echo "#{text}" | pbcopy`
  end
end
