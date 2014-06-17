#include <ruby.h>
#include <apt-pkg/deblistparser.h>
#include <apt-pkg/debversion.h>
#include <apt-pkg/pkgcache.h>
#include <apt-pkg/strutl.h>
#include <apt-pkg/init.h>

/* from '<ruby/dl.h>' */
#define INT2BOOL(x)  ((x) ? Qtrue : Qfalse)

using namespace std;

/* function prototypes */
extern "C" void Init_apt_pkg();
/* String functions */
static VALUE uri_to_filename(VALUE self, VALUE uri);
static VALUE time_to_str(VALUE self, VALUE secondes);
static VALUE size_to_str(VALUE self, VALUE size);
static VALUE string_to_bool(VALUE self, VALUE text);
static VALUE check_domain_list(VALUE self, VALUE host, VALUE list);
/* Versioning */
static VALUE cmp_version(VALUE self, VALUE pkg_version_a, VALUE pkg_version_b);
static VALUE check_dep(VALUE self, VALUE pkg_version_a, VALUE cmp_type, VALUE pkg_version_b);
static VALUE upstream_version(VALUE self, VALUE ver);
