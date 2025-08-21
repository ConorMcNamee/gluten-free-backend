package handler

import "github.com/labstack/echo/v4"

type ProductHandler struct{}

func (ph *ProductHandler) GetProductByBarcode(c echo.Context) error {
	return nil
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
