#!/usr/bin/env bash

# Keychain query fields.
# LABEL is the value you put for "Keychain Item Name" in Keychain.app.
LABEL="ansible-vault-password"

if [ "$(uname)" == "Darwin" ]; then
	/usr/bin/security find-generic-password -w -a "$ACCOUNT_NAME" -l "$LABEL"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	/usr/bin/secret-tool lookup application "$LABEL"
fi
