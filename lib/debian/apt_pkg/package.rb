# frozen_string_literal: true
# Debian::AptPkg::Package file
module Debian
  # AptPkg base module
  module AptPkg
    # Debian::AptPkg::Package class
    # Representation of a package in a cache
    class Package
      attr_accessor :id, :name, :full_name, :arch, :essential, :important,
        :current_version

      # Initialize the Package class
      # @example
      #   new(id, name, full_name, arch, essential, important, current_version)
      # @param [Integer] The numeric ID of the package
      # @param [String] The name of the package
      # @param [String] Get the full name of the package, including the
      #                 architecture
      # @param [String] The architecture of the package
      # @param [Boolean] Boolean value determining whether the package is
      #                  essential
      # @param [Boolean] Boolean value determining whether the package has the
      #                 'important' flag set
      #                 ('Important: yes' in the Packages file)
      # @param [Version,NilClass] The version of the package currently installed
      #                           or `nil`
      # @return [Package] Package instance
      def initialize(id, name, full_name, arch, essential, important, current_version)
        @id = id
        @name = name
        @full_name = full_name
        @arch = arch
        @essential = essential
        @important = important
        @current_version = current_version
      end

      # Return `true` if the package is installed
      # @return [Boolean]
      def is_installed
        return false unless current_version

        true
      end
    end
  end
end
