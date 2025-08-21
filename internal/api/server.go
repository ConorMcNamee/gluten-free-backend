package api

import (
	"gluten/internal/api/handler"
	"net/http"

	"github.com/labstack/echo/v4"
)

func RegisterRoutes(server *echo.Echo) {
	productHandlers := &handler.ProductHandler{}

	// Get and Create products
	server.GET("/get-product", productHandlers.GetProductByBarcode)
	server.GET("/create-product", productHandlers.CreateProduct)

	// Users handlers

	// Utils
	server.GET("/ping", Ping)
}

func Ping(c echo.Context) error {
	return c.JSON(http.StatusOK, "Pong")
}
