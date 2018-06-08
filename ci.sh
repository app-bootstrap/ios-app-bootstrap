#!/bin/sh

# for Marmot CI

make build

npm i

npm run marmot
