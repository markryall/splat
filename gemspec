Gem::Specification.new do |spec|
  spec.name = 'splat'
  spec.version = '0.0.4'
  spec.summary = 'cross platform adapter for various os specific features'
  spec.description = <<-EOF
An adapter to get access to the following features across different platforms:

 * the clipboard
 * an application launcher
EOF

  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'http://github.com/markryall/splat'

  spec.files = Dir['lib/**/*'] + ['README.rdoc', 'MIT-LICENSE']
end
