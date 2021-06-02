SHELL=/bin/bash

hub_account=rtomac
image_name=gmvault
image_tag=latest
image_version=1.9.1
target_platforms=linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6

all: test

test_platform=linux/amd64
quick_days=
gmvault_client_id=
gmvault_client_secret=
gmail_addr=foo.bar@gmail.com
.PHONY: test
test:
	docker buildx build \
		--tag "${image_name}:local" \
		--platform "${test_platform}" \
		--load \
		.
	docker run -it --rm \
		-e DEBUG_CONFIG=1 \
		-e SYNC__QUICK_DAYS="${quick_days}" \
		-e GOOGLEOAUTH2__GMVAULT_CLIENT_ID="${gmvault_client_id}" \
		-e GOOGLEOAUTH2__GMVAULT_CLIENT_SECRET="${gmvault_client_secret}" \
		${image_name}:local sync --type quick "${gmail_addr}"

.PHONY: push
push:
	docker buildx build \
		--tag "${hub_account}/${image_name}:${image_tag}" \
		--tag "${hub_account}/${image_name}:${image_version}" \
		--platform "${target_platforms}" \
		--push \
		.
