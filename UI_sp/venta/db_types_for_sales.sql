USE [Esencial Verde];






--Type for --
CREATE TYPE productSaleType AS TABLE
(
    name varchar(150),
    quantity int 
);


CREATE TYPE paymentInfoType AS TABLE
(
	channel varchar(150),
	buyer varchar(150),
	payment_method varchar(150),
	currency varchar(3)
);





DROP PROCEDURE product_sale_SP;