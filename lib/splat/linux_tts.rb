class String
  def to_speech
    `espeak "#{self}"`
  end
end