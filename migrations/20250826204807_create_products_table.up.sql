create table if not exists products (
    id serial primary key,
    product_name VARCHAR(255) NOT NULL,
    brand varchar(255) not null,
    size VARCHAR(50),
    variant VARCHAR(100),
    country varchar(10) not null,
    certified_gluten_free boolean not null default false,
    date_added TIMESTAMP DEFAULT NOW()
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