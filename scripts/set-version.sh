#!/bin/sh
set -e

# shellcheck disable=SC1091
. ./release.env

sed -i 'src/DEBIAN/control'  -e 's@Version: .*@Version: '"$RELEASE_VERSION"'@g'
sed -i 'src/RPMS/siakhooi-devutils-date-formats.spec'  -e 's@Version:        .*@Version:        '"$RELEASE_VERSION"'@g'
