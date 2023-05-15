USE [Esencial Verde];

-- balances fill  for producers-- 
WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 20000
)
INSERT INTO balances(producer_id, amount, created_at, updated_at, computer, username, checksum)
SELECT  CEILING(RAND(CHECKSUM(NEWID())) * 200000),   0, GETDATE(),  GETDATE(), 'me', 'root', HASHBYTES('SHA2_256', 'hola mundo')
FROM number_sequence
OPTION (MAXRECURSION 32767);



-- balances fill  for alt_collectors-- 
WITH number_sequence AS (
SELECT 1 as n
UNION ALL
SELECT n+1
FROM number_sequence
WHERE n < 20000
)
INSERT INTO balances(amount, created_at, updated_at, computer, username, checksum, alt_collector_id)
SELECT 0, GETDATE(),  GETDATE(), 'me', 'root', HASHBYTES('SHA2_256', 'hola mundo'), CEILING(RAND(CHECKSUM(NEWID())) * 200000) 
FROM number_sequence
OPTION (MAXRECURSION 32767);


-- balances fill  for esencial verde-- 
INSERT INTO balances (amount, created_at, updated_at, computer, username, checksum, isEsencial) 
VALUES 
	(0, GETDATE(),  GETDATE(), 'me', 'root', HASHBYTES('SHA2_256', 'hola mundo'), 1);
