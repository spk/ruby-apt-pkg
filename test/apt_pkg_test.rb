# encoding: UTF-8
require_relative 'test_helper'

describe Debian::AptPkg do

  describe 'Debian::AptPkg.cmp_version' do
    it 'should compare version' do
      Debian::AptPkg.cmp_version('1.1', '1.0').must_be :>, 0
      Debian::AptPkg.cmp_version('1.0', '1.0').must_be :==, 0
      Debian::AptPkg.cmp_version('1.0', '1.1').must_be :<, 0
    end
  end

  describe 'Debian::AptPkg.check_dep' do
    describe 'LessEq' do
      it 'should compare Debian version' do
        Debian::AptPkg.check_dep('1', '<=', '2').must_equal true
        Debian::AptPkg.check_dep('2', '<=', '1').must_equal false
        Debian::AptPkg.check_dep('1', '<=', '1').must_equal true
      end
    end

    describe 'GreaterEq' do
      it 'should compare Debian version' do
        Debian::AptPkg.check_dep('1', '>=', '2').must_equal false
        Debian::AptPkg.check_dep('2', '>=', '1').must_equal true
        Debian::AptPkg.check_dep('1', '>=', '1').must_equal true
      end
    end

    describe 'Less' do
      it 'should compare Debian version' do
        Debian::AptPkg.check_dep('1', '<', '2').must_equal true
        Debian::AptPkg.check_dep('2', '<', '1').must_equal false
        Debian::AptPkg.check_dep('1', '<', '1').must_equal false
      end
    end

    describe 'Greater' do
      it 'should compare Debian version' do
        Debian::AptPkg.check_dep('1', '>', '2').must_equal false
        Debian::AptPkg.check_dep('2', '>', '1').must_equal true
        Debian::AptPkg.check_dep('1', '>', '1').must_equal false
      end
    end

    describe 'Equals' do
      it 'should compare Debian version' do
        Debian::AptPkg.check_dep('1', '=', '2').must_equal false
        Debian::AptPkg.check_dep('2', '=', '1').must_equal false
        Debian::AptPkg.check_dep('1', '=', '1').must_equal true
      end
    end

    describe 'NotEquals' do
      it 'should compare Debian version' do
        Debian::AptPkg.check_dep('1', Debian::AptPkg::NOT_EQUALS, '2').
          must_equal true
        Debian::AptPkg.check_dep('2', Debian::AptPkg::NOT_EQUALS, '1').
          must_equal true
        Debian::AptPkg.check_dep('1', Debian::AptPkg::NOT_EQUALS, '1').
          must_equal false
      end
    end

    describe 'Errors' do
      it 'should raise argument error with bad comparison' do
        lambda {
          Debian::AptPkg.check_dep('1', 'bad', '2')
        }.must_raise ArgumentError
      end
    end
  end

  describe 'Debian::AptPkg.uri_to_filename' do
    it 'should return a filename which can be used to store the file' do
      Debian::AptPkg.uri_to_filename('http://debian.org/index.html').
        must_equal 'debian.org_index.html'
    end
  end

  describe 'Debian::AptPkg.upstream_version' do
    it 'Return the upstream version for the Debian package version' do
      Debian::AptPkg.upstream_version('3.4.15-1+b1').must_equal '3.4.15'
    end
  end

  describe 'Debian::AptPkg.time_to_str' do
    it 'Format a given duration in human-readable manner' do
      Debian::AptPkg.time_to_str(3601).must_equal '1h 0min 1s'
    end
  end

  describe 'Debian::AptPkg.size_to_str' do
    it 'Return a string describing the size in a human-readable manner' do
      Debian::AptPkg.size_to_str(10000).must_equal '10.0 k'
    end
  end

  describe 'Debian::AptPkg.string_to_bool' do
    it 'Parse the string input and return a boolean' do
      Debian::AptPkg.string_to_bool('yes').must_equal true
      Debian::AptPkg.string_to_bool('no').must_equal false
      Debian::AptPkg.string_to_bool('no-recognized').must_equal false
    end
  end

  describe 'Debian::AptPkg.check_domain_list' do
    it 'See if the host name given by host is one of the domains given' do
      Debian::AptPkg.check_domain_list("alioth.debian.org",
                                       "debian.net,debian.org").must_equal true
      Debian::AptPkg.check_domain_list("git.debian.org",
                                       "spkdev.net").must_equal false
    end
  end


  describe 'Debian::AptPkg::Configuration' do
    it 'architectures return an array' do
      arches = Debian::AptPkg::Configuration.architectures
      arches.must_be_instance_of Array
      arches.wont_be_empty
    end

    it 'languages return an array' do
      all_langs = Debian::AptPkg::Configuration.languages
      all_langs.must_be_instance_of Array
      all_langs.wont_be_empty

      langs = Debian::AptPkg::Configuration.languages(false)
      langs.must_be_instance_of Array
      langs.wont_be_empty

      all_langs.must_include langs.first
    end

    it 'check_architecture' do
      Debian::AptPkg::Configuration.check_architecture('all').must_equal true

      arches = Debian::AptPkg::Configuration.architectures
      c = Debian::AptPkg::Configuration.check_architecture(arches.first)
      c.must_equal true

      # http://buildd.debian-ports.org/status/fetch.php?pkg=ruby2.1&arch=m68k&ver=2.1.2-2&stamp=1400604298
      Debian::AptPkg::Configuration.check_architecture('m68k').must_equal false
    end

    it 'check_language' do
      lambda {
        Debian::AptPkg::Configuration.check_language
      }.must_raise ArgumentError

      Debian::AptPkg::Configuration.check_language('fr').must_equal true

      Debian::AptPkg::Configuration.check_language('fr', false).must_equal false

      langs = Debian::AptPkg::Configuration.languages
      Debian::AptPkg::Configuration.check_language(langs.first).must_equal true

      c = Debian::AptPkg::Configuration.check_language('gallifreyan')
      c.must_equal false
    end

    it 'compressors return an array' do
      cmps = Debian::AptPkg::Configuration.compressors
      cmps.must_be_instance_of Array
      cmps.wont_be_empty
      cmps.must_include 'gz'
    end
  end
end
