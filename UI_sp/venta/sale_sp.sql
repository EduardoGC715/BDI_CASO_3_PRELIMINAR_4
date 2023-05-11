-----------------------------------------------------------------
-- Autor: ERodriguez
-- Fecha: 05/08/2023
-- Descripcion: esta description en comentarios queda almacenada
-- SP de venta de productos. 
-----------------------------------------------------------------



CREATE PROCEDURE product_sale_SP
	@product_sales productSaleType READONLY,
	@payment_info paymentInfoType READONLY
AS 
BEGIN
	
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT
	DECLARE @date DATETIME
	DECLARE @computer VARCHAR(50)
	DECLARE @username VARCHAR(50)
	DECLARE @checksum VARBINARY(150)


	DECLARE @productID int
	DECLARE @producerID int
	DECLARE @alt_collectorID INT
	DECLARE @contractID INT
	DECLARE @contractTermsID INT
	DECLARE @channelID INT
	DECLARE @saleID INT
	DECLARE @invoiceID INT
	DECLARE @paymentID  INT


	DECLARE @user varchar(150)
	DECLARE @productName VARCHAR(150)
	DECLARE @quantity int
	DECLARE @product_tax DECIMAL(10,4)
	DECLARE @saleNetValue DECIMAL(10,4)
	DECLARE @paymentMethod INT
	DECLARE @currency INT
	DECLARE @totalCost DECIMAL (18,4)
	DECLARE @subTotalCost DECIMAL (18,4)
	

	DECLARE @collector_due_amount INT
	DECLARE @balanceSaleProd INT
	DECLARE @balanceSaleAlt INT
	
	


	SET @date = GETDATE()
	SET @computer = 'me'
	SET @username = 'root'
	SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')

	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION	
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		DECLARE product_cursor CURSOR FOR
		SELECT name, quantity
		FROM @product_sales

		OPEN product_cursor

		FETCH NEXT FROM product_cursor INTO @productName, @quantity

		WHILE @@FETCH_STATUS = 0
		BEGIN


			-- Realice las operaciones necesarias en cada fila de la tabla de ventas de productos


			-- Selección de ids 
			SELECT @productID = p.product_id 
				FROM products p
				INNER JOIN traductions t ON p.control_word_id = t.control_word_id
				WHERE t.traduction =  @productName; 

			SELECT @contractId = contr.contract_id 
				FROM contracts contr
				INNER JOIN products_inventories prodi ON contr.contract_id = prodi.contract_id
				INNER JOIN products prod  ON prod.product_id = prodi.product_id;

			SELECT @alt_collectorID = alt_collector_id FROM contract_terms WHERE contract_id = @contractId;
			SELECT @contractTermsID = contract_term_id FROM contract_terms WHERE contract_id = @contractId;
			SELECT @producerID = producer_id FROM contract_terms WHERE contract_id = @contractId;
			SET @channelID = (SELECT channel_id FROM channels WHERE channel_name = (SELECT TOP 1 channel FROM @payment_info));
			SET @user = (SELECT TOP 1 buyer FROM @payment_info);
			SET @paymentMethod = (SELECT payment_method_id FROM payment_methods WHERE name = (SELECT TOP 1 payment_method FROM @payment_info));
			SET @currency = (SELECT currency_id FROM currencies WHERE abreviation = (SELECT TOP 1 currency FROM @payment_info));


	

			UPDATE products_inventories SET available_quantity = available_quantity - @quantity WHERE products_inventories.product_id = @productID; 


			

			INSERT INTO sales(channel_id, buyer, quantity, status)
			OUTPUT inserted.sale_id INTO @saleID
			VALUES (@channelID, @user, @quantity, 1);

			INSERT INTO invoices(release_date, currency_id, invoice_type_id, contract_id, producer_id, alt_collector_id, buyer, total_cost, created_at, updated_at, computer, username, checksum)
			OUTPUT inserted.invoice_id INTO @invoiceID
			VALUES (@date, @currency, @paymentMethod, 1, @contractID, @producerID, @alt_collectorID, @user, @totalCost, @date, @date, @computer, @username, @checksum);

			INSERT INTO invoice_details(invoice_id, sale_id, subtotal_cost, created_at, updated_at, computer, username, checksum)
			VALUES (@invoiceID, @saleID, @subtotalCost, @date, @date, @computer, @username, @checksum);


			INSERT INTO payments (payment_method_id, total_payment, created_at, updated_at, computer, username,  checksum) 
			OUTPUT inserted.payment_id INTO @paymentID  
			VALUES (@paymentMethod, @totalCost, @date, @date, @computer, @username, @checksum);

			INSERT INTO transactions (payment_id, invoice_id, date, created_at, updated_at, computer, username,  checksum)  VALUES 
						(@paymentID, @invoiceID+, @date, @date, @date, @computer, @username, @checksum);
			
			-- Restar la cantidad vendida del inventario de productos
		

			-- Realice otras operaciones necesarias en la fila actual de la tabla de ventas de productos
			-- ...

			FETCH NEXT FROM product_cursor INTO @productId, @quantity
		END

		CLOSE product_cursor
		DEALLOCATE product_cursor
		
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		


		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END
RETURN 0
GO


