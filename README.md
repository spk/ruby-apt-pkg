# Ruby interface to apt-pkg

Goal of this project is to have a proper Ruby binding to APT like in
[Python](https://apt.alioth.debian.org/python-apt-doc/library/apt_pkg.html).

Currently install, remove packages commands are **not** implemented.

Simple search is implemented with:

~~~ ruby
require 'apt_pkg'
Debian::AptPkg::PkgCache.pkg_names("vim")
~~~

## INSTALL

~~~ console
aptitude install build-essential ruby-dev libapt-pkg-dev (~> 1.0)
gem install apt-pkg
~~~

## USING

~~~ ruby
require 'apt_pkg'
~~~

See https://spk.github.io/ruby-apt-pkg/

## BUILD

~~~ console
gem install bundler
bundle install
bundle exec rake compile
~~~

## TEST

~~~ console
bundle exec rake test
~~~

## LICENSE

The MIT License

Copyright (c) 2014-2015 Laurent Arnoud <laurent@spkdev.net>

---
[![IRC Network](https://img.shields.io/badge/irc-oftc-blue.svg)](https://webchat.oftc.net/ "#ruby-apt-pkg")
[![Gem Version](https://badge.fury.io/rb/apt-pkg.svg)](https://rubygems.org/gems/apt-pkg)
[![Build Status](https://secure.travis-ci.org/spk/ruby-apt-pkg.svg?branch=master)](https://travis-ci.org/spk/ruby-apt-pkg)
[![License](https://img.shields.io/github/license/spk/ruby-apt-pkg.svg)](http://opensource.org/licenses/MIT)
