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
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), CEILING(RAND(CHECKSUM(NEWID())) * 9)+1, CEILING(RAND(CHECKSUM(NEWID())) * 2000000), CEILING(RAND(CHECKSUM(NEWID())) * 500), CEILING(RAND(CHECKSUM(NEWID())) * 200), GETDATE(), GETDATE()
FROM number_sequence
OPTION (MAXRECURSION 32767);


SELECT * FROM contracts;
