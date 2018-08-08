# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 0riginally created by Escalade (https://github.com/escalade)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="libretro-parallel-n64"
PKG_VERSION="ab155da"
PKG_SHA256="42940f899efd36e75d9b02d79069393a5ef0c9891f6d03350f6cda83791e62df"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/parallel-n64"
PKG_URL="https://github.com/libretro/parallel-n64/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="parallel-n64-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emulation"
PKG_SHORTDESC="Optimized/rewritten Nintendo 64 emulator made specifically for Libretro. Originally based on Mupen64 Plus."

PKG_LIBNAME="parallel_n64_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PARALLELN64_LIB"

pre_build_target() {
  export GIT_VERSION=$PKG_VERSION
}

make_target() {
  if [ -z "$DEVICE" ]; then
    PKG_DEVICE_NAME=$PROJECT
  else
    PKG_DEVICE_NAME=$DEVICE
  fi

  case $PKG_DEVICE_NAME in
    RPi|RPi2)
      make platform=${PKG_DEVICE_NAME,,}
      ;;
    Generic)
      make WITH_DYNAREC=$ARCH
      ;;
  esac
}

makeinstall_target() {
    mkdir -p $INSTALL/usr/lib/libretro
    cp $PKG_LIBPATH $INSTALL/usr/lib/libretro/
}
