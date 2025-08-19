package main

import (
	"context"
	"gluten/internal/api"
	"log"

	"github.com/jackc/pgx/v5"
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()
	ctx := context.Background()

	const connString = "postgres://glutenfree:glutenfreepassword@localhost:5555/glutenfree_db?sslmode=disable"
	conn, err := pgx.Connect(ctx, connString)
	if err != nil {
		log.Fatalf("Unable to connect to database: %v\n", err)
		return
	}

	defer conn.Close(ctx)

	api.RegisterRoutes(e)

	log.Fatal(e.Start(":8081"))
}
