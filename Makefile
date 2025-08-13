.PHONY: up down server migrate-up migrate-down migrate-create

up:
	make down
	sudo docker compose -f build/docker-compose.yaml up -d
	go run main.go

down:
	sudo docker compose -f build/docker-compose.yaml down

migrate-up:
	sudo docker build -t migrate-tool -f build/Dockerfile build
	sudo docker run --rm \
        -v $(PWD)/migrations:/migrations \
        migrate-tool -path=/migrations -database "postgres://glutenfree:glutenfreepassword@localhost:5432/glutenfree_db?sslmode=disable" up

migrate-down:
	sudo docker build -t migrate-tool -f build/Dockerfile build
	sudo docker run --rm \
        -v $(PWD)/migrations:/migrations \
        migrate-tool -path=/migrations -database "postgres://glutenfree:glutenfreepassword@localhost:5432/glutenfree_db?sslmode=disable" down

migrate-create:
	sudo docker build -t migrate-tool -f build/Dockerfile build
	sudo docker run --rm \
        -v $(PWD)/migrations:/migrations \
        migrate-tool create -ext sql -dir /migrations