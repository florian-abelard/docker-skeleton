#------------------------------------------------------------------------------
# Main Makefile
#------------------------------------------------------------------------------

USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)
ROOT_PATH=$(shell pwd)
DOCKER_COMPOSE_FILE?=./docker-compose.yml
DOCKER_COMPOSE_BUILDER_FILE?=./docker/docker-compose-builder.yml


export USER_ID
export GROUP_ID
export ROOT_PATH

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

bash-web: ## open a bash session in the web container
	docker-compose -f ${DOCKER_COMPOSE_FILE} exec web /bin/bash

bash-php: ## open a bash session in the php-fpm container
	docker-compose -f ${DOCKER_COMPOSE_FILE} exec php /bin/bash

bash-composer: ## open a bash session in the composer container
	docker-compose -f ${DOCKER_COMPOSE_BUILDER_FILE} run --user ${USER_ID}:${GROUP_ID} composer /bin/bash

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
