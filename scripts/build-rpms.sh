#!/bin/sh
set -e

rm -rf ~/rpmbuild
rpmdev-setuptree

SOURCE=src
TARGET=~/rpmbuild/BUILD/

# Spec File
cp $SOURCE/RPMS/siakhooi-devutils-date-formats.spec ~/rpmbuild/SPECS

# Binary File
mkdir -p $TARGET/usr/bin
cp -vr $SOURCE/bin $TARGET/usr
chmod 755 $TARGET/usr/bin/*

# Man Pages
mkdir -p $TARGET/usr/share/man/man1/
pandoc $SOURCE/md/siakhooi-devutils-date-formats.1.md -s -t man | gzip -9 >$TARGET/usr/share/man/man1/siakhooi-devutils-date-formats.1.gz

# License
cp -vf ./LICENSE "$TARGET"

# build rpm file
rpmlint ~/rpmbuild/SPECS/siakhooi-devutils-date-formats.spec
rpmbuild -bb -vv ~/rpmbuild/SPECS/siakhooi-devutils-date-formats.spec
cp -vf ~/rpmbuild/RPMS/noarch/siakhooi-devutils-date-formats-*.rpm .

# query
tree ~/rpmbuild/
rpm -ql ~/rpmbuild/RPMS/noarch/siakhooi-devutils-date-formats-*.rpm
