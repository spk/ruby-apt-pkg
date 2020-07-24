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
      #
      # +id+:: [Integer] The numeric ID of the package
      #
      # +name+:: [String] The name of the package
      #
      # +full_name+:: [String] Get the full name of the package, including the
      #                        architecture
      #
      # +arch+:: [String] The architecture of the package
      #
      # +essential+:: [Boolean] Boolean value determining whether the package is
      #                         essential
      #
      # +important+:: [Boolean] Boolean value determining whether the package
      #                         has the 'important' flag set ('Important: yes'
      #                         in the Packages file)
      #
      # +current_version+:: [Version,NilClass] The version of the package
      #                                        currently installed or nil
      #
      # Returns a Package instance
      #
      #   new(42, "ed", "ed:amd64", "amd64", false, false, nil) # => Package
      #
      def initialize(id, name, full_name, arch, essential, important,
                     current_version)
        @id = id
        @name = name
        @full_name = full_name
        @arch = arch
        @essential = essential
        @important = important
        @current_version = current_version
      end

      # call-seq: is_installed -> bool
      #
      # Return +true+ if the package is installed
      #
      #   Debian::AptPkg::Package.new(id, pkg_name, full_name, arch,
      #                               essential, important,
      #                               current_version).is_installed # => true
      def is_installed
        return false unless current_version

        true
      end
    end
  end
end
