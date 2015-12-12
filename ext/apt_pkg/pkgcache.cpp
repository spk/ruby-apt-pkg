#include "pkgcache.h"

/*
 * call-seq: gen_caches() -> bool
 *
 * Call the main cache generator.
 *
 *   Debian::AptPkg::PkgCache.gen_caches # => false
 *
 **/
static
VALUE gen_caches(VALUE self) {
    pkgCacheFile CacheFile;
    int res = CacheFile.BuildCaches(NULL, true);
    return INT2BOOL(res);
}

/*
 * call-seq: pkg_names() -> array
 *
 * List the names of all packages in the system.
 *
 *   Debian::AptPkg::PkgCache.pkg_names('gcolor2') # => ["gcolor2"]
 *
 **/
static
VALUE pkg_names(int argc, VALUE* argv, VALUE self) {
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
    pkgCache::GrpIterator I = CacheFile.GetPkgCache()->GrpBegin();

    const char *pkgname = StringValuePtr(name);
    for (;I.end() != true; ++I) {
        if (strncmp(I.Name(), pkgname, strlen(pkgname)) == 0) {
            rb_ary_push(result, rb_str_new2(I.Name()));
        }
    }
    return result;
}

void
init_apt_pkg_pkgcache() {
    VALUE rb_mDebian = rb_define_module("Debian");
    VALUE rb_mDebianAptPkg = rb_define_module_under(rb_mDebian, "AptPkg");
    VALUE rb_mDebianAptPkgConfiguration = rb_define_module_under(rb_mDebianAptPkg,
            "PkgCache");

    rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "gen_caches",
            RUBY_METHOD_FUNC(gen_caches), 0);
    rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "pkg_names",
            RUBY_METHOD_FUNC(pkg_names), -1);
}
