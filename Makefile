install:
	carthage update --platform iOS --verbose
build: install
	xcodebuild -project ios-app-bootstrap.xcodeproj -sdk iphonesimulator
test:
	echo TODO
coverage:
	macaca coverage -r ios -n ios-app-bootstrap -p ./ios-app-bootstrap.xcodeproj --html ./reporter
.PHONY: coverage
