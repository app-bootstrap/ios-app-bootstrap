all: install
install:
	carthage update --platform iOS --verbose
.PHONY: test
