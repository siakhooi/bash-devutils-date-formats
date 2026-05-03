#!/bin/bash
set -e

rm -rf ~/rpmbuild
rpmdev-setuptree

readonly SOURCE=src
readonly TARGET=~/rpmbuild/BUILD/

# Spec File
cp $SOURCE/RPMS/siakhooi-date-formats.spec ~/rpmbuild/SPECS

# Binary File
mkdir -p $TARGET/usr/bin
cp -vr $SOURCE/bin $TARGET/usr
chmod 755 $TARGET/usr/bin/*

# Man Pages
mkdir -p $TARGET/usr/share/man/man1/
pandoc $SOURCE/md/siakhooi-date-formats.1.md -s -t man |
  gzip -9 >$TARGET/usr/share/man/man1/siakhooi-date-formats.1.gz

# License
cp -vf ./LICENSE "$TARGET"

# build rpm file
rpmlint ~/rpmbuild/SPECS/siakhooi-date-formats.spec
rpmbuild -bb -vv ~/rpmbuild/SPECS/siakhooi-date-formats.spec
cp -vf ~/rpmbuild/RPMS/noarch/siakhooi-date-formats-*.rpm .

# query
tree ~/rpmbuild/
rpm -ql ~/rpmbuild/RPMS/noarch/siakhooi-date-formats-*.rpm

rpm_file=$(basename "$(ls ./siakhooi-date-formats-*.rpm)")

sha256sum "$rpm_file" >"$rpm_file.sha256sum"
sha512sum "$rpm_file" >"$rpm_file.sha512sum"
