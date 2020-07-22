# frozen_string_literal: true
require_relative '../../test_helper'

describe Debian::AptPkg::PkgCache do
  before :all do
    Debian::AptPkg.init
  end

  describe '.update' do
    it 'can be called' do
      Debian::AptPkg::PkgCache.update
    end
  end

  describe '.gen_caches' do
    it 'return boolean' do
      if Process.uid == 0
        _(Debian::AptPkg::PkgCache.gen_caches).must_equal true
      else
        _(Debian::AptPkg::PkgCache.gen_caches).must_equal false
      end
    end
  end

  describe '.is_multi_arch' do
    it 'can be called' do
      Debian::AptPkg::PkgCache.is_multi_arch
    end
  end

  describe '.packages' do
    it 'returns an array of Package' do
      packages = Debian::AptPkg::PkgCache.packages
      _(packages).must_be_kind_of Array
      _(packages.first).must_be_kind_of Debian::AptPkg::Package
      libapt = packages.find { |pkg| pkg.name == 'libapt-pkg-dev'  }
      _(libapt.id).must_be_kind_of Numeric
      _(libapt.name).must_equal 'libapt-pkg-dev'
      _(libapt.full_name).must_match(/libapt-pkg-dev:(\w)/)
      _(libapt.arch).must_match(/(\w)/)
      _([true, false]).must_include libapt.essential
      _([true, false]).must_include libapt.important
      _(libapt.current_version).must_be_kind_of Debian::AptPkg::Version
      _(libapt.current_version.parent_package_name).must_equal libapt.name
      _(libapt.current_version.version_string).must_be_kind_of String
      _(libapt.current_version.section).must_equal 'libdevel'
      _(libapt.current_version.arch).must_equal libapt.arch
      _(libapt.current_version.size).must_be_kind_of Numeric
      _(libapt.current_version.installed_size).must_be_kind_of Numeric
      _(libapt.current_version.hash).must_be_kind_of Numeric
      _(libapt.current_version.id).must_be_kind_of Numeric
      _(libapt.current_version.priority).must_be_kind_of Numeric
    end
  end

  describe '.pkg_names' do
    it 'is deprecated' do
      out, err = capture_io do
        Debian::AptPkg::PkgCache.pkg_names('libapt-pkg-dev')
      end
      _(out).must_equal ''
      regexp = /warning:\sDebian::AptPkg::PkgCache\.pkg_names\sis\sdeprecated;\s
      use\sDebian::AptPkg::PkgCache\.packages\sinstead/x
      _(err).must_match(regexp)
    end

    it 'no argument' do
      _(lambda do
        capture_io do
          Debian::AptPkg::PkgCache.pkg_names
        end
      end).must_raise ArgumentError
    end

    it 'nil argument' do
      _(lambda do
        capture_io do
          Debian::AptPkg::PkgCache.pkg_names(nil)
        end
      end).must_raise ArgumentError
    end

    it 'blank argument' do
      _(lambda do
        capture_io do
          Debian::AptPkg::PkgCache.pkg_names('')
        end
      end).must_raise ArgumentError
    end

    it 'be filtered' do
      capture_io do
        search = Debian::AptPkg::PkgCache.pkg_names('vim')
        # CI specific cache can not be present
        unless search.nil? || search.empty?
          _(search).must_include 'vim'
          _(search).must_include 'vim-nox'
          _(search).must_include 'vim-gtk'
          _(search).wont_include 'emacs'
        end
      end
    end
  end

  %i(package version depends package_file ver_file provides group).each do |m|
    describe ".#{m}_count" do
      it 'return an int' do
        if Process.uid == 0
          _(Debian::AptPkg::PkgCache.public_send("#{m}_count")).must_be :>=, 0
        end
      end
    end
  end
end
