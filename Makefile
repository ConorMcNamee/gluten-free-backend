DB_URL=postgres://glutenfree:glutenfreepassword@localhost:5555/glutenfree_db?sslmode=disable
MIGRATIONS_DIR=./migrations

.PHONY: up down server migrate-up migrate-down migrate-create

up:
	make down
	docker compose -f build/docker-compose.yaml up -d
	go run main.go

down:
	docker compose -f build/docker-compose.yaml down

sqlc-generate:
	sqlc generate -f ./db/sqlc.yaml

migrate-up:
	migrate -path $(MIGRATIONS_DIR) -database "$(DB_URL)" up

migrate-down:
	migrate -path $(MIGRATIONS_DIR) -database "$(DB_URL)" down

migrate-create:
	migrate create -ext sql -dir $(MIGRATIONS_DIR) $(NAME)