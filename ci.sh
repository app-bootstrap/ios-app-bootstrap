#!/bin/sh

# for Marmot CI

pod install

curl -fsSL https://github.com/macacajs/marmot-ios/files/2114440/Makefile.txt -o Makefile && make init

make build

make test

make coverage ARGS="--reprt-format=html"

npm i

MARMOT_IOS=true npm run marmot
