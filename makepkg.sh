#!/bin/bash
set -e
set -x
set -o pipefail

REPO=$1
GNUPGHOME=$(pwd)/.gnupg

eval $(gpg-agent --daemon)

sudo pacman --sync --sysupgrade --refresh --noconfirm

MAKEFLAGS="-J$(nproc)" makepkg --force --noconfirm --syncdeps --skippgpcheck --install --nocheck --sign

http_proxy="" curl -L -o ${REPO}.db.tar.gz http://aur.atomica.net/atomica/x86_64/${REPO}.db
sha256sum ${REPO}.db.tar.gz
http_proxy="" curl -L -o ${REPO}.db.tar.gz.sig http://aur.atomica.net/atomica/x86_64/${REPO}.db.sig
repo-add --sign --verify ${REPO}.db.tar.gz *.pkg.tar.xz
sha256sum ${REPO}.db.tar.gz

mv ${REPO}.db.tar.gz ${REPO}.db
mv ${REPO}.db.tar.gz.sig ${REPO}.db.sig
