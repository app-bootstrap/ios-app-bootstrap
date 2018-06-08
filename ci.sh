#!/bin/sh

# for Marmot CI

make build

npm i

MARMOT_IOS=true npm run marmot
