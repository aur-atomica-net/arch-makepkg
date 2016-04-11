#!/bin/bash
set -e
set -x
set -o pipefail

REPO=$1
GNUPGHOME=$(pwd)/.gnupg

eval $(gpg-agent --daemon)

sudo pacman -Suy

makepkg --force --noconfirm --syncdeps --install --nocheck --sign

repo-add --sign --verify ${REPO}.db.tar.gz *.pkg.tar.xz

mv ${REPO}.db.tar.gz ${REPO}.db
mv ${REPO}.db.tar.gz.sig ${REPO}.db.sig
