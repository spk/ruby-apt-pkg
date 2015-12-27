$VERBOSE = true
require 'minitest/autorun'
require 'minitest/pride'
require 'pp'

require_relative '../lib/debian/apt_pkg'

Debian::AptPkg.init
