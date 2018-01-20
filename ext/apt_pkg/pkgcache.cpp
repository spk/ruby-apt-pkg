#include "pkgcache.h"

static VALUE e_mDebianAptPkgInitError;

/*
 * private
 */
bool
config_system_initialized()
{
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.gen_caches # => false
 *
 **/
static VALUE
gen_caches(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
  pkgCacheFile CacheFile;
  int res = CacheFile.BuildCaches(NULL, true);
  return INT2BOOL(res);
}

/*
 * call-seq: update() -> bool
 *
 * Update the index files used by the cache.
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.update # => false
 *
 **/
static VALUE
update(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
  pkgCacheFile CacheFile;
  // Get the source list
  if (CacheFile.BuildSourceList() == false) {
    return Qnil;
  }
  pkgAcquireStatus *Stat(NULL);
  pkgSourceList *List = CacheFile.GetSourceList();
  int res = ListUpdate(*Stat, *List);
  return INT2BOOL(res);
}

/*
 * call-seq: is_multi_arch() -> bool
 *
 * An attribute determining whether the cache supports multi-arch.
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.is_multi_arch # => false
 *
 **/
static VALUE
is_multi_arch(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.pkg_names('gcolor2') # => ["gcolor2"]
 *
 **/
static VALUE
pkg_names(int argc, VALUE *argv, VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
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
  for (; I.end() != true; ++I) {
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.package_count # => 69511
 *
 **/
static VALUE
package_count(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.version_count # => 84630
 *
 **/
static VALUE
version_count(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.depends_count # => 551983
 *
 **/
static VALUE
depends_count(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.package_file_count # => 17
 *
 **/
static VALUE
package_file_count(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.ver_file_count # => 11274
 *
 **/
static VALUE
ver_file_count(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.provides_count # => 69511
 *
 **/
static VALUE
provides_count(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
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
 * Raise `Debian::AptPkg::InitError` when config, system, cache is not
 * configured.
 *
 *   Debian::AptPkg::PkgCache.group_count # => 16730
 *
 **/
static VALUE
group_count(VALUE self)
{
  if (!config_system_initialized()) {
    rb_raise(e_mDebianAptPkgInitError, "System not initialized");
  }
  pkgCacheFile CacheFile;
  pkgCache *Cache = CacheFile.GetPkgCache();
  if (Cache == NULL) {
    return Qnil;
  }
  return INT2FIX(Cache->HeaderP->GroupCount);
}

void
init_apt_pkg_pkgcache()
{
  VALUE rb_mDebian = rb_define_module("Debian");
  VALUE rb_mDebianAptPkg = rb_define_module_under(rb_mDebian, "AptPkg");
  VALUE rb_mDebianAptPkgCache = rb_define_module_under(rb_mDebianAptPkg,
                                                               "PkgCache");
  e_mDebianAptPkgInitError = rb_define_class_under(rb_mDebianAptPkg,
                                                    "InitError",
                                                    rb_eRuntimeError);

  rb_define_singleton_method(rb_mDebianAptPkgCache, "gen_caches",
                             RUBY_METHOD_FUNC(gen_caches), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache, "update",
                             RUBY_METHOD_FUNC(update), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache, "is_multi_arch",
                             RUBY_METHOD_FUNC(is_multi_arch), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache, "pkg_names",
                             RUBY_METHOD_FUNC(pkg_names), -1);

  rb_define_singleton_method(rb_mDebianAptPkgCache, "package_count",
                             RUBY_METHOD_FUNC(package_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache, "version_count",
                             RUBY_METHOD_FUNC(version_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache, "depends_count",
                             RUBY_METHOD_FUNC(depends_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache,
                             "package_file_count",
                             RUBY_METHOD_FUNC(package_file_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache, "ver_file_count",
                             RUBY_METHOD_FUNC(ver_file_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache, "provides_count",
                             RUBY_METHOD_FUNC(provides_count), 0);
  rb_define_singleton_method(rb_mDebianAptPkgCache, "group_count",
                             RUBY_METHOD_FUNC(group_count), 0);
}
