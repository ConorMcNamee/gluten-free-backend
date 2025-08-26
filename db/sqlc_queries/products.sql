-- name: GetAllProductsById :one
select * from products where id = $1;

-- name: GetAllProducts :many
select * from products;