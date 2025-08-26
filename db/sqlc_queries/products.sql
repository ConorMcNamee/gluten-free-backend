-- name: GetAllProductsById :many
select * from products where id = $1;

