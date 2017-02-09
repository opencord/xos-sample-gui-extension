CONTAINER_NAME 				= xos-sample-gui-extension
CONTAINER_IMAGE_NAME 	= xosproject/$(CONTAINER_NAME)
REDIS_HOST						= xos.dev
COMMON_DIR         		:= $(abspath ../service-profile/common )

# Include common functions
include $(COMMON_DIR)/Makefile
# run_container: build_container
# 	docker run -p 4001:4000 --name $(CONTAINER_NAME) -d $(CONTAINER_IMAGE_NAME)

# build_container:
# 	docker build -t $(CONTAINER_IMAGE_NAME) .

# onboard:
# 	redis-cli -h $(REDIS_HOST) PUBLISH XOSComponent ''
# rm:
# 	docker stop $(CONTAINER_NAME)
# 	docker rm $(CONTAINER_NAME)

# rmi:
# 	docker rmi $(CONTAINER_IMAGE_NAME)
# enter:
# 	docker exec -it $(CONTAINER_NAME) bash

build_app:
	docker run \
        	--name $(CONTAINER_NAME)-builder \
        	-v $(PWD):/usr/src/app \
        	-v $(PWD)/../xos-gui/src/extensions/$(CONTAINER_NAME):/usr/src/app/dist \
        	-w /usr/src/app node:argon npm run build
	docker rm xos-sample-gui-extension-builder

onboard:
	$(RUN_TOSCA_BOOTSTRAP) ./xos-sample-gui-extension.yaml


