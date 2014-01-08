# Ruby interface to apt-pkg

## INSTALL

~~~ console
aptitude install libapt-pkg-dev ruby2.0-dev
gem install apt-pkg
~~~

## USING

~~~ ruby
require 'apt_pkg'

Debian::AptPkg.check_dep('1', '<', '2') # => true
Debian::AptPkg.check_dep('1', Debian::AptPkg::NOT_EQUALS, '2') # => true
Debian::AptPkg.check_domain_list("alioth.debian.org", "debian.net,debian.org") # => true
Debian::AptPkg.cmp_version('1.1', '1.0') # => 1
Debian::AptPkg.size_to_str(10000) # => '10.0 k'
Debian::AptPkg.string_to_bool('yes') # => 1
Debian::AptPkg.time_to_str(3601) # => '1h 0min 1s'
Debian::AptPkg.upstream_version('3.4.15-1+b1') # => '3.4.15'
Debian::AptPkg.uri_to_filename('http://debian.org/index.html') # => 'debian.org_index.html'
Debian::AptPkg.architectures # => ["amd64"]
~~~

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
