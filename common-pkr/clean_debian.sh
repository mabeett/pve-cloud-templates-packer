#!/usr/bin/env bash

# removes files in debian and others
set -ex

rm -rf /var/lib/cloud/instances/*
rm -rf /var/lib/apt/lists/*
find /var/cache/apt/archives/ -type f  -name \\*.deb -delete
echo "${TEMPLATE_NAME} -- Packer Build Complete"

