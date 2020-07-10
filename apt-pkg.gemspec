version_file = 'lib/debian/apt_pkg/version'
require File.expand_path("../#{version_file}", __FILE__)

Gem::Specification.new do |s|
  s.name = 'apt-pkg'
  s.version = Debian::AptPkg::VERSION

  s.authors = ['Laurent Arnoud']
  s.email = 'laurent@spkdev.net'

  s.description = 'Ruby interface to apt-pkg'
  s.summary = 'Ruby interface to libapt-pkg'
  s.homepage = 'http://github.com/spk/ruby-apt-pkg'
  s.license = 'MIT'

  s.extensions = ['ext/apt_pkg/extconf.rb']
  s.extra_rdoc_files = Dir['*.md', 'ext/**/*.cpp']
  s.files = Dir['LICENSE', 'README.md', 'History.md', 'Gemfile', 'lib/**/*.rb',
                'ext/**/*', 'test/**/*']
  s.rdoc_options = ['--charset=UTF-8']
  s.require_paths = ['lib']
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('rake-compiler', '~> 1.0')
  s.add_development_dependency('minitest', '~> 5.13')
end
