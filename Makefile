all: install
install:
	carthage update --platform iOS --verbose
build: install
	xcodebuild -sdk iphonesimulator9.3
.PHONY: test
