#!/bin/bash
set -e

CONF_FILE_PATH=/root/.gmvault/gmvault_defaults.conf

[ ! -f "${CONF_FILE_PATH}" ] \
    && cp /gmvault_defaults.conf "${CONF_FILE_PATH}"

[ ! -z "${GMVAULT_CLIENT_ID}" ] \
    && sed -i -r "s/(gmvault_client_id=).*/\1${GMVAULT_CLIENT_ID}/" "${CONF_FILE_PATH}"

[ ! -z "${GMVAULT_CLIENT_SECRET}" ] \
    && sed -i -r "s/(gmvault_client_secret=).*/\1${GMVAULT_CLIENT_SECRET}/" "${CONF_FILE_PATH}"

gmvault $@
