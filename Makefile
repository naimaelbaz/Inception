all:
	@docker-compose -f srcs/docker-compose.yml up --build -d

down:
	@docker-compose -f srcs/docker-compose.yml down --volumes
clean:
	@if [ -n "$$(docker ps -qa)" ]; then \
		docker rm $$(docker ps -qa) -f; \
	else \
		echo "No containers to remove."; \
	fi

	@if [ -n "$$(docker images -qa)" ]; then \
		docker rmi -f $$(docker images -qa); \
	else \
		echo "No images to remove."; \
	fi

	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $$(docker volume ls -q); \
	else \
		echo "No volumes to remove."; \
	fi

	@if [ -n "$$(docker network ls --filter type=custom -q)" ]; then \
		docker network rm $$(docker network ls --filter type=custom -q); \
	else \
		echo "No networks to remove."; \
	fi

re: clean
	docker-compose -f srcs/docker-compose.yml up --build -d

.PHONY: all down clean