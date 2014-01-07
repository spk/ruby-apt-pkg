require 'mkmf'

have_library("stdc++")
have_library("apt-pkg")

dir_config('apt_pkg')

create_makefile('apt_pkg')
