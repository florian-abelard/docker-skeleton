#------------------------------------------------------------------------------
# Composer Makefile
#------------------------------------------------------------------------------

COMPOSER_DOCKER_CMD = docker-compose -f ${DOCKER_COMPOSE_BUILDER_FILE} exec -T --user ${USER_ID}:${GROUP_ID} composer composer ${1}

#------------------------------------------------------------------------------

ifeq ($(ENV), test)
    COMPOSER_ARGS=--no-interaction
endif

composer-install: vendor ##@composer install / update composer dependencies

composer-dump-autoload: ##@composer dump autoloading
	$(call COMPOSER_DOCKER_CMD, dump-autoload)

vendor: composer.lock
	$(call COMPOSER_DOCKER_CMD, install --ignore-platform-reqs ${COMPOSER_ARGS})

composer.lock: composer.json
	$(call COMPOSER_DOCKER_CMD, update --ignore-platform-reqs ${COMPOSER_ARGS})

#------------------------------------------------------------------------------

clean-composer:##@composer delete vendor directory
	test ! -e vendor || rm -r vendor

#------------------------------------------------------------------------------

.PHONY: composer-install composer-dump-autoload clean-composer
