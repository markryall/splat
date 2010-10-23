class String
  def to_speech
    `say "#{self}"`
  end
end