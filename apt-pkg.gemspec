Gem::Specification.new do |s|
  s.name = "apt-pkg"
  s.version = '0.0.2'

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
  s.add_development_dependency('rake')
  s.add_development_dependency('rake-compiler')
  s.add_development_dependency('minitest')
  s.add_development_dependency('rdoc')
end
