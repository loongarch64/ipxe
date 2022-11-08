#!/bin/bash
SRC_DIR=`basename $PWD`
if [ $SRC_DIR != "src" ];then
    echo "please run this script under src directory!"
    exit 1
fi

rm -rf bin-loongarch64-linux
make bin-loongarch64-linux/tap.linux -j`nproc`
if [ $? -ne 0 ]; then
    exit
fi

rm -rf bin-loongarch64-linux
make bin-loongarch64-linux/tests.linux -j`nproc`
./bin-loongarch64-linux/tests.linux

