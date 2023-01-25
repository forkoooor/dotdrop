#!/usr/bin/env bash
# author: deadc0de6 (https://github.com/deadc0de6)
# Copyright (c) 2023, deadc0de6

# get current working directory
rl="readlink -f"
if ! ${rl} "${0}" >/dev/null 2>&1; then
  rl="realpath"
  if ! hash ${rl}; then
    echo "\"${rl}\" not found!" && exit 1
  fi
fi
cur=$(dirname "$(${rl} "${0}")")

# extract version from git latest tag
#version=$(git describe --tags --abbrev=0)
# extract version from version.py
version=$(grep version "${cur}"/../dotdrop/version.py | sed 's/^.*= .\(.*\).$/\1/g')

if ! hash txt2man 2>/dev/null; then
  echo "install txt2man"
  exit 1
fi

txt2man \
  -t "dotdrop" \
  -P "dotdrop" \
  -r "dotdrop-${version}" \
  -s 1 \
  -v "Save your dotfiles once, deploy them everywhere" \
  "${cur}/dotdrop.txt2man" > "${cur}/dotdrop.1"
