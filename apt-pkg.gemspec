Gem::Specification.new do |s|
  s.name = "apt-pkg"
  s.version = '0.0.1'

  s.authors = ["Laurent Arnoud"]
  s.description = %q{Ruby interface to apt-pkg}
  s.summary = s.description
  s.email = %q{laurent@spkdev.net}
  s.license = "MIT"
  s.extensions = ["ext/apt_pkg/extconf.rb"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = `git ls-files`.split($\)
  s.homepage = %q{http://github.com/spk/ruby-apt-pkg}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.add_development_dependency('rake')
  s.add_development_dependency('rake-compiler')
  s.add_development_dependency('minitest')
  s.add_development_dependency('rdoc')
end
