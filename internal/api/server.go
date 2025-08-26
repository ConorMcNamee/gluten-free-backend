package api

import (
	"gluten/internal/api/handler"
	"gluten/internal/db"
	"net/http"

	"github.com/labstack/echo/v4"
)

func RegisterRoutes(server *echo.Echo, queries *db.Queries) {
	productHandlers := &handler.ProductHandler{
		ProductQueries: queries,
	}

	// Get and Create products
	server.POST("/get-product", productHandlers.GetProductByBarcode)
	server.GET("/create-product", productHandlers.CreateProduct)

	// Users handlers

	// Utils
	server.GET("/ping", Ping)
}

func Ping(c echo.Context) error {
	return c.JSON(http.StatusOK, "Pong")
}
