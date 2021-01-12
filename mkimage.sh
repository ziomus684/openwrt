#!/bin/sh

git pull
./scripts/feeds update -a
./scripts/feeds install -a -f
make -j11 V=s
cp -r bin/targets/ipq806x/generic/openwrt* /mnt/d/bin/targets/ipq806x/generic/
