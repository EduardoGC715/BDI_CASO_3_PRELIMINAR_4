USE [Esencial Verde];

-- Insert traductions words for invoice type ids -- 
INSERT INTO traductions (control_word_id, language_id, traduction, [default])
VALUES 
    (28,1,'producer contract',1),
	(29,1,'alt collector contract',1);



	-- Insert traductions words for invoice type ids -- 
INSERT INTO invoice_types(control_word_id)
VALUES 
    (28),
	(29);




WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 10000
)
INSERT INTO contracts(contract_id, corporation_id, total_cost, contract_score, total_score_debt, initial_date, final_date)
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + 10000, CEILING(RAND(CHECKSUM(NEWID())) * 9)+1, CEILING(RAND(CHECKSUM(NEWID())) * 2000000), CEILING(RAND(CHECKSUM(NEWID())) * 500), CEILING(RAND(CHECKSUM(NEWID())) * 200), GETDATE(), GETDATE()
FROM number_sequence
OPTION (MAXRECURSION 32767)



WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 10000
)
INSERT INTO score_prices(price_per_score,  created_at, updated_at, computer, username, checksum)
SELECT  CEILING(RAND(CHECKSUM(NEWID())) * 25000),GETDATE(),  GETDATE(), 'me', 'root', HASHBYTES('SHA2_256', 'hola mundo')
FROM number_sequence
OPTION (MAXRECURSION 32767)



WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 10000
)
INSERT INTO contract_terms(contract_id, producer_id, waste_operation_id, waste_quantity, ev_site_id, container_inventory_id, collection_cost, subtotal_score,
		score_price_id, subtotal_cost, producer_profit_percentage, [non-compliance_fee], created_at, updated_at, computer, username, checksum)
SELECT CEILING(RAND(CHECKSUM(NEWID())) * 30000), CEILING(RAND(CHECKSUM(NEWID())) * 200000), CEILING(RAND(CHECKSUM(NEWID())) * 10000),
	CEILING(RAND(CHECKSUM(NEWID())) * 15000), CEILING(RAND(CHECKSUM(NEWID())) * 150000)+7,  CEILING(RAND(CHECKSUM(NEWID())) * 48000) + 1054334,
	CEILING(RAND(CHECKSUM(NEWID())) * 500000), CEILING(RAND(CHECKSUM(NEWID())) * 200), CEILING(RAND(CHECKSUM(NEWID())) * 10000), CEILING(RAND(CHECKSUM(NEWID())) * 700000), 
	CEILING(RAND(CHECKSUM(NEWID())) * 30), CEILING(RAND(CHECKSUM(NEWID())) * 500000),  GETDATE(),  GETDATE(), 'me', 'root', HASHBYTES('SHA2_256', 'hola mundo')
FROM number_sequence
OPTION (MAXRECURSION 32767);



WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 10000
)
INSERT INTO contract_terms(contract_id, producer_id, waste_operation_id, waste_quantity, ev_site_id, container_inventory_id, collection_cost, subtotal_score,
		score_price_id, subtotal_cost, producer_profit_percentage, [non-compliance_fee], created_at, updated_at, computer, username, checksum)
SELECT CEILING(RAND(CHECKSUM(NEWID())) * 30000), CEILING(RAND(CHECKSUM(NEWID())) * 200000), CEILING(RAND(CHECKSUM(NEWID())) * 10000),
	CEILING(RAND(CHECKSUM(NEWID())) * 15000), CEILING(RAND(CHECKSUM(NEWID())) * 150000)+7,  CEILING(RAND(CHECKSUM(NEWID())) * 48000) + 1054334,
	CEILING(RAND(CHECKSUM(NEWID())) * 500000), CEILING(RAND(CHECKSUM(NEWID())) * 200), CEILING(RAND(CHECKSUM(NEWID())) * 10000), CEILING(RAND(CHECKSUM(NEWID())) * 700000), 
	CEILING(RAND(CHECKSUM(NEWID())) * 30), CEILING(RAND(CHECKSUM(NEWID())) * 500000),  GETDATE(),  GETDATE(), 'me', 'root', HASHBYTES('SHA2_256', 'hola mundo')
FROM number_sequence
OPTION (MAXRECURSION 32767);


WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 10000
)
INSERT INTO contract_terms(contract_id, producer_id, waste_operation_id, waste_quantity, alt_collector_id, ev_site_id, container_inventory_id, 
		collection_cost, subtotal_score,score_price_id, subtotal_cost, producer_profit_percentage, alt_collector_due_amount, [non-compliance_fee],
		created_at, updated_at, computer, username, checksum)
SELECT CEILING(RAND(CHECKSUM(NEWID())) * 30000), CEILING(RAND(CHECKSUM(NEWID())) * 200000), CEILING(RAND(CHECKSUM(NEWID())) * 10000),
	CEILING(RAND(CHECKSUM(NEWID())) * 150000000)/ CEILING(RAND(CHECKSUM(NEWID())) *10000), CEILING(RAND(CHECKSUM(NEWID())) * 500000),
	CEILING(RAND(CHECKSUM(NEWID())) * 150000)+7, CEILING(RAND(CHECKSUM(NEWID())) * 48000) + 1054334, CEILING(RAND(CHECKSUM(NEWID())) * 500000),
	CEILING(RAND(CHECKSUM(NEWID())) * 200), CEILING(RAND(CHECKSUM(NEWID())) * 10000), CEILING(RAND(CHECKSUM(NEWID())) * 700000), 
	CEILING(RAND(CHECKSUM(NEWID())) * 30), CEILING(RAND(CHECKSUM(NEWID())) * 2000000000)/CEILING(RAND(CHECKSUM(NEWID())) * 10000), 
	CEILING(RAND(CHECKSUM(NEWID())) * 500000), 
	GETDATE(),  GETDATE(), 'me', 'root', HASHBYTES('SHA2_256', 'hola mundo')
FROM number_sequence
OPTION (MAXRECURSION 32767);

SELECT * FROM contract_terms;












	-- Insert traductions words for invoice type ids -- 
INSERT INTO control_words(control_word_id)
VALUES 
    (5001);

INSERT INTO traductions (control_word_id, language_id, traduction, [default])
VALUES 
    (5001,1,'iva',1);

INSERT INTO control_words(control_word_id)
VALUES 
	(5002),
	(5003),
    (5004);

INSERT INTO traductions (control_word_id, language_id, traduction, [default])
VALUES 
	(5002,1,'Municipalidad',1),
	(5003,1,'Comunidades Autónomas',1),
    (5004,1,'Gobierno',1);

-- Entity Type Fill--

INSERT INTO entity_types(control_word_id)
VALUES 
	(5002),
	(5003),
    (5004);


-- Entity Fill--
WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 10
)
INSERT INTO entities(entity_type_id,  district_id, name)
SELECT  CEILING(RAND(CHECKSUM(NEWID())) * 3), CEILING(RAND(CHECKSUM(NEWID())) * 20), CONCAT('endtidad', CEILING(RAND(CHECKSUM(NEWID())) * 10))
FROM number_sequence
OPTION (MAXRECURSION 32767);




-- Taxes Fill--
WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 10000
)
INSERT INTO taxes(control_word_id,  district_id, percentage, entity_id)
SELECT  CEILING(RAND(CHECKSUM(NEWID())) * 3)+5001,CEILING(RAND(CHECKSUM(NEWID())) * 20), RAND()*0.5, CEILING(RAND(CHECKSUM(NEWID())) * 3) 
FROM number_sequence
OPTION (MAXRECURSION 32767);


-- TaxesXContracts Fill--
WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 30000
)
INSERT INTO taxesXcontracts(tax_id, contract_id)
SELECT  CEILING(RAND(CHECKSUM(NEWID())) * 10000), CEILING(RAND(CHECKSUM(NEWID())) * 30000)
FROM number_sequence
OPTION (MAXRECURSION 32767);




WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 10000
)
INSERT INTO score_prices(price_per_score,  created_at, updated_at, computer, username, checksum)
SELECT  CEILING(RAND(CHECKSUM(NEWID())) * 25000),GETDATE(),  GETDATE(), 'me', 'root', HASHBYTES('SHA2_256', 'hola mundo')
FROM number_sequence
OPTION (MAXRECURSION 32767);


