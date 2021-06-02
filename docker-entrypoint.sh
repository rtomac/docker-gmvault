#!/bin/bash
set -e

mkdir -p /root/.gmvault
conf_file_path=/root/.gmvault/gmvault_defaults.conf

# If conf file not found/mounted, copy default file into
# place prior to below substitutions
[ ! -f "${conf_file_path}" ] && cp /gmvault_defaults.conf "${conf_file_path}"

function test_set_ini_value {
    env_name=$1
    section=$2
    param=$3
    value=${!env_name}

    if [ ! -z "${value}" ]; then
        crudini --set "${conf_file_path}" "${section}" "${param}" "${value}"
    fi
}

# Work around 1.9.1 bug that overwrites the file if you
# don't change the version number in the generated file
# from "1.9.1" to "1.9"
crudini --set "${conf_file_path}" VERSION conf_version "1.9"

# Test env variables and set corresponding ini value if found
test_set_ini_value SYNC__QUICK_DAYS Sync quick_days
test_set_ini_value RESTORE__QUICK_DAYS Restore quick_days
test_set_ini_value GENERAL__LIMIT_PER_CHAT_DIR General limit_per_chat_dir
test_set_ini_value GENERAL__ERRORS_IF_CHAT_NOT_VISIBLE General errors_if_chat_not_visible
test_set_ini_value GENERAL__NB_MESSAGES_PER_BATCH General nb_messages_per_batch
test_set_ini_value GENERAL__NB_MESSAGES_PER_RESTORE_BATCH General nb_messages_per_restore_batch
test_set_ini_value GENERAL__RESTORE_DEFAULT_LOCATION General restore_default_location
test_set_ini_value GENERAL__KEEP_IN_BIN General keep_in_bin
test_set_ini_value GENERAL__ENABLE_IMAP_COMPRESSION General enable_imap_compression
test_set_ini_value GOOGLEOAUTH2__GMVAULT_CLIENT_ID GoogleOauth2 gmvault_client_id
test_set_ini_value GOOGLEOAUTH2__GMVAULT_CLIENT_SECRET GoogleOauth2 gmvault_client_secret

# Emit config if flag set, before execution
[ "${DEBUG_CONFIG}" == "1" ] && cat "${conf_file_path}"

# Run gmvault with args passed in
gmvault $@

# Emit config if flag set, after execution (to detect changes to config
# made by the program)
[ "${DEBUG_CONFIG}" == "1" ] && cat "${conf_file_path}"
