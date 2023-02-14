#!/bin/sh
set -e

DISTRIBUTION=stable
COMPONENT=main
ARCHITECTURE=amd64
PATH_TO_FILE=$(ls ./*.deb)
DEBIAN_PACKAGE_NAME=$(basename $PATH_TO_FILE)

curl -u${JFROG_TOKEN} \
  -XPUT "https://siakhooi.jfrog.io/artifactory/myapt/pool/${DEBIAN_PACKAGE_NAME};deb.distribution=${DISTRIBUTION};deb.component=${COMPONENT};deb.architecture=${ARCHITECTURE}" \
  -T "${PATH_TO_FILE}"
