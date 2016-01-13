#include "configuration.h"

/*
 * call-seq: architectures() -> array
 *
 * Return the list of architectures supported on this system.
 *
 *   Debian::AptPkg::Configuration.architectures # => ["amd64"]
 *
 **/
static VALUE
architectures(VALUE self)
{
  VALUE result = rb_ary_new();
  std::vector < std::string > arches = APT::Configuration::getArchitectures();
  std::vector < std::string >::const_iterator I;
  for (I = arches.begin(); I != arches.end(); ++I) {
    rb_ary_push(result, rb_str_new2((*I).c_str()));
  }
  return result;
}

/*
 * call-seq: check_architecture(arch) -> bool
 *
 * Are we interested in the given Architecture.
 *
 *   Debian::AptPkg::Configuration.check_architecture("all") # => true
 *
 **/
static VALUE
check_architecture(VALUE self, VALUE arch)
{
  int res = APT::Configuration::checkArchitecture(StringValuePtr(arch));
  return INT2BOOL(res);
}

/*
 * call-seq: languages() -> array
 *
 * Return the list of languages code.
 *
 * Params:
 *
 * +all+:: All languages code or short for false.
 *
 *   Debian::AptPkg::Configuration.languages # => ["en", "none", "fr"]
 *   Debian::AptPkg::Configuration.languages(false) # => ["en"]
 *
 **/
static VALUE
languages(int argc, VALUE *argv, VALUE self)
{
  VALUE all;
  rb_scan_args(argc, argv, "01", &all);
  VALUE result = rb_ary_new();
  std::vector < std::string > const langs =
    APT::Configuration::getLanguages(all);
  std::vector < std::string >::const_iterator I;
  for (I = langs.begin(); I != langs.end(); ++I) {
    rb_ary_push(result, rb_str_new2((*I).c_str()));
  }
  return result;
}

/*
 * call-seq: check_language(lang, all) -> bool
 *
 * Are we interested in the given language.
 *
 *   Debian::AptPkg::Configuration.check_language("fr") # => true
 *
 **/
static VALUE
check_language(int argc, VALUE *argv, VALUE self)
{
  if (argc > 2 || argc == 0) {
    rb_raise(rb_eArgError, "wrong number of arguments");
  }
  VALUE lang, all;
  rb_scan_args(argc, argv, "11", &lang, &all);
  int res = APT::Configuration::checkLanguage(StringValuePtr(lang), all);
  return INT2BOOL(res);
}

/*
 * call-seq: compressors() -> array
 *
 * Return the list of compressors supported on this system.
 *
 *   Debian::AptPkg::Configuration.compressors # => ["gz"]
 *
 **/
static VALUE
compressors(VALUE self)
{
  VALUE result = rb_ary_new();
  std::vector < std::string > cmps = APT::Configuration::getCompressionTypes();
  std::vector < std::string >::const_iterator I;
  for (I = cmps.begin(); I != cmps.end(); ++I) {
    rb_ary_push(result, rb_str_new2((*I).c_str()));
  }
  return result;
}

/*
 * call-seq: config_find(name, default_key = '') -> string
 *
 * Return the value stored at the option named key, or the value given by the
 * string default if the option in question is not set.
 *
 * Params:
 *
 * +name+:: Key name.
 * +default_key+:: Default key when config option not set.
 *
 *   Debian::AptPkg::Configuration.config_find('Dir::Etc::main') # => "apt.conf"
 *
 **/
static VALUE
config_find(int argc, VALUE *argv, VALUE self)
{
  if (argc > 2 || argc == 0) {
    rb_raise(rb_eArgError, "wrong number of arguments");
  }
  VALUE name, default_key;
  rb_scan_args(argc, argv, "11", &name, &default_key);
  if (NIL_P(default_key))
    default_key = rb_str_new2("");
  return rb_str_new2(_config->Find(StringValuePtr(name),
                                   StringValuePtr(default_key)).c_str());
}

/*
 * call-seq: config_find_file(name, default_key = '') -> string
 *
 * Locate the given key using find() and return the path to the file/directory.
 * This uses a special algorithms which moves upwards in the configuration space
 * and prepends the values of the options to the result. These methods are
 * generally used for the options stored in the ‘Dir’ section of the
 * configuration.
 *
 * Params:
 *
 * +name+:: Key name.
 * +default_key+:: Default key when config option not set.
 *
 *   Debian::AptPkg::Configuration.config_find_file('Dir::Etc::main') # => "/etc/apt/apt.conf"
 *
 **/
static VALUE
config_find_file(int argc, VALUE *argv, VALUE self)
{
  if (argc > 2 || argc == 0) {
    rb_raise(rb_eArgError, "wrong number of arguments");
  }
  VALUE name, default_key;
  rb_scan_args(argc, argv, "11", &name, &default_key);
  if (NIL_P(default_key))
    default_key = rb_str_new2("");
  return rb_str_new2(_config->FindFile(StringValuePtr(name),
                                       StringValuePtr(default_key)).c_str());
}

void
init_apt_pkg_configuration()
{
  VALUE rb_mDebian = rb_define_module("Debian");
  VALUE rb_mDebianAptPkg = rb_define_module_under(rb_mDebian, "AptPkg");
  VALUE rb_mDebianAptPkgConfiguration =
    rb_define_module_under(rb_mDebianAptPkg, "Configuration");

  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "architectures",
                             RUBY_METHOD_FUNC(architectures), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration,
                             "check_architecture",
                             RUBY_METHOD_FUNC(check_architecture), 1);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "languages",
                             RUBY_METHOD_FUNC(languages), -1);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "check_language",
                             RUBY_METHOD_FUNC(check_language), -1);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "compressors",
                             RUBY_METHOD_FUNC(compressors), 0);

  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "config_find",
                             RUBY_METHOD_FUNC(config_find), -1);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration,
                             "config_find_file",
                             RUBY_METHOD_FUNC(config_find_file), -1);
}
