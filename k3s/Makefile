# Generate the input variables
KEY_SERVER_HOST=SERVER_HOST
KEY_SERVER_USER=SERVER_USER

# Get environment variables for custom installation
VAR_SERVER_HOST := $(shell echo $$${KEY_SERVER_HOST})
VAR_SERVER_USER := $(shell echo $$${KEY_SERVER_USER})

all: install

.PHONY: install
install:
# check variables are set
ifeq (${VAR_SERVER_HOST},)
	$(eval VAR_SERVER_HOST := $(shell read -p "Enter host for the rescue session : " input ; echo $$input))
endif
ifeq (${VAR_SERVER_USER},)
	$(eval VAR_SERVER_USER := $(shell read -p "Enter user for the rescue session : " input ; echo $$input))
endif
# run script
	@scp -r ../k3s ${VAR_SERVER_USER}@${VAR_SERVER_HOST}:/tmp/k3s
	@ssh ${VAR_SERVER_USER}@${VAR_SERVER_HOST}

# entrypoint.sh's "mv utils ~/utils" only ever runs once, during the initial
# install. There is no other documented way to push local changes made
# under utils/ (service-account.sh, postgresql_new_credentials.sh, ...) to
# an already-installed server — this target is that missing update path.
.PHONY: update-utils
update-utils:
ifeq (${VAR_SERVER_HOST},)
	$(eval VAR_SERVER_HOST := $(shell read -p "Enter host for the rescue session : " input ; echo $$input))
endif
ifeq (${VAR_SERVER_USER},)
	$(eval VAR_SERVER_USER := $(shell read -p "Enter user for the rescue session : " input ; echo $$input))
endif
	@scp -r utils/* ${VAR_SERVER_USER}@${VAR_SERVER_HOST}:~/utils/
	@ssh ${VAR_SERVER_USER}@${VAR_SERVER_HOST} 'chmod +x ~/utils/*.sh'
