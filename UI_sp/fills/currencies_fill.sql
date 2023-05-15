USE [Esencial Verde];



-- control_words for currencies  fill--
-- INSERT statements for control_words table
INSERT INTO control_words (control_word_id)
VALUES 
    (11),
    (12),
    (13),
    (14),
    (15),
    (16),
    (17),
    (18),
    (19),
    (20);

-- INSERT statements for traductions table
INSERT INTO traductions (control_word_id, language_id, traduction, [default])
VALUES 
	(11, 1, 'Dólar estadounidense', 1),
	(12, 1, 'Euro', 1),
	(13, 1, 'Yen japonés', 1),
	(14, 1, 'Libra esterlina', 1),
	(15, 1, 'Dólar canadiense', 1),
	(16, 1, 'Colón costarricense', 1),
	(17, 1, 'Dólar australiano', 1),
	(18, 1, 'Dólar neozelandés', 1),
	(19, 1, 'Peso mexicano', 1),
	(20, 1, 'Real brasileño', 1);




-- currencies fill --
INSERT INTO currencies (control_word_id, abreviation, symbol, exchange_rate)
VALUES 
    (11, 'USD', '$', 541.57),
    (12, 'EUR', '€', 642.60),
    (13, 'JPY', '¥', 4.93),
    (14, 'GBP', '£', 752.20),
    (15, 'CAD', '$', 449.80),
    (16, 'CHF', 'F', 588.76),
    (17, 'AUD', '$', 406.44),
    (18, 'NZD', '$', 389.30),
    (19, 'MXN', '$', 26.80),
    (20, 'BRL', 'R', 98.50);























