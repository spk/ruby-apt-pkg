# Ruby interface to apt-pkg

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

## REFERENCES

* http://apt.alioth.debian.org/python-apt-doc/library/apt_pkg.html

## LICENSE

The MIT License

Copyright (c) 2014-2015 Laurent Arnoud <laurent@spkdev.net>
