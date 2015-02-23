require 'rake/extensiontask'
require 'rake/testtask'
require 'rdoc/task'

Rake::ExtensionTask.new('apt_pkg')

Rake::Task[:test].prerequisites << :clean
Rake::Task[:test].prerequisites << :compile

Rake::TestTask.new do |t|
    t.pattern = 'test/**/*_test.rb'
end

RDoc::Task.new do |rd|
  rd.main = "README.md"
  rd.rdoc_files.include("README.md", "ext/**/*.cpp")
  rd.options << "--all"
  rd.title = "ruby-apt-pkg"
end

task :lint do
  sh('cppcheck --error-exitcode=1 --quiet --enable=all --inconclusive --std=posix ext/apt_pkg') do |ok, res|
    unless ok
      puts "lint error (status = #{res.exitstatus})"
    end
  end
end

task default: [:test]
