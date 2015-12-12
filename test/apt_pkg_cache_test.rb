require_relative 'test_helper'

describe Debian::AptPkg::PkgCache do
  describe '.gen_caches' do
    it 'return boolean' do
      Debian::AptPkg::PkgCache.gen_caches.must_be :==, false
    end
  end

  describe '.pkg_names' do
    it 'argument' do
      lambda {
        Debian::AptPkg::PkgCache.pkg_names
      }.must_raise ArgumentError

      lambda {
        Debian::AptPkg::PkgCache.pkg_names(nil)
      }.must_raise ArgumentError

      lambda {
        Debian::AptPkg::PkgCache.pkg_names("")
      }.must_raise ArgumentError
    end

    it 'be filtered' do
      search = Debian::AptPkg::PkgCache.pkg_names("vim")
      search.must_include "vim"
      search.must_include "vim-nox"
      search.must_include "vim-gtk"
      search.wont_include "emacs"
    end
  end
end
