## Generate the input variables

KEY_RESCUE_SSH_HOST=RESCUE_SSH_HOST
KEY_RESCUE_SSH_USER=RESCUE_SSH_USER
KEY_SERVER_SSH_PUBLIC_KEY_PATH=SERVER_SSH_PUBLIC_KEY_PATH
KEY_TARGET_NAME=TARGET_NAME

## get environment variables for custom installation

VAR_RESCUE_SSH_HOST := $(shell echo $$${KEY_RESCUE_SSH_HOST})
VAR_RESCUE_SSH_USER := $(shell echo $$${KEY_RESCUE_SSH_USER})
VAR_TARGET_NAME := $(shell echo $$${KEY_TARGET_NAME})
VAR_SERVER_USER_PASSWORD := ""
VAR_SERVER_SSH_PUBLIC_KEY_PATH := $(shell echo $$${KEY_SERVER_SSH_PUBLIC_KEY_PATH})

all: install

.PHONY: install
install:
# check variables are set
ifeq (${VAR_RESCUE_SSH_HOST},)
	$(eval VAR_RESCUE_SSH_HOST := $(shell read -p "Enter host for the rescue session : " input ; echo $$input))
endif
ifeq (${VAR_RESCUE_SSH_USER},)
	$(eval VAR_RESCUE_SSH_USER := $(shell read -p "Enter user for the rescue session : " input ; echo $$input))
endif
ifeq (${VAR_TARGET_NAME},)
	$(eval VAR_TARGET_NAME := $(shell read -p "Enter target hardware name (vps or local) : " input ; echo $$input))
endif
ifeq (${VAR_SERVER_SSH_PUBLIC_KEY_PATH},)
	$(eval VAR_SERVER_SSH_PUBLIC_KEY_PATH := $(shell read -e -p "Enter path for the ssh public key for the authentication with the new server: " input ; echo $$input))
endif
	$(eval VAR_SERVER_USER_PASSWORD := $(shell read -rsp "Enter desired password for the user in the server : " input ; printf "%s" "$$input" | base64))
	$(shell read -p "press enter to validate")
	@scp -r ../hardware ${VAR_RESCUE_SSH_USER}@${VAR_RESCUE_SSH_HOST}:/tmp/hardware
	@ssh -l ${VAR_RESCUE_SSH_USER} ${VAR_RESCUE_SSH_HOST} "cd /tmp/hardware && HARDWARE_TARGET=${VAR_TARGET_NAME} ./entrypoint.sh \
			'${VAR_SERVER_USER_PASSWORD}' \
			'`cat ${VAR_SERVER_SSH_PUBLIC_KEY_PATH}`'" > ${VAR_SERVER_DOMAIN_NAME}.install.log
