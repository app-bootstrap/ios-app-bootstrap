.DEFAULT_GOAL := build

# Resolve project name
PROJECT_NAME = $(shell ls | grep --color=never xcodeproj | cut -d . -f 1)

# Repo is located in ~/.marmot_home
MARMOT_HOME = $(HOME)/marmot_home
AUTOMATION_HOME = $(MARMOT_HOME)/marmot-ios

init:
	@[ -d "$(MARMOT_HOME)" ] || mkdir -p "$(MARMOT_HOME)"
	@[ -d "$(AUTOMATION_HOME)" ] || git clone git@github.com:macacajs/marmot-ios.git "$(AUTOMATION_HOME)"

-include $(AUTOMATION_HOME)/Scripts/Makefile
