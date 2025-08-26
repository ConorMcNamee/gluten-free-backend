package handler

import (
	"gluten/internal/db"
	"net/http"

	"github.com/labstack/echo/v4"
)

type ProductHandler struct {
	ProductQueries *db.Queries
}

type GetProductRequest struct {
	ProductId int32 `json:"product_id"`
}

func (ph *ProductHandler) GetProductByBarcode(c echo.Context) error {
	var req GetProductRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "invalid JSON"})
	}

	product, err := ph.ProductQueries.GetAllProductsById(c.Request().Context(), req.ProductId)
	if err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "invalid JSON"})
	}

	return c.JSON(http.StatusOK, product)
}

func (ph *ProductHandler) CreateProduct(c echo.Context) error {
	return nil
}

// 1. To Create the product, we first need a photo of the product
// ingredients to do OCR on them
// 2. We then need to get an image of the product to be able to indentify it
// 3. We then need to fuzz find it in our DB to see if it already exists
// 4. We then need to kick off a job to do some kind of data analytics to find
// a pattern in the barcode ids
