# Overview

Gmvault running on Alpine arm64 (i.e. for Raspi 4).

Allows Google OAuth client ID & secret to be injected via environment variables.

# Build

```
docker build -t gmvault https://github.com/rtomac/gmvault-docker-arm64
```

# Run

```
docker run -it --rm \
    -v "~/.gmvault":/root/.gmvault \
    -v "~/gmvault-db":/root/gmvault-db \
    -e GMVAULT_CLIENT_ID=my_client_id \
    -e GMVAULT_CLIENT_SECRET=my_client_secret \
    gmvault sync foo.bar@gmail.com
```
