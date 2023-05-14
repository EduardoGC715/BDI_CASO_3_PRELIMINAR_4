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
	DECLARE @paymentID  INT


	DECLARE @user varchar(150)
	DECLARE @productName VARCHAR(150)
	DECLARE @quantity int
	DECLARE @product_tax DECIMAL(10,4)
	DECLARE @paymentMethod INT
	DECLARE @currency INT
	DECLARE @totalCost DECIMAL (18,4)
	DECLARE @subTotalCost DECIMAL (18,4)
	

	DECLARE @net_profit INT
	DECLARE @tax INT
	DECLARE @alt_collector_proffit_percentage INT
	DECLARE @producer_proffit_percentage INT
	DECLARE @collector_profit INT
	DECLARE @producer_profit INT
	
	
	


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
			SELECT TOP 1 @productID = p.product_id 
				FROM products p
				INNER JOIN traductions t ON p.control_word_id = t.control_word_id
				WHERE t.traduction =  @productName; 

			SELECT TOP 1 @contractId = contr.contract_id 
				FROM contracts contr
				INNER JOIN products_inventories prodi ON contr.contract_id = prodi.contract_id
				INNER JOIN products prod  ON prod.product_id = prodi.product_id;


			SET @alt_collectorID = (SELECT TOP 1 alt_collector_id FROM contract_terms WHERE contract_id = @contractId);
			SET @contractTermsID   = (SELECT TOP 1 contract_term_id FROM contract_terms WHERE contract_id = @contractId);
			SET @producerID   = (SELECT TOP 1 producer_id FROM contract_terms WHERE contract_id = @contractId);
			SET @channelID = (SELECT TOP 1 channel_id FROM channels WHERE channel_name = (SELECT TOP 1 channel FROM @payment_info));
			SET @user = (SELECT TOP 1 buyer FROM @payment_info);
			SET @paymentMethod = (SELECT TOP 1 payment_method_id FROM payment_methods WHERE name = (SELECT TOP 1 payment_method FROM @payment_info));
			SET @currency = (SELECT TOP 1 currency_id FROM currencies WHERE abreviation = (SELECT TOP 1 currency FROM @payment_info));




			

			SET  @alt_collector_proffit_percentage  = (SELECT TOP 1 alt_collector_profit_percentage FROM contract_terms WHERE contract_terms.contract_id = @contractID) ;
			
			SELECT TOP 1 @tax = percentage 
				FROM taxes 
				INNER JOIN taxesXcontracts ON taxes.tax_id = taxesXcontracts.tax_id
				WHERE taxesXcontracts.contract_id = @contractID;

			

			SET @net_profit = (SELECT TOP 1 sale_cost - production_cost FROM products WHERE @productID = products.product_id);
			SET @net_profit =  (SELECT TOP 1  @net_profit- sale_cost*@tax FROM products WHERE @productID = products.product_id);
			

			SET  @producer_profit = (SELECT TOP 1 @net_profit*producer_profit_percentage FROM contract_terms WHERE contract_terms.contract_id = @contractID);
			SET  @collector_profit = (SELECT TOP 1 @net_profit*alt_collector_profit_percentage FROM contract_terms WHERE contract_terms.contract_id = @contractID);

			SET  @subTotalCost = (SELECT TOP 1 sale_cost - sale_cost*@tax FROM products WHERE @productID = products.product_id);
			SET  @totalCost = (SELECT TOP 1 sale_cost FROM products WHERE @productID = products.product_id);


			DECLARE @saleID INT
			DECLARE @invoiceID INT

			INSERT INTO sales(channel_id, buyer, quantity, status) 
			VALUES (@channelID, @user, @quantity, 1)
			SET @saleID = SCOPE_IDENTITY();

			INSERT INTO invoices(release_date, currency_id, invoice_type_id, contract_id, producer_id, alt_collector_id, buyer, total_cost, invoice_status, created_at, updated_at, computer, username, checksum)
			VALUES (@date, @currency, 1, @contractID, @producerID, @alt_collectorID, @user, @totalCost, 'processed' , @date, @date, @computer, @username, @checksum)
			SET @invoiceID = SCOPE_IDENTITY();



			INSERT INTO invoice_details(invoice_id, sale_id, subtotal_cost, created_at, updated_at, computer, username, checksum)
			VALUES (@invoiceID, @saleID, @subtotalCost, @date, @date, @computer, @username, @checksum);


			INSERT INTO payments (payment_method_id, total_payment, created_at, updated_at, computer, username,  checksum)  
			VALUES (@paymentMethod, @totalCost, @date, @date, @computer, @username, @checksum)
			SET @paymentID = SCOPE_IDENTITY();;

			INSERT INTO transactions (payment_id, invoice_id, date, created_at, updated_at, computer, username,  checksum)  VALUES 
						(@paymentID, @invoiceID, @date, @date, @date, @computer, @username, @checksum);
			




			UPDATE products_inventories SET available_quantity = available_quantity - @quantity WHERE products_inventories.product_id = @productID; 


			UPDATE balances
				SET amount = amount + @producer_profit
				WHERE producer_id = @producerID;


			IF (@collector_profit IS NOT NULL)
			BEGIN 
			UPDATE balances
				SET amount = amount + @collector_profit
				WHERE alt_collector_id = @alt_collectorID;
			
			UPDATE balances
				SET amount = amount + (@net_profit - (@producer_profit + @collector_profit))
				WHERE isEsencial = 1;
			END;






			FETCH NEXT FROM product_cursor INTO @productName, @quantity
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




DECLARE @new_product_sales productSaleType;
DECLARE @new_payment_info paymentInfoType;



INSERT INTO @new_product_sales (name, quantity)
VALUES  ( 'product1057', 10),
		('product4404', 7);
       

INSERT INTO @new_payment_info (channel, buyer, payment_method, currency)
VALUES	('canal2094', 'me', 'tarjeta de credito', 'USD'),
        ('canal8757', 'me', 'tarjeta de debito', 'USD');


EXEC product_sale_SP @product_sales = @new_product_sales, @payment_info = @new_payment_info;


SELECT * FROM sales ORDER BY sale_id DESC;

SELECT * FROM invoices ORDER BY invoice_id DESC;

SELECT * FROM transactions ORDER BY transaction_id DESC;







SELECT traduction,
		available_quantity,
		sale_cost
		FROM traductions trd
		INNER JOIN products prd ON prd.control_word_id = trd.control_word_id
		INNER JOIN products_inventories prdinv ON prdinv.product_id = prd.product_id
		ORDER BY trd.control_word_id, prdinv.available_quantity, prd.product_id;



DECLARE @productName VARCHAR(150);   

SELECT sale_cost
		FROM traductions trd
		INNER JOIN products prd ON prd.control_word_id = trd.control_word_id
		INNER JOIN products_inventories prdinv ON prdinv.product_id = prd.product_id
		WHERE trd.traduction LIKE %@productName%
		ORDER BY trd.control_word_id, prdinv.available_quantity, prd.product_id;


















		def complete_transaction():

    print("adios")
    # Get the information from the Tkinter components
    channel = channel_var.get()
    buyer = name_input.get()
    payment_method = payment_var.get()
    currency = currency_var.get()

    # Create the lists for the product sale and payment info data
    product_sales = []
    for product in cart.items():
        product_sales.append((product[0], int(product[1]))) 
        print(product)
    print("product sales", product_sales)
    payment_info = [channel, buyer, payment_method, currency]
    print("payment_info", payment_info)
    
    sql_query = """
        DECLARE @new_product_sales productSaleType;
        DECLARE @new_payment_info paymentInfoType;
        {}
        INSERT INTO @new_payment_info (channel, buyer, payment_method, currency) VALUES (?, ?, ?, ?);
        EXEC product_sale_SP @product_sales = @new_product_sales, @payment_info = @new_payment_info;
    """

    # Define the values clause with parameterized placeholders
    values_clause = ", ".join(["(?, ?)"] * len(product_sales))
    # Construct the full SQL query with parameterized placeholders
    sql_query = sql_query.format(f"INSERT INTO @new_product_sales (name, quantity) VALUES {values_clause};")
    # Flatten the product_sales list of tuples into a flat list of values
    product_sales_flat = [val for tpl in product_sales for val in tpl]
    print("query: ", sql_query)
    print("-----------------------------------------------------------------------")
    print("product_sales_flat: ", product_sales_flat)
    
    # Execute the SQL query with the flattened product_sales and payment_info lists as parameters
    try:
        cursor.execute(sql_query, product_sales_flat + payment_info)
        print("Transaction completed successfully")
    except Exception as e:
        cursor.rollback()
        print("Transaction failed. Error message: ", e)
    