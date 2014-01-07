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
  rd.rdoc_files.include("ext/**/*.cpp")
end

task default: [:test]
