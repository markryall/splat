spec = Gem::Specification.load(File.expand_path('gemspec', File.dirname(__FILE__)))

desc "Push new release to gemcutter and tag"
task :push  => :build_gem do
  sh "hg tag #{spec.version}"
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

desc 'run remote webmethods unit tests'
task :wmunit do
  $:.unshift(File.dirname(__FILE__)+'/lib')
  require 'web_methods'
  wm = WebMethods::Server.new(ENV['WM_HOST'], ENV['WM_PORT'].to_i, ENV['WM_USER'], ENV['WM_PASSWORD'])
  ['MssAppSubTest'].each do |package|
    result = wm.invoke('net.customware.wmunit', 'testSuite', 'packageName' => package)
y result
    puts "Succesfully ran #{result['numberOfSuccessfulTests']} of #{result['numberOfTests']} tests in #{result['testRunExecutionTime']}ms"
    raise "Found #{result['numberOfFailedTests']} " unless result['numberOfFailedTests'] == '0'
  end
end
