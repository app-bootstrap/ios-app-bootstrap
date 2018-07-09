#!/bin/sh

# for Marmot CI

npm i && npm i marmot-cli -g
carthage update --platform iOS
xcodebuild -project ios-app-bootstrap.xcodeproj -sdk iphonesimulator

MARMOT_IOS=true npm run marmot
