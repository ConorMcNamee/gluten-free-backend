-- name: getUsers :many
select * from users;

-- name: GetUserById :one
select * from users where id = $1;

-- name: CreateUser :exec
insert into users (
    first_name,
    last_name,
    password_hash,
    email,
    username,
    dob
)  VALUES (
    $1, $2, $3, $4, $5, $6
)
RETURNING id, first_name, last_name, password_hash, email, username, dob;