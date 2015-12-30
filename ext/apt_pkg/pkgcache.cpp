#include "pkgcache.h"

/*
 * private
 */
bool config_system_initialized() {
  string const arch = _config->Find("APT::Architecture");
  if (arch.empty()) {
    return false;
  }
  return true;
}

/*
 * call-seq: gen_caches() -> bool
 *
 * Call the main cache generator.
 * Return `nil` when config, system, cache is not configured.
 *
 *   Debian::AptPkg::PkgCache.gen_caches # => false
 *
 **/
static
VALUE gen_caches(VALUE self) {
  if (!config_system_initialized()) {
    return Qnil;
  }
  pkgCacheFile CacheFile;
  int res = CacheFile.BuildCaches(NULL, true);
  return INT2BOOL(res);
}

/*
 * call-seq: is_multi_arch() -> bool
 *
 * An attribute determining whether the cache supports multi-arch.
 * Return `nil` when config, system, cache is not configured.
 *
 *   Debian::AptPkg::PkgCache.is_multi_arch # => false
 *
 **/
static
VALUE is_multi_arch(VALUE self) {
  if (!config_system_initialized()) {
    return Qnil;
  }
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  int res = Cache->MultiArchCache();
  return INT2BOOL(res);
}

/*
 * call-seq: pkg_names() -> array, nil
 *
 * List the names of all packages in the system.
 * Return `nil` when config, system, cache is not configured.
 *
 *   Debian::AptPkg::PkgCache.pkg_names('gcolor2') # => ["gcolor2"]
 *
 **/
static
VALUE pkg_names(int argc, VALUE* argv, VALUE self) {
  if (!config_system_initialized()) {
    return Qnil;
  }
  if (argc > 1 || argc == 0) {
    rb_raise(rb_eArgError, "You must give at least one search argument");
  }
  VALUE name;
  rb_scan_args(argc, argv, "01", &name);
  if (NIL_P(name) || RSTRING_LEN(name) < 1) {
    rb_raise(rb_eArgError, "You must give at least one search pattern");
  }
  VALUE result = rb_ary_new();

  pkgCacheFile CacheFile;
  if (CacheFile.GetPkgCache() == 0) {
    return Qnil;
  }
  pkgCache::GrpIterator I = CacheFile.GetPkgCache()->GrpBegin();

  const char *pkgname = StringValuePtr(name);
  for (;I.end() != true; ++I) {
    if (strncmp(I.Name(), pkgname, strlen(pkgname)) == 0) {
      rb_ary_push(result, rb_str_new2(I.Name()));
    }
  }
  return result;
}

/*
 * call-seq: package_count() -> int, nil
 *
 * The total number of packages available in the cache.
 * Return `nil` when cache is not generated.
 *
 *   Debian::AptPkg::PkgCache.package_count # => 69511
 *
 **/
static
VALUE package_count(VALUE self) {
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  return INT2FIX(Cache->HeaderP->PackageCount);
}

/*
 * call-seq: version_count() -> int, nil
 *
 * The total number of package versions available in the cache.
 * Return `nil` when cache is not generated.
 *
 *   Debian::AptPkg::PkgCache.version_count # => 84630
 *
 **/
static
VALUE version_count(VALUE self) {
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  return INT2FIX(Cache->HeaderP->VersionCount);
}

/*
 * call-seq: depends_count() -> int, nil
 *
 * The total number of dependencies stored in the cache.
 * Return `nil` when cache is not generated.
 *
 *   Debian::AptPkg::PkgCache.depends_count # => 551983
 *
 **/
static
VALUE depends_count(VALUE self) {
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  return INT2FIX(Cache->HeaderP->DependsCount);
}

/*
 * call-seq: package_file_count() -> int, nil
 *
 * The total number of packages files available.
 * Return `nil` when cache is not generated.
 *
 *   Debian::AptPkg::PkgCache.package_file_count # => 17
 *
 **/
static
VALUE package_file_count(VALUE self) {
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  return INT2FIX(Cache->HeaderP->PackageFileCount);
}

/*
 * call-seq: ver_file_count() -> int, nil
 *
 * The total number of version and package file relations stored in the cache.
 * Return `nil` when cache is not generated.
 *
 *   Debian::AptPkg::PkgCache.ver_file_count # => 11274
 *
 **/
static
VALUE ver_file_count(VALUE self) {
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  return INT2FIX(Cache->HeaderP->VerFileCount);
}

/*
 * call-seq: provides_count() -> int, nil
 *
 * The number of provided packages.
 * Return `nil` when cache is not generated.
 *
 *   Debian::AptPkg::PkgCache.provides_count # => 69511
 *
 **/
static
VALUE provides_count(VALUE self) {
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  return INT2FIX(Cache->HeaderP->ProvidesCount);
}

/*
 * call-seq: group_count() -> int, nil
 *
 * The number of groups in the cache.
 * Return `nil` when cache is not generated.
 *
 *   Debian::AptPkg::PkgCache.group_count # => 16730
 *
 **/
static
VALUE group_count(VALUE self) {
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  return INT2FIX(Cache->HeaderP->GroupCount);
}

void
init_apt_pkg_pkgcache() {
  VALUE rb_mDebian = rb_define_module("Debian");
  VALUE rb_mDebianAptPkg = rb_define_module_under(rb_mDebian, "AptPkg");
  VALUE rb_mDebianAptPkgConfiguration = rb_define_module_under(rb_mDebianAptPkg,
      "PkgCache");

  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "gen_caches",
      RUBY_METHOD_FUNC(gen_caches), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "is_multi_arch",
      RUBY_METHOD_FUNC(is_multi_arch), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "pkg_names",
      RUBY_METHOD_FUNC(pkg_names), -1);

  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "package_count",
      RUBY_METHOD_FUNC(package_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "version_count",
      RUBY_METHOD_FUNC(version_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "depends_count",
      RUBY_METHOD_FUNC(depends_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "package_file_count",
      RUBY_METHOD_FUNC(package_file_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "ver_file_count",
      RUBY_METHOD_FUNC(ver_file_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "provides_count",
      RUBY_METHOD_FUNC(provides_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "group_count",
      RUBY_METHOD_FUNC(group_count), 0);
}
