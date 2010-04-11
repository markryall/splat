class String
  def to_speech
    Win32::SpVoice.new.Speak(self)
  end
end