package handler

import (
	"gluten/internal/api/service"
	"gluten/internal/db"
	"net/http"

	"github.com/labstack/echo/v4"
	"golang.org/x/crypto/bcrypt"
)

type UserHandler struct {
	Service service.UserService
}

type RegisterRequest struct {
	email     string `json:"email"`
	password  string `json:"password"`
	password2 string `json:"password2"`
}

func (uh *UserHandler) Login(c echo.Context) error {
	return nil
}

func (uh *UserHandler) Register(c echo.Context) error {
	var req RegisterRequest
	c.Bind(&req)

	hash, err := bcrypt.GenerateFromPassword([]byte(req.password), bcrypt.DefaultCost)
	if err != nil {
		return c.JSON(http.StatusBadRequest, err)
	}

	err = uh.Service.Querier.CreateUser(c.Request().Context(), db.CreateUserParams{
		PasswordHash: string(hash),
	})
	if err != nil {
		return c.JSON(http.StatusBadRequest, err)
	}

	return c.JSON(http.StatusOK, `status:registered`)
}

func (uh *UserHandler) Logout(c echo.Context) error {
	return nil
}
