USE [Esencial Verde];

-- Insert control words for invoice type ids -- 
INSERT INTO control_words (control_word_id)
VALUES 
    (24),
	(25),
	(26),
	(27),
	(28),
	(29),
	(30);


-- Insert traductions words for invoice type ids -- 
INSERT INTO traductions (control_word_id, language_id, traduction, [default])
VALUES 
    (24,1,'venta_producto',1),
	(25,1,'venta_material',1),
	(26,1,'pago_producer',1),
	(27,1,'pago_recolector_alternativo',1);



	-- Insert traductions words for invoice type ids -- 
INSERT INTO invoice_types(control_word_id)
VALUES 
    (24),
	(25),
	(26),
	(27);




INSERT  INTO payment_methods(name) 
	VALUES	
		('tarjeta de credito'),
		('tarjeta de debito'),
		('depósito de debito'),
		('en efectivo (pagado en el retiro de compra');


