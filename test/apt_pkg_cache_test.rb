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

  describe '.is_multi_arch' do
    it 'can be called' do
      Debian::AptPkg::PkgCache.is_multi_arch
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

  %i(package version depends package_file ver_file provides group).each do |m|
    describe ".#{m}_count" do
      it 'return an int' do
        if Process.uid == 0
          Debian::AptPkg::PkgCache.public_send("#{m}_count").must_be :>=, 0
        end
      end
    end
  end
end
