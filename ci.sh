#!/bin/sh

# for Marmot CI

make build

make test

make coverage ARGS="--reprt-format=html"

npm i

MARMOT_IOS=true npm run marmot
