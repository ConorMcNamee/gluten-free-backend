-- Users table
create table if not exists users(
    id serial primary key,
    first_name varchar(255),
    last_name varchar(255),
    password_hash varchar(255) not null,
    email varchar(255) not null,
    username varchar(255),
    dob timestamp
);

-- Ingredients talbe: To store ingredient information
CREATE TABLE IF NOT EXISTS ingredients (
    id SERIAL PRIMARY KEY,
    canonical_name TEXT UNIQUE NOT NULL,  
    contains_gluten BOOLEAN NOT NULL DEFAULT false,
    notes TEXT
);

-- 1. Products table: stores core product info
CREATE TABLE products (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    category_id BIGINT REFERENCES categories(id),
    size VARCHAR(50),
    variant VARCHAR(100),
    region VARCHAR(50),
    date_added TIMESTAMP DEFAULT NOW()
);

-- 2. Product Barcodes table: stores barcode-specific info
CREATE TABLE product_barcodes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    barcode VARCHAR(20) UNIQUE NOT NULL,
    manufacturer_prefix VARCHAR(10),
    product_code VARCHAR(10),
    check_digit CHAR(1),
    date_added TIMESTAMP DEFAULT NOW()
);

-- 3. Categories table
CREATE TABLE categories (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    parent_id BIGINT REFERENCES categories(id)
);

-- 4. Product Images table
CREATE TABLE product_images (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    image_type VARCHAR(50), -- 'product', 'ingredients', etc.
    embedding BYTEA, -- or JSON depending on vector storage
    date_added TIMESTAMP DEFAULT NOW()
);

-- 5. Product OCR table
CREATE TABLE product_ocr (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    ocr_text TEXT NOT NULL,
    date_added TIMESTAMP DEFAULT NOW()
);

-- 6. Product Tags table
CREATE TABLE product_tags (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    tag VARCHAR(50) NOT NULL,
    source VARCHAR(50)
);

-- 7. Barcode Patterns table (for predicted/missing products)
CREATE TABLE barcode_patterns (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    manufacturer_prefix VARCHAR(10),
    predicted_barcode VARCHAR(20) UNIQUE,
    confidence_score FLOAT,
    predicted_name VARCHAR(255),
    date_generated TIMESTAMP DEFAULT NOW(),
    status VARCHAR(50) DEFAULT 'pending' -- 'pending', 'verified', 'discarded'
);

-- 8. Product Relations table (variants, bundles, similar products)
CREATE TABLE product_relations (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    related_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    relation_type VARCHAR(50) -- 'variant', 'bundle', 'similar'
);


