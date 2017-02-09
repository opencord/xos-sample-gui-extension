CONTAINER_NAME 				= xos-sample-gui-extension
CONTAINER_IMAGE_NAME 	= xosproject/$(CONTAINER_NAME)
BUILDER-IMAGE					= xosproject/xos-gui-extension-builder
COMMON_DIR         		:= $(abspath ../service-profile/common )

# Include common functions
include $(COMMON_DIR)/Makefile

build_app:
	docker run \
        	--name $(CONTAINER_NAME)-builder \
        	--volumes-from gui-extensions-store \
        	-v $(PWD):/var/www \
        	-w /var/www $(BUILDER-IMAGE) npm run build
	docker rm xos-sample-gui-extension-builder

build_volume_container:
	docker create -v /var/www/dist/extensions --name gui-extensions-store $(BUILDER-IMAGE) /bin/true

onboard:
	$(RUN_TOSCA_BOOTSTRAP) ./xos-sample-gui-extension.yaml

base_image:
	docker build -t $(BUILDER-IMAGE) .
