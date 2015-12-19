Gem::Specification.new do |s|
  s.name = "apt-pkg"
  s.version = '0.0.4'

  s.authors = ["Laurent Arnoud"]
  s.description = %q{Ruby interface to apt-pkg}
  s.summary = %q{Ruby interface to libapt-pkg}
  s.email = %q{laurent@spkdev.net}
  s.license = "MIT"
  s.extensions = ["ext/apt_pkg/extconf.rb"]
  s.extra_rdoc_files = Dir['*.md', 'ext/**/*.cpp']
  s.files = Dir['LICENSE', 'README.md', 'History.md', 'Gemfile', 'lib/**/*.rb',
                'ext/**/*', 'test/**/*']
  s.homepage = %q{http://github.com/spk/ruby-apt-pkg}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.add_development_dependency('rake', '~> 10')
  s.add_development_dependency('rake-compiler', '~> 0.9')
  s.add_development_dependency('minitest', '~> 5')
end
