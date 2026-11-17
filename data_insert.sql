-- Projects
INSERT INTO projects VALUES 
(1, 'Project Alpha (Office Block)', 500000, '2024-01-10'),
(2, 'Project Beta (Residential)', 300000, '2024-02-15'),
(3, 'Project Gamma (Retail)', 750000, '2024-03-01');

-- Suppliers
INSERT INTO suppliers VALUES 
(1, 'BuildRight Groundworks', 'Groundworks'),
(2, 'Volt Electricals', 'Electrical'),
(3, 'AirFlow HVAC', 'HVAC'),
(4, 'Solid Concrete Co.', 'Groundworks'),
(5, 'Sparky Solutions', 'Electrical');

-- RFQs (Requests for Quotation)
INSERT INTO rfqs VALUES 
(101, 1, 'Groundworks', '2024-01-15'),
(102, 1, 'Electrical', '2024-01-16'),
(103, 2, 'Groundworks', '2024-02-20'),
(104, 2, 'HVAC', '2024-02-21'),
(105, 3, 'Electrical', '2024-03-05');

-- Quotations
INSERT INTO quotations VALUES 
(1001, 101, 1, 45000, '2024-01-18'), -- BuildRight quote for Proj 1 Groundworks
(1002, 101, 4, 48000, '2024-01-19'), -- Solid Concrete quote for Proj 1 Groundworks
(1003, 102, 2, 20000, '2024-01-20'), -- Volt Electrical quote for Proj 1 Electrical
(1004, 102, 5, 18500, '2024-01-22'), -- Sparky Solutions quote for Proj 1 Electrical
(1005, 103, 1, 52000, '2024-02-25'), -- BuildRight quote for Proj 2 Groundworks
(1006, 104, 3, 30000, '2024-02-28'), -- AirFlow quote for Proj 2 HVAC
(1007, 105, 2, 40000, '2024-03-10'), -- Volt Electrical quote for Proj 3 Electrical
(1008, 105, 5, 42000, '2024-03-12'); -- Sparky Solutions quote for Proj 3 Electrical

-- Purchases (Final Selection)
INSERT INTO purchases VALUES 
(5001, 1001, 45000, 'Completed'), -- Selected BuildRight for Proj 1
(5002, 1004, 18500, 'Completed'), -- Selected Sparky for Proj 1
(5003, 1006, 30000, 'Pending');   -- Selected AirFlow for Proj 2
