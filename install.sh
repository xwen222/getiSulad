#!/bin/bash

set -x
set -e

# export LDFLAGS
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
echo "/usr/local/lib" >> /etc/ld.so.conf
#apt install -y g++ libprotobuf-dev protobuf-compiler protobuf-compiler-grpc libgrpc++-dev libgrpc-dev libtool automake autoconf cmake make pkg-config libyajl-dev zlib1g-dev libselinux1-dev libseccomp-dev libcap-dev libsystemd-dev git libarchive-dev libcurl4-gnutls-dev openssl libdevmapper-dev python3 libtar0 libtar-dev libhttp-parser-dev libwebsockets-dev

BUILD_DIR=/tmp/build_isulad

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR

# build lxc
cd $BUILD_DIR
git clone https://github.com/xwen222/mirror_src-openeuler_lxc.git
git config --global --add safe.directory /tmp/build_isulad/mirror_src-openeuler_lxc/lxc-4.0.3
cd mirror_src-openeuler_lxc
./apply-patches
cd lxc-4.0.3
./autogen.sh
./configure
make -j $(nproc)
make install

# build lcr
cd $BUILD_DIR
git clone https://github.com/xwen222/mirror_openeuler_lcr.git
cd mirror_openeuler_lcr
mkdir build
cd build
cmake ..
make -j $(nproc)
make install

# build and install clibcni
cd $BUILD_DIR
git clone https://github.com/xwen222/mirror_openeuler_clibcni.git
cd mirror_openeuler_clibcni
mkdir build
cd build
cmake ..
make -j $(nproc)
make install

cd $BUILD_DIR
git clone https://gitee.com/src-openeuler/protobuf.git
cd protobuf
git checkout openEuler-20.03-LTS-tag
tar -xzvf protobuf-all-3.9.0.tar.gz
cd protobuf-3.9.0
./autogen.sh
./configure
make -j $(nproc)
make install
ldconfig

cd $BUILD_DIR
git clone https://github.com/xwen222/mirror_src-openeuler_c-ares.git
cd c-ares
git checkout openEuler-20.03-LTS-tag
tar -xzvf c-ares-1.15.0.tar.gz
cd c-ares-1.15.0
autoreconf -if
./configure --enable-shared --disable-dependency-tracking
make -j $(nproc)
make install
ldconfig

cd $BUILD_DIR
git clone https://gitee.com/src-openeuler/grpc.git
cd grpc
git checkout openEuler-20.03-LTS-tag
tar -xzvf grpc-1.22.0.tar.gz
cd grpc-1.22.0
make -j $(nproc)
make install
ldconfig

cd $BUILD_DIR
git clone https://github.com/xwen222/mirror_src-openeuler_libevent.git
cd libevent
git checkout -b openEuler-20.03-LTS-tag openEuler-20.03-LTS-tag
tar -xzvf libevent-2.1.11-stable.tar.gz
cd libevent-2.1.11-stable && ./autogen.sh && ./configure
make -j $(nproc) 
make install
ldconfig

cd $BUILD_DIR
git clone https://github.com/xwen222/mirror_src-openeuler_libevhtp.git
cd libevhtp && git checkout -b openEuler-20.03-LTS-tag openEuler-20.03-LTS-tag
tar -xzvf libevhtp-1.2.16.tar.gz
cd libevhtp-1.2.16
patch -p1 -F1 -s < ../0001-support-dynamic-threads.patch
patch -p1 -F1 -s < ../0002-close-openssl.patch
rm -rf build && mkdir build && cd build
cmake -D EVHTP_BUILD_SHARED=on -D EVHTP_DISABLE_SSL=on ../
make -j $(nproc)
make install
ldconfig

cd $BUILD_DIR
git clone https://github.com/xwen222/mirror_src-openeuler_http-parser.git
cd http-parser
git checkout openEuler-20.03-LTS-tag
tar -xzvf http-parser-2.9.2.tar.gz
cd http-parser-2.9.2
make -j CFLAGS="-Wno-error"
make CFLAGS="-Wno-error" install
ldconfig

cd $BUILD_DIR
git clone https://gitee.com/src-openeuler/libwebsockets.git
cd libwebsockets
git checkout openEuler-20.03-LTS-tag
tar -xzvf libwebsockets-2.4.2.tar.gz
cd libwebsockets-2.4.2
patch -p1 -F1 -s < ../libwebsockets-fix-coredump.patch
mkdir build
cd build
cmake -DLWS_WITH_SSL=0 -DLWS_MAX_SMP=32 -DCMAKE_BUILD_TYPE=Debug ../
make -j $(nproc)
make install
ldconfig

# build and install iSulad
cd $BUILD_DIR
git clone https://github.com/xwen222/mirror_openeuler_iSulad.git
cd mirror_openeuler_iSulad
mkdir build
cd build
cmake ..
make -j $(nproc)
make install

# clean
rm -rf $BUILD_DIR
apt autoremove
