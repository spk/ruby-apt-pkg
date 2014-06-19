# Ruby interface to apt-pkg

## INSTALL

~~~ console
aptitude install libapt-pkg-dev ruby-dev
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

Copyright (c) 2014 Laurent Arnoud <laurent@spkdev.net>
