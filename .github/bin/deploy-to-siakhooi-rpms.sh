#!/bin/bash
set -e

PATH_TO_FILE=$(ls ./*.deb)
DEBIAN_PACKAGE_SOURCE_PATH=$(realpath "$PATH_TO_FILE")
DEBIAN_PACKAGE_FILE=$(basename "$PATH_TO_FILE")

TMPDIR=$(mktemp -d)

TARGETPATH=docs
TARGETURL=https://${PUBLISH_TO_GITHUB_REPO_TOKEN}@github.com/siakhooi/rpms.git
TARGETBRANCH=main
TARGETDIR=rpms
TARGET_GIT_EMAIL=devutils-date-formats@siakhooi.github.io
TARGET_GIT_USERNAME=devutils-date-formats
TARGET_COMMIT_MESSAGE="bash-devutils-date-formats: Auto deploy [$(date)]"

if [[ -z $PUBLISH_TO_GITHUB_REPO_TOKEN ]]; then
  echo "Error: PUBLISH_TO_GITHUB_REPO_TOKEN can not be null." >&2
  exit 1
fi

(
  cd "$TMPDIR"
  git config --global user.email "$TARGET_GIT_EMAIL"
  git config --global user.name "$TARGET_GIT_USERNAME"

  git clone -n --depth=1 -b "$TARGETBRANCH" "$TARGETURL" "$TARGETDIR"
  cd "$TARGETDIR"
  git remote set-url origin "$TARGETURL"
  git restore --staged .
  mkdir -p $TARGETPATH
  cp -v "$DEBIAN_PACKAGE_SOURCE_PATH" "$TARGETPATH/$DEBIAN_PACKAGE_FILE"
  git add $TARGETPATH/"$DEBIAN_PACKAGE_FILE"
  git status
  git commit -m "$TARGET_COMMIT_MESSAGE"
  git push
)
find .
