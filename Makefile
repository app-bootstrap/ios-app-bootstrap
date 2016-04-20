all: install
install:
	carthage update --platform iOS --verbose
test:
	xctool test -project ios-app-bootstrap.xcodeproj -scheme ios-app-bootstrap -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO
.PHONY: test
