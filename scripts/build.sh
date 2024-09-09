#!/bin/sh
set -e

shellcheck src/bin/*

TARGET=target
SOURCE=src

mkdir -p "$TARGET"

# Control File
cp -vr $SOURCE/DEBIAN $TARGET

# Binary File
mkdir -p $TARGET/usr/bin
cp -vr $SOURCE/bin $TARGET/usr
chmod 755 $TARGET/usr/bin/*

# Man Pages
mkdir -p $TARGET/usr/share/man/man1/
pandoc $SOURCE/md/siakhooi-devutils-date-formats.1.md -s -t man | gzip -9 >$TARGET/usr/share/man/man1/siakhooi-devutils-date-formats.1.gz

## Create links
(
  cd $TARGET/usr/share/man/man1/
  ln -s siakhooi-devutils-date-formats.1.gz y2y.1.gz
  ln -s siakhooi-devutils-date-formats.1.gz y2m.1.gz
  ln -s siakhooi-devutils-date-formats.1.gz y2d.1.gz
  ln -s siakhooi-devutils-date-formats.1.gz y2h.1.gz
  ln -s siakhooi-devutils-date-formats.1.gz y2M.1.gz
  ln -s siakhooi-devutils-date-formats.1.gz y2s.1.gz
  ln -s siakhooi-devutils-date-formats.1.gz y2n.1.gz
)

fakeroot dpkg-deb --build -Zxz $TARGET
dpkg-name ${TARGET}.deb

DEBFILE=$(ls ./*.deb)

sha256sum "$DEBFILE" >"$DEBFILE.sha256sum"
sha512sum "$DEBFILE" >"$DEBFILE.sha512sum"

dpkg --contents "$DEBFILE"
