-- name: getUsers :many
select * from users where id = $1;