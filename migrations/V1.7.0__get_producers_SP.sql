CREATE PROCEDURE get_producers
AS
BEGIN
    SELECT TOP 1000 p.name, p.env_score, a.zip_code
	FROM producers p
	INNER JOIN addresses a ON p.address_id = a.address_id
END