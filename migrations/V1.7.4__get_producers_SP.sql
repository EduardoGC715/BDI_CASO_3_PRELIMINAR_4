USE [Esencial Verde]
GO
/****** Object:  StoredProcedure [dbo].[get_producers]    Script Date: 5/12/2023 1:46:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[get_producers]
AS
BEGIN
	WAITFOR DELAY '00:00:02'
    SELECT TOP (1000) p.name, p.env_score, a.zip_code
	FROM producers p
	INNER JOIN addresses a ON p.address_id = a.address_id
	ORDER BY env_score DESC
END