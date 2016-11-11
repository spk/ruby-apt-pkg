require_relative 'test_helper'

describe Debian::AptPkg::PkgCache do
  describe 'not init' do
    describe '.update' do
      it 'can be called' do
        lambda do
          Debian::AptPkg::PkgCache.update
        end.must_raise Debian::AptPkg::InitError
      end
    end

    %i(package version depends package_file ver_file provides group).each do |m|
      describe ".#{m}_count" do
        it 'can be called' do
          lambda do
            Debian::AptPkg::PkgCache.public_send("#{m}_count")
          end.must_raise Debian::AptPkg::InitError
        end
      end
    end
  end
end
