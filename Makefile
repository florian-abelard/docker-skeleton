#------------------------------------------------------------------------------
# Main Makefile
#------------------------------------------------------------------------------

USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)
ROOT_PATH=$(shell pwd)
DOCKER_COMPOSE_FILE?=./docker-compose.yml

export USER_ID
export GROUP_ID

#------------------------------------------------------------------------------

include .env
$(foreach var,$(shell cat .env),$(eval export ${var}))

-include application/.env
$(test ! -e application/.env && foreach var,$(shell cat application/.env),$(eval export ${var}))

-include application/.env.local
$(test ! -e application/.env.local && foreach var,$(shell cat application/.env.local),$(eval export ${var}))

#------------------------------------------------------------------------------

include makefiles/*.mk

#------------------------------------------------------------------------------

init: composer-install ## install project dependencies

#------------------------------------------------------------------------------

.DEFAULT_GOAL := help

help:
	@echo "================================================================================"
	@echo " Main Makefile"
	@echo "================================================================================"
	@echo
	@perl -e '$(HELP_FUNC)' $(MAKEFILE_LIST)
	@echo "================================================================================"

#------------------------------------------------------------------------------

.PHONY: help