require 'rake/extensiontask'
require 'rake/testtask'
require 'rdoc/task'

Rake::ExtensionTask.new('apt_pkg')

namespace :test do
  Rake::TestTask.new :unit do |t|
    t.pattern = 'test/**/*_test.rb'
  end
  Rake::Task['unit'].prerequisites << :clean
  Rake::Task['unit'].prerequisites << :compile

  Rake::TestTask.new :integration do |t|
    t.pattern = 'test/**/*_integration.rb'
  end
  Rake::Task['integration'].prerequisites << :clean
  Rake::Task['integration'].prerequisites << :compile
end

RDoc::Task.new do |rd|
  rd.main = 'README.md'
  rd.rdoc_files.include('README.md', 'ext/**/*.cpp', 'lib/**/*.rb')
  rd.rdoc_dir = 'public'
  rd.options << '--all'
  rd.title = 'ruby-apt-pkg'
end

desc 'cppcheck - Tool for static C/C++ code analysis'
task :cppcheck do
  cppcheck_opts = '--error-exitcode=1 --quiet --enable=all --inconclusive' \
    ' --suppress=missingIncludeSystem --inline-suppr' \
    ' --template "[{file}:{line}] {severity} ({id}): {message}"'
  sh("cppcheck #{cppcheck_opts} ext/apt_pkg") do |ok, res|
    ok || puts("lint error (status = #{res.exitstatus})")
    exit(res.exitstatus)
  end
end

task default: ['test:unit', 'test:integration']
task test: ['test:unit']
