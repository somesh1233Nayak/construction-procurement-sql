-- 1. Projects Table
CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY,
    project_name TEXT,
    budget REAL,
    start_date DATE
);

-- 2. Suppliers Table
CREATE TABLE suppliers (
    supplier_id INTEGER PRIMARY KEY,
    supplier_name TEXT,
    trade_category TEXT
);

-- 3. RFQs Table
CREATE TABLE rfqs (
    rfq_id INTEGER PRIMARY KEY,
    project_id INTEGER,
    trade TEXT,
    date_sent DATE,
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- 4. Quotations Table
CREATE TABLE quotations (
    quote_id INTEGER PRIMARY KEY,
    rfq_id INTEGER,
    supplier_id INTEGER,
    price REAL,
    date_received DATE,
    FOREIGN KEY (rfq_id) REFERENCES rfqs(rfq_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- 5. Purchases Table
CREATE TABLE purchases (
    purchase_id INTEGER PRIMARY KEY,
    quote_id INTEGER,
    final_price REAL,
    status TEXT,
    FOREIGN KEY (quote_id) REFERENCES quotations(quote_id)
);
