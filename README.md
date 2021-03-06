# Ruby interface to apt-pkg

Goal of this project is to have a proper Ruby binding to APT like in
[Python](https://tracker.debian.org/pkg/python-apt).

Currently install, remove packages commands are **not** implemented.

## INSTALL

```
apt install build-essential ruby-dev libapt-pkg-dev (>= 1.0)
gem install apt-pkg
```

## USING

Basic usage:

``` ruby
require 'debian/apt_pkg'

# Initialize the configuration and system of apt
Debian::AptPkg.init

# Update the index files used by the cache
Debian::AptPkg::PkgCache.update

# List packages stored in the cache
Debian::AptPkg::PkgCache.packages

# List installed packages
Debian::AptPkg::PkgCache.packages.select { |pkg| pkg.is_installed }
```

[Documentation](http://www.rubydoc.info/gems/apt-pkg)

## BUILD

``` console
rake compile
```

## TEST

``` console
rake test
```

## LICENSE

The MIT License

Copyright (c) 2014-2020 Laurent Arnoud <laurent@spkdev.net>

---
[![Build](https://img.shields.io/gitlab/pipeline/spkdev/ruby-apt-pkg/master)](https://gitlab.com/spkdev/ruby-apt-pkg/-/commits/master)
[![Version](https://img.shields.io/gem/v/apt-pkg.svg)](https://rubygems.org/gems/apt-pkg)
[![Documentation](https://img.shields.io/badge/doc-rubydoc-blue.svg)](http://www.rubydoc.info/gems/apt-pkg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT "MIT")
[![Project status](https://img.shields.io/badge/status-experimental-red)](https://github.com/spk/ruby-apt-pkg)
