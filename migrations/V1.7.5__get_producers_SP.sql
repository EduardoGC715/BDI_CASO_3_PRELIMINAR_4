USE [Esencial Verde]
GO
/****** Object:  StoredProcedure [dbo].[get_producers]    Script Date: 5/14/2023 7:32:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[get_producers]
AS
BEGIN
    SELECT TOP (1000) p.name, p.env_score, a.zip_code
	FROM producers p
	INNER JOIN addresses a ON p.address_id = a.address_id
	ORDER BY env_score DESC
END