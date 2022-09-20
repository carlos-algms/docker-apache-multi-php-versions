IMAGE=carlosalgms/docker-apache-multi-php-versions

LATEST=jammy
TAG?=$(LATEST)
FROM_IMAGE?=ubuntu:jammy
EXTRA_REPO?="3.7"
COMPOSER_VERSION?="2.4.1"


# Cache the previous build to leverage Docker's layer feature
# https://andrewlock.net/caching-docker-layers-on-serverless-build-hosts-with-multi-stage-builds---target,-and---cache-from/

define BASE_BUILD
docker pull $(IMAGE):$(TAG) || true; \
docker buildx build --rm . \
	--cache-from $(IMAGE):$(TAG) \
	--cache-to type=inline \
	-t $(IMAGE):$(TAG) \
	--build-arg VERSION=$(TAG) \
	--build-arg BUILD_DATE="$(shell date)" \
	--build-arg FROM_IMAGE=$(FROM_IMAGE) \
	--build-arg EXTRA_REPO="$(EXTRA_REPO)" \
	--build-arg COMPOSER_VERSION="$(COMPOSER_VERSION)" \
	-f Dockerfile.ubuntu
endef



build:
	$(BASE_BUILD)


publish:
	docker push $(IMAGE):$(TAG)
	docker push $(IMAGE):$(TAG)-xdebug
	if [ "$(TAG)" = "$(LATEST)" ]; then \
		( docker tag $(IMAGE):$(TAG) $(IMAGE):latest \
		&& docker push $(IMAGE):latest ) \
	fi


.PHONY: build publish
