#!/usr/bin/env bash

# removes files in debian, ubuntu, opensuse  and others
set -ex

# OpenSuse
zypper clean --all || /bin/true

# Debian / Ubuntu
rm -rf /var/lib/apt/lists/*
find /var/cache/apt/archives/ -type f  -name \\*.deb -delete || /bin/true

# clean cloud-init info
cloud-init clean
rm -rf /var/lib/cloud/instances/*

echo "${TEMPLATE_NAME} -- Packer Build Complete"
