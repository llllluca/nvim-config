#!/bin/sh

set -e

PWD=$(pwd)
THIRDPARTY_DIR="$(realpath $(dirname $0))/thirdparty/"

mkdir -p $THIRDPARTY_DIR
cd $THIRDPARTY_DIR

LUA_LS_VERSION="3.14.0"
echo "[INFO]: Download lua-language-server version ${LUA_LS_VERSION} into ${THIRDPARTY_DIR}."
wget https://github.com/LuaLS/lua-language-server/releases/download/3.14.0/lua-language-server-${LUA_LS_VERSION}-linux-x64.tar.gz
mkdir lua-language-server-${LUA_LS_VERSION}
tar xf lua-language-server-${LUA_LS_VERSION}-linux-x64.tar.gz -C lua-language-server-${LUA_LS_VERSION}

JDTLS_VERSION="1.46.1"
echo "[INFO]: Download jdtls version ${JDTLS_VERSION} into ${THIRDPARTY_DIR}."
wget https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.46.1/jdt-language-server-1.46.1-202504011455.tar.gz
mkdir jdt-language-server-${JDTLS_VERSION}
tar xf download.php?file=%2Fjdtls%2Fmilestones%2F1.46.1%2Fjdt-language-server-1.46.1-202504011455.tar.gz -C jdt-language-server-${JDTLS_VERSION}

# How to install ccls (debian12): $sudo apt install ccls

# How to install rust-analyzer: $rustup component add rust-analyzer
# https://stackoverflow.com/questions/77453247/error-rust-analyzer-is-not-installed-for-the-toolchain-stable-x86-64-unknown#77453276
# rustup component add rust-analyzer

# How to install zathura (debian12): $sudo apt install zathura

# How to install tectonic: https://github.com/tectonic-typesetting/tectonic

cd $PWD



