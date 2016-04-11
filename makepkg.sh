#!/bin/bash
set -e
set -x
set -o pipefail

REPO=$1
GNUPGHOME=$(pwd)/.gnupg

eval $(gpg-agent --daemon)

makepkg --force --noconfirm --syncdeps --install --nocheck --sign

repo-add --sign ${REPO}.db.tar.gz *.pkg.tar.xz

mv ${REPO}.db.tar.gz ${REPO}.db
mv ${REPO}.db.tar.gz.sig ${REPO}.db.sig
