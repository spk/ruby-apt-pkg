require_relative 'test_helper'

describe Debian::AptPkg::Configuration do
  before :all do
    Debian::AptPkg.init
  end

  it 'architectures return an array' do
    arches = Debian::AptPkg::Configuration.architectures
    _(arches).must_be_instance_of Array
    _(arches).wont_be_empty
  end

  it 'languages return an array' do
    all_langs = Debian::AptPkg::Configuration.languages
    _(all_langs).must_be_instance_of Array
    _(all_langs).wont_be_empty

    langs = Debian::AptPkg::Configuration.languages(false)
    _(langs).must_be_instance_of Array
  end

  it 'check_architecture' do
    _(Debian::AptPkg::Configuration.check_architecture('all')).must_equal true

    arches = Debian::AptPkg::Configuration.architectures
    c = Debian::AptPkg::Configuration.check_architecture(arches.first)
    _(c).must_equal true

    # http://buildd.debian-ports.org/status/fetch.php?pkg=ruby2.1&arch=m68k&ver=2.1.2-2&stamp=1400604298
    _(Debian::AptPkg::Configuration.check_architecture('m68k')).must_equal false
  end

  it 'check_language' do
    _(lambda do
      Debian::AptPkg::Configuration.check_language
    end).must_raise ArgumentError

    langs = Debian::AptPkg::Configuration.languages
    _(Debian::AptPkg::Configuration.check_language(langs.first)).must_equal true

    c = Debian::AptPkg::Configuration.check_language('gallifreyan')
    _(c).must_equal false
  end

  it 'compressors return an array' do
    cmps = Debian::AptPkg::Configuration.compressors
    _(cmps).must_be_instance_of Array
    _(cmps).wont_be_empty
    _(cmps).must_include 'gz'
  end

  it 'find configuration value' do
    _(lambda do
      Debian::AptPkg::Configuration.config_find
    end).must_raise ArgumentError

    _(Debian::AptPkg::Configuration.config_find('Dir::Etc::main'))
      .must_equal 'apt.conf'
    _(Debian::AptPkg::Configuration.config_find('Dir::Etc::netrc'))
      .must_equal 'auth.conf'
    _(Debian::AptPkg::Configuration.config_find('Dir::Etc::parts'))
      .must_equal 'apt.conf.d'
    _(Debian::AptPkg::Configuration.config_find('Spk', 'DebianUser'))
      .must_equal 'DebianUser'
  end

  it 'find file' do
    _(lambda do
      Debian::AptPkg::Configuration.config_find_file
    end).must_raise ArgumentError

    _(Debian::AptPkg::Configuration.config_find_file('Dir::Etc::main'))
      .must_equal '/etc/apt/apt.conf'
    _(Debian::AptPkg::Configuration.config_find_file('Dir::Etc::netrc'))
      .must_equal '/etc/apt/auth.conf'
  end
end
