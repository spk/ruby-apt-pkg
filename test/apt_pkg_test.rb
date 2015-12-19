require_relative 'test_helper'

describe Debian::AptPkg do
  describe '.cmp_version' do
    it 'should compare version' do
      Debian::AptPkg.cmp_version('1.1', '1.0').must_be :>, 0
      Debian::AptPkg.cmp_version('1.0', '1.0').must_be :==, 0
      Debian::AptPkg.cmp_version('1.0', '1.1').must_be :<, 0
    end
  end

  describe '.check_dep' do
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
        Debian::AptPkg.check_dep('1', Debian::AptPkg::NOT_EQUALS, '2')
          .must_equal true
        Debian::AptPkg.check_dep('2', Debian::AptPkg::NOT_EQUALS, '1')
          .must_equal true
        Debian::AptPkg.check_dep('1', Debian::AptPkg::NOT_EQUALS, '1')
          .must_equal false
      end
    end

    describe 'Errors' do
      it 'should raise argument error with bad comparison' do
        lambda do
          Debian::AptPkg.check_dep('1', 'bad', '2')
        end.must_raise ArgumentError
      end
    end
  end

  describe '.uri_to_filename' do
    it 'should return a filename which can be used to store the file' do
      Debian::AptPkg.uri_to_filename('http://debian.org/index.html')
        .must_equal 'debian.org_index.html'
    end
  end

  describe '.upstream_version' do
    it 'Return the upstream version for the Debian package version' do
      Debian::AptPkg.upstream_version('3.4.15-1+b1').must_equal '3.4.15'
    end
  end

  describe '.time_to_str' do
    it 'Format a given duration in human-readable manner' do
      Debian::AptPkg.time_to_str(3601).must_equal '1h 0min 1s'
    end
  end

  describe '.size_to_str' do
    it 'Return a string describing the size in a human-readable manner' do
      Debian::AptPkg.size_to_str(10_000).must_equal '10.0 k'
    end
  end

  describe '.string_to_bool' do
    it 'Parse the string input and return a boolean' do
      Debian::AptPkg.string_to_bool('yes').must_equal true
      Debian::AptPkg.string_to_bool('no').must_equal false
      Debian::AptPkg.string_to_bool('no-recognized').must_equal false
    end
  end

  describe '.check_domain_list' do
    it 'See if the host name given by host is one of the domains given' do
      Debian::AptPkg.check_domain_list('alioth.debian.org',
                                       'debian.net,debian.org').must_equal true
      Debian::AptPkg.check_domain_list('git.debian.org',
                                       'spkdev.net').must_equal false
    end
  end
end
