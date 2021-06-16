SHELL=/bin/bash

container_hub_acct=rtomac
image_name=gmvault
image_tag=latest
image_version_tag=1.9.1
image_platforms=linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6

all: build

.PHONY: build
build:
	docker build \
		-t ${image_name}:local \
		.

quick_days=
gmvault_client_id=
gmvault_client_secret=
gmail_addr=foo.bar@gmail.com
.PHONY: test
test: build
	docker run -it --rm \
		-e DEBUG_CONFIG=1 \
		-e SYNC__QUICK_DAYS="${quick_days}" \
		-e GOOGLEOAUTH2__GMVAULT_CLIENT_ID="${gmvault_client_id}" \
		-e GOOGLEOAUTH2__GMVAULT_CLIENT_SECRET="${gmvault_client_secret}" \
		${image_name}:local sync --type quick "${gmail_addr}"

.PHONY: release
release:
	docker buildx build \
		--tag "${container_hub_acct}/${image_name}:${image_tag}" \
		--tag "${container_hub_acct}/${image_name}:${image_version_tag}" \
		--platform "${image_platforms}" \
		--push \
		.
