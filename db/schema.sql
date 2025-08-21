-- name: Users table
create table if not exists users(
    id serial primary key,
    first_name varchar(255),
    last_name varchar(255),
    password_hash varchar(255) not null,
    email varchar(255) not null,
    username varchar(255),
    dob timestamp
);

-- name: Products Table
CREATE TABLE products (
    id serial primary key,
    product_name VARCHAR(255) NOT NULL,
    category_id BIGINT REFERENCES categories(id),
    size VARCHAR(50),
    variant VARCHAR(100),
    country varchar(10) not null,
    date_added TIMESTAMP DEFAULT NOW()
);

create table if not exists product_ingredients(
    id serial primary key,
    product_id int not null references products(id) on delete cascade,
    ingredient_id int not null references ingredients(id) on delete cascade,
    is_allergen boolean default false
);

CREATE TABLE IF NOT EXISTS ingredients (
    id SERIAL PRIMARY KEY,
    canonical_name TEXT UNIQUE NOT NULL,  
    allergen allergen_type,
    notes TEXT
);

CREATE TABLE product_barcodes (
    id serial PRIMARY KEY not null,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    barcode VARCHAR(20) UNIQUE NOT NULL,
    manufacturer_prefix VARCHAR(10),
    product_code VARCHAR(10),
    check_digit CHAR(1),
    date_added TIMESTAMP DEFAULT NOW()
);

CREATE TABLE product_ocr (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    ocr_text TEXT NOT NULL,
    date_added TIMESTAMP DEFAULT NOW()
);

CREATE TABLE barcode_patterns (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    manufacturer_prefix VARCHAR(10),
    predicted_barcode VARCHAR(20) UNIQUE,
    confidence_score FLOAT,
    predicted_name VARCHAR(255),
    date_generated TIMESTAMP DEFAULT NOW(),
    status VARCHAR(50) DEFAULT 'pending' -- 'pending', 'verified', 'discarded'
);

CREATE TYPE allergens_type AS enum (
    'gluten',
    'milk',
    'eggs',
    'fish',
    'crustaceans',
    'nuts',
    'peanuts',
    'soy',
    'sesame',
    'celery',
    'mustard',
    'sulphites',
    'molluscs',
    'lupin'
)