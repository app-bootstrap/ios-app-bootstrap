all: install
install:
	carthage update --platform iOS --verbose
build: install
	xcodebuild -project ios-app-bootstrap.xcodeproj -sdk iphonesimulator
coverage:
	slather coverage -s --scheme ios-app-bootstrap ./ios-app-bootstrap.xcodeproj
.PHONY: test
