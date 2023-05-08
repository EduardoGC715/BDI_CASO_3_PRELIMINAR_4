USE [Esencial Verde];




-- languages fill--



-- control_words for currencies  fill--
-- INSERT statements for control_words table
INSERT INTO control_words (control_word_id)
VALUES 
    (21),
    (22),
    (23);

-- INSERT statement for traductions table
INSERT INTO traductions (control_word_id, language_id, traduction, [default])
VALUES 
    (21, 1, 'Conveyor grande para empaquetar y clasificar', 1),
    (21, 2, 'Conveyor belt grande for packaging y sorting', 0),
    (22, 1, 'Prensa pequeña para dar forma a piezas de metal', 1),
    (22, 2, 'Small stamping press for shaping metal parts', 0),
    (23, 1, 'Línea de ensamblaje automatizada para componentes electrónicos', 1),
    (23, 2, 'Lina de ensamblaje automatico para componentes electronicos', 0);



-- Machines fill --

INSERT INTO machineries (control_word_id, capacity, duration, description)
VALUES 
    (21, 1, '02:00:00', 'Conveyor grande para empaquetar y clasificar'),
    (22, 1, '01:00:00', 'Prensa pequeña para dar forma a piezas de metal'),
    (23, 1, '04:00:00', 'Línea de ensamblaje automatizada para componentes electrónicos');

