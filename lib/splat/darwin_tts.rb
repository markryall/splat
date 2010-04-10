class Splat::DarwinTts
  def say text
    `say "#{text}"`
  end
end