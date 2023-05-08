USE [Esencial Verde];


INSERT INTO control_words (control_word_id)
SELECT TOP 4860 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + 140
FROM sys.objects a, sys.objects b;


WITH number_sequence AS (
  SELECT 141 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 4860 
)
INSERT INTO traductions (control_word_id, language_id, traduction, [default])
SELECT CEILING(RAND(CHECKSUM(NEWID())) * 4860)+140, 1, CONCAT('product', CEILING(RAND(CHECKSUM(NEWID())) * 4860)+140), 1
FROM number_sequence
OPTION (MAXRECURSION 32767)
SELECT * from materials;


-- container_types fill --
WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 15000
)
INSERT INTO products (control_word_id, sale_cost, production_cost, assembly_cost)
SELECT CEILING((RAND(CHECKSUM(NEWID())) * 4700)) + 140,  CEILING(RAND(CHECKSUM(NEWID())) * 100000),  CEILING(RAND(CHECKSUM(NEWID())) * 50000), CEILING(RAND(CHECKSUM(NEWID())) * 10000)
FROM number_sequence
OPTION (MAXRECURSION 32767);


SELECT * from products order by product_id DESC;





--Inventories--




WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 10000
)
INSERT INTO materials_inventories (material_id, available_quantity, sold_quantity, contract_id, ev_site_id)
SELECT CEILING((RAND(CHECKSUM(NEWID())) * 30000)),  CEILING(RAND(CHECKSUM(NEWID())) * 50000),  CEILING(RAND(CHECKSUM(NEWID())) * 20000), CEILING(RAND(CHECKSUM(NEWID())) * 30000), CEILING(RAND(CHECKSUM(NEWID())) * 150000)+7 
FROM number_sequence
OPTION (MAXRECURSION 32767);


SELECT * from materials_inventories order by material_id ASC;




WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 10000
)
INSERT INTO products_inventories (product_id, available_quantity, sold_quantity, contract_id, ev_site_id)
SELECT CEILING((RAND(CHECKSUM(NEWID())) * 30000)),  CEILING(RAND(CHECKSUM(NEWID())) * 50000),  CEILING(RAND(CHECKSUM(NEWID())) * 20000), CEILING(RAND(CHECKSUM(NEWID())) * 30000), CEILING(RAND(CHECKSUM(NEWID())) * 150000)+7 
FROM number_sequence
OPTION (MAXRECURSION 32767);


SELECT * from products_inventories order by product_id ASC;