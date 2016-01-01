require_relative 'test_helper'

describe Debian::AptPkg::PkgCache do
  describe 'not init' do
    %i(package version depends package_file ver_file provides group).each do |m|
      describe ".#{m}_count" do
        it 'can be called' do
          Debian::AptPkg::PkgCache.public_send("#{m}_count")
        end
      end
    end
  end
end
