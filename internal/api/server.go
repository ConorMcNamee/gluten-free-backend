package api

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func RegisterRoutes(server *echo.Echo) {
	server.GET("/ping", Ping)
}

func Ping(c echo.Context) error {
	return c.JSON(http.StatusOK, "Pong")
}
