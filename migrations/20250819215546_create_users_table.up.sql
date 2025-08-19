create table if not exists users(
    id serial primary key,
    first_name varchar(255),
    last_name varchar(255),
    password_hash varchar(255) not null,
    email varchar(255) not null,
    username varchar(255),
    dob timestamp
);