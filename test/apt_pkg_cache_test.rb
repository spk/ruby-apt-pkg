require_relative 'test_helper'

describe Debian::AptPkg::PkgCache do
  describe '.gen_caches' do
    it 'return boolean' do
      if Process.uid == 0
        Debian::AptPkg::PkgCache.gen_caches.must_equal true
      else
        Debian::AptPkg::PkgCache.gen_caches.must_equal false
      end
    end
  end

  describe '.pkg_names' do
    it 'no argument' do
      lambda do
        Debian::AptPkg::PkgCache.pkg_names
      end.must_raise ArgumentError
    end
    it 'nil argument' do
      lambda do
        Debian::AptPkg::PkgCache.pkg_names(nil)
      end.must_raise ArgumentError
    end

    it 'blank argument' do
      lambda do
        Debian::AptPkg::PkgCache.pkg_names('')
      end.must_raise ArgumentError
    end

    it 'be filtered' do
      search = Debian::AptPkg::PkgCache.pkg_names('vim')
      # CI specific cache can not be present
      unless search.nil? || search.empty?
        search.must_include 'vim'
        search.must_include 'vim-nox'
        search.must_include 'vim-gtk'
        search.wont_include 'emacs'
      end
    end
  end
end
