CONTAINER_NAME 				= xos-sample-gui-extension
CONTAINER_IMAGE_NAME 	= xosproject/$(CONTAINER_NAME)
REDIS_HOST						= xos.dev

run_container: build_container
	docker run -p 4001:4000 --name $(CONTAINER_NAME) -d $(CONTAINER_IMAGE_NAME)

build_container:
	docker build -t $(CONTAINER_IMAGE_NAME) .

onboard:
	redis-cli -h $(REDIS_HOST) PUBLISH XOSComponent ''

#onboard:
#	redis-cli -h $(REDIS_HOST) PUBLISH Onboard '{"app": "$(CONTAINER_NAME)", "files": ["http://xos.dev:4001/spa/vendor.js", "http://xos.dev:4001/spa/app.js"]}'
rm:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

rmi:
	docker rmi $(CONTAINER_IMAGE_NAME)

enter:
	docker exec -it $(CONTAINER_NAME) bash
