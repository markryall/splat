spec = Gem::Specification.load(File.expand_path('gemspec', File.dirname(__FILE__)))

desc "Push new release to gemcutter and tag"
task :push  => :build_gem do
  sh "git tag #{spec.version}"
  sh "gem push #{spec.name}-#{spec.version}.gem"
end

task :build_gem do
  sh "gem build gemspec"
end

desc "Install #{spec.name} locally"
task :install => :build_gem do
  sh "gem install #{spec.name}-#{spec.version}.gem --no-ri --no-rdoc"
end

desc "Uninstall #{spec.name} locally"
task :uninstall => :build_gem do
  sh "gem uninstall #{spec.name} -x -a"
end

desc "Reinstall #{spec.name} locally"
task :reinstall => [:uninstall, :install]
