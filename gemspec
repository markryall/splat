Gem::Specification.new do |spec|
  spec.name = 'splat'
  s.version = '0.1.2'
  spec.summary = 'cross platform adapter for various os specific features'
  spec.description = <<-EOF
An adapter to get access to the following features across different platforms:

 * the clipboard
 * a default application launcher
 * a media player
 * text to speech
EOF

  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'http://github.com/markryall/splat'

  spec.files = Dir['lib/**/*'] + ['README.rdoc', 'MIT-LICENSE']

  spec.add_development_dependency 'rake', '~>0.8.7'
  spec.add_development_dependency 'gemesis', '~>0.0.4'
end
