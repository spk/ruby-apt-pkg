#include "pkgcache.h"

/*
 * call-seq: find_pkg() -> array
 *
 * Return the list packages supported on this system.
 *
 *   Debian::AptPkg::PkgCache.find_pkg('gcolor2') # => ["gcolor2"]
 *
 **/
static
VALUE find_pkg(VALUE self, VALUE name) {
	std::string pkgname = APT::String::Strip(StringValuePtr(name));
	VALUE result = rb_ary_new();

	rb_ary_push(result, rb_str_new2(pkgname.c_str()));
	return result;
}

void
init_apt_pkg_pkgcache() {
	VALUE rb_mDebian = rb_define_module("Debian");
	VALUE rb_mDebianAptPkg = rb_define_module_under(rb_mDebian, "AptPkg");
	VALUE rb_mDebianAptPkgConfiguration = rb_define_module_under(rb_mDebianAptPkg, "PkgCache");

	rb_define_singleton_method(rb_mDebianAptPkgConfiguration, "find_pkg",
			RUBY_METHOD_FUNC(find_pkg), 1);
}
