class Splat::Win32Tts
  def say text
    Win32::SpVoice.new.Speak(text)
  end
end