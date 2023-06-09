USE [Esencial Verde]
GO
/****** Object:  StoredProcedure [dbo].[get_producers]    Script Date: 5/11/2023 5:12:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[get_producers]
AS
BEGIN
	WAITFOR DELAY '00:00:02'
    SELECT p.name, p.env_score, a.zip_code
	FROM producers p
	INNER JOIN addresses a ON p.address_id = a.address_id
	WHERE p.env_score > 50
END