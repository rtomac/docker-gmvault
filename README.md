# Overview

Gmvault running on Alpine (multi-arch).

Inspired by other good gmvault images (e.g. [tianon/gmvault](https://hub.docker.com/r/tianon/gmvault)), but with multi-arch support and a few additional features to solve minor pain points.

Features:
- Multi-arch image, including support for arm (Raspberry Pi!)
- Ability to inject conf file changes via environment variables
- Pinned to Python 2 (more stable/tested for Gmvault)
- Works around a known 1.9.1 bug that overwrites conf file changes

# Usage

Provide gmvault args directly as command args:
```
docker run -it --rm \
    rtomac/gmvault sync --type quick foo.bar@gmail.com
```

Pass in environments variables to override conf file settings (see Environment Variables section below):
```
docker run -it --rm \
    -e SYNC__QUICK_DAYS=7 \
    -e GOOGLEOAUTH2__GMVAULT_CLIENT_ID="myclientid" \
    -e GOOGLEOAUTH2__GMVAULT_CLIENT_SECRET="mysecret" \
    rtomac/gmvault sync --type quick foo.bar@gmail.com
```

Or, directly bind mount a gmvault_defaults.conf file:
```
docker run -it --rm \
    -v ${HOME}/.gmvault/gmvault_defaults.conf:/root/.gmvault/gmvault_defaults.conf \
    rtomac/gmvault sync --type quick foo.bar@gmail.com
```

See [Gmvault docs](http://gmvault.org/gmail_setup.html#quickstart) for more information on gmvault usage and options.

# Environment Variables

The following environment variables can be provided to the container to override conf file settings.

| Env variable | Conf section | Conf property |
| ------------ | ------------ | --------------|
| SYNC__QUICK_DAYS | Sync | quick_days |
| RESTORE__QUICK_DAYS | Restore | quick_days |
| GENERAL__LIMIT_PER_CHAT_DIR | General | limit_per_chat_dir |
| GENERAL__ERRORS_IF_CHAT_NOT_VISIBLE | General | errors_if_chat_not_visible |
| GENERAL__NB_MESSAGES_PER_BATCH | General | nb_messages_per_batch |
| GENERAL__NB_MESSAGES_PER_RESTORE_BATCH | General | nb_messages_per_restore_batch |
| GENERAL__RESTORE_DEFAULT_LOCATION | General | restore_default_location |
| GENERAL__KEEP_IN_BIN | General | keep_in_bin |
| GENERAL__ENABLE_IMAP_COMPRESSION | General | enable_imap_compression |
| GOOGLEOAUTH2__GMVAULT_CLIENT_ID | GoogleOauth2 | gmvault_client_id |
| GOOGLEOAUTH2__GMVAULT_CLIENT_SECRET | GoogleOauth2 | gmvault_client_secret |

# Development

## Build and test
```
make test
```

## Push to registry
```
make push
```

See variables in [Makefile](Makefile) to alter registry and tagging.

# License

MIT License
