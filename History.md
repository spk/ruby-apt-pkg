
0.5.0 / 2020-07-22
==================

  * Debian::AptPkg::PkgCache.pkg_names deprecated
  * Add all maintained Rubies on gitlab-ci
  * Init listing packages on cache
  * Quick fix gitlab ci
  * Add .gitlab-ci.yml
  * Rename lib/debian/apt_pkg/{version,gem_version}.rb
  * Update README
  * Tidy tests remove should
  * Debian::AptPkg.init returns a boolean
  * Fix mimitest warnings
  * Remove cppcheck on CI version conflict
  * Fix code lint
  * Fix CI and update Rubies
  * Fix libapt-pkg 2.1 compat
  * Update apt-pkg deps
  * Update doc Debian::AptPkg::InitError
  * README: Bundler is not needed
  * Use Debian::AptPkg::InitError instead of RuntimeError
  * Fix rb_mDebianAptPkgCache name

0.4.0 / 2016-10-06
==================

  * Raise RuntimeError instead of returning `nil`

0.3.0 / 2016-01-23
==================

  * Prefer prefix ++/-- operators for non-primitive types
  * Add Debian::AptPkg::PkgCache.update

0.2.0 / 2016-01-04
==================

  * Fix cache count methods when not init
  * Add init, init_{config,system}
  * Add PkgCache.is_multi_arch method

0.1.0 / 2015-12-20
==================

  * Change VERSION, APT_VERSION and LIBAPT_PKG_VERSION
  * Add cache count methods
  * Fix rake lint task exit status
  * Fix syntax offences

0.0.4 / 2015-12-19
==================

  * Simple search with `Debian::AptPkg::PkgCache.pkg_names("vim")`
  * Documentation update
