# frozen_string_literal: true
require_relative '../../test_helper'

describe Debian::AptPkg::Package do
  let(:id) { 42 }
  let(:pkg_name) { "ed" }
  let(:full_name) { "ed:i386" }
  let(:arch) { "i386" }
  let(:essential) { false }
  let(:important) { false }
  let(:current_version) { nil }

  describe '.new' do
    describe 'with correct number of arguments' do
      it 'can initialize a Package class' do
        Debian::AptPkg::Package.new(id, pkg_name, full_name, arch,
                                    essential, important, current_version)
      end
    end

    describe 'with wrong number of arguments' do
      it 'cannot initialize a Package class' do
        _(lambda do
          Debian::AptPkg::Package.new(id, pkg_name, full_name, arch,
                                      essential, important)
        end).must_raise ArgumentError
      end
    end
  end

  describe '#is_installed' do
    subject do
      Debian::AptPkg::Package.new(id, pkg_name, full_name, arch,
                                  essential, important,
                                  current_version).is_installed
    end

    describe 'when current_version is present' do
      let(:current_version) do
        Debian::AptPkg::Version.new("ed", "1", "editors", "i386", 0, 0, 0, 0, 4)
      end

      it 'returns true' do
        _(subject).must_equal true
      end
    end

    describe 'when current_version is not present' do
      let(:current_version) { nil }

      it 'returns false' do
        _(subject).must_equal false
      end
    end
  end
end
