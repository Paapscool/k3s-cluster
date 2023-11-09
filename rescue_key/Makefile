## Define global variables

SOURCES_DIR=rescue_usb

## Generate the input variables

KEY_RESCUE_SSH_HOST=RESCUE_SSH_HOST
KEY_RESCUE_SSH_USER=RESCUE_SSH_USER
KEY_SERVER_DOMAIN_NAME=SERVER_DOMAIN_NAME
KEY_SERVER_DOMAIN_EXTENSION=SERVER_DOMAIN_EXTENSION
KEY_SERVER_ROOT_PASSWORD=SERVER_USER_PASSWORD

## get environment variables for custom installation

VAR_RESCUE_SSH_HOST := $(shell echo $$${KEY_RESCUE_SSH_HOST})
VAR_RESCUE_SSH_USER := $(shell echo $$${KEY_RESCUE_SSH_USER})
VAR_SERVER_DOMAIN_NAME := $(shell echo $$${KEY_SERVER_DOMAIN_NAME})
VAR_SERVER_DOMAIN_EXTENSION := $(shell echo $$${KEY_SERVER_DOMAIN_EXTENSION})
VAR_SERVER_ROOT_PASSWORD := $(shell echo $$${KEY_SERVER_ROOT_PASSWORD})


all: install

.PHONY: install
install:
# check variables are set
ifeq (${VAR_RESCUE_SSH_HOST},)
	$(eval VAR_RESCUE_SSH_HOST := $(shell read -p "Enter host for the debian session with your rescue key plugged : " input ; echo $$input))
endif
ifeq (${VAR_RESCUE_SSH_USER},)
	$(eval VAR_RESCUE_SSH_USER := $(shell read -p "Enter user for the debian session with your rescue key plugged : " input ; echo $$input))
endif
ifeq (${VAR_SERVER_DOMAIN_NAME},)
	$(eval VAR_SERVER_DOMAIN_NAME := $(shell read -p "Enter domain name (withtout extension) for the rescue key: " input ; echo $$input))
endif
ifeq (${VAR_SERVER_DOMAIN_EXTENSION},)
	$(eval VAR_SERVER_DOMAIN_EXTENSION := $(shell read -p "Enter domain extension (ex: .fr) for the rescue key: " input ; echo $$input))
endif
ifeq (${VAR_SERVER_ROOT_PASSWORD},)
	$(eval VAR_SERVER_ROOT_PASSWORD := $(shell read -rsp "Enter root password for the rescue key : " input ; printf "%s" "$$input" | base64))
	$(shell read -p "press enter to validate")
endif
# run script
	@scp -r ../${SOURCES_DIR} ${VAR_RESCUE_SSH_USER}@${VAR_RESCUE_SSH_HOST}:/tmp/install/
	@ssh -l ${VAR_RESCUE_SSH_USER} ${VAR_RESCUE_SSH_HOST} "cd /tmp/install && ./entrypoint.sh \
			${VAR_SERVER_DOMAIN_NAME} \
			${VAR_SERVER_DOMAIN_EXTENSION} \
			${VAR_SERVER_ROOT_PASSWORD}" > ${SOURCES_DIR}.${VAR_SERVER_DOMAIN_NAME}.install.log

help:
	@echo "Run the 'make install' with the following variables:"
	@echo "\
		${KEY_RESCUE_SSH_HOST}='<debian_ssh_host>' \\ \n\
		${KEY_RESCUE_SSH_USER}='<debian_ssh_user>' \\ \n\
		${KEY_SERVER_DOMAIN_NAME}='<rescue_domain_name>' \\ \n\
		${KEY_SERVER_DOMAIN_EXTENSION}='<rescue_domain_extension>' \\ \n\
		${KEY_SERVER_ROOT_PASSWORD}='<rescue_root_password>' \\ \n\
		make install"
	@echo "make help"
