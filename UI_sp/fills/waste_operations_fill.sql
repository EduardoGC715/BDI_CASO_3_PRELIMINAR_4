USE [Esencial Verde];

-- control_words for materials  fill--
-- INSERT statements for control_words table
INSERT INTO control_words (control_word_id)
SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + 30
FROM sys.objects a, sys.objects b;



-- INSERT statements for traductions table

INSERT INTO traductions(control_word_id, language_id, traduction, [default])
VALUES
    (30, 1, 'Aluminio',1),
    (31, 1, 'Hierro',1),
    (32, 1, 'Cobre',1),
    (33, 1, 'Plástico PET',1),
    (34, 1, 'Plástico HDPE',1),
    (35, 1, 'Plástico PVC',1),
    (36, 1, 'Plástico LDPE',1),
    (37, 1, 'Plástico PP',1),
    (38, 1, 'Cartón',1),
    (39, 1, 'Papel',1),
    (40, 1, 'Vidrio',1),
    (41, 1, 'Textil',1),
    (42, 1, 'Madera',1),
    (43, 1, 'Aceite de cocina',1),
    (44, 1, 'Aceite de motor',1),
    (45, 1, 'Pilas',1),
    (46, 1, 'Baterías de plomo-ácido',1),
    (47, 1, 'Baterías de ion de litio',1),
    (48, 1, 'Piedra',1),
    (49, 1, 'Arena',1),
    (50, 1, 'Grava',1),
    (51, 1, 'Hormigón',1),
    (52, 1, 'Asfalto',1),
    (53, 1, 'Cemento',1),
    (54, 1, 'Arcilla',1),
    (55, 1, 'Policarbonato',1),
    (56, 1, 'Acrílico',1),
    (57, 1, 'Poliestireno',1),
    (58, 1, 'Fibra de vidrio',1),
    (59, 1, 'Fibra de carbono',1),
    (60, 1, 'Caucho',1),
    (61, 1, 'Neopreno',1),
    (62, 1, 'Silicona',1),
    (63, 1, 'Espuma de poliuretano',1),
    (64, 1, 'Celulosa',1),
    (65, 1, 'Nylon',1),
    (66, 1, 'Teflón',1),
    (67, 1, 'Aluminio anodizado',1),
    (68, 1, 'Acero inoxidable',1),
    (69, 1, 'Acero galvanizado',1),
    (70, 1, 'Latón',1),
    (71, 1, 'Bronce',1),
    (72, 1, 'Magnesio',1),
    (73, 1, 'Titanio',1),
    (74, 1, 'Aluminio recubierto',1),
    (75, 1, 'Poliéster',1),
    (76, 1, 'Algodón',1),
    (77, 1, 'Lana',1),
    (78, 1, 'Seda',1),
    (79, 1, 'Fibras sintéticas',1),
    (80, 1, 'Pino',1),
    (81, 1, 'Roble',1),
    (82, 1, 'Cedro',1),
    (83, 1, 'Caoba',1),
    (84, 1, 'Chapa de madera',1),
    (85, 1, 'Tableros de partículas',1);







-- materials fill --
WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 30000
)
INSERT INTO materials(control_word_id, sale_cost)
SELECT CEILING(RAND(CHECKSUM(NEWID())) * 86)+30, CEILING(RAND(CHECKSUM(NEWID())) * 5000)
FROM number_sequence
OPTION (MAXRECURSION 32767)
SELECT * from materials;



-- control_words for waste_operations  fill--
-- INSERT statements for control_words table
INSERT INTO control_words (control_word_id)
SELECT TOP 10 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + 130
FROM sys.objects a, sys.objects b;


-- INSERT statements for traductions table
INSERT INTO traductions(control_word_id, language_id, traduction, [default])
VALUES

	(131, 1, 'Trituración',1),
	(132, 1, 'Compactación',1),
	(133, 1, 'Molienda',1),
	(134, 1, 'Fusión',1),
	(135, 1, 'Separación',1),
	(136, 1, 'Mezcla',1),
	(137, 1, 'Transformación química',1),
	(138, 1, 'Recubrimiento',1),
	(139, 1, 'Impresión 3D',1),
	(140, 1, 'Termoformado',1);


-- Waste_operations fill --

WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 10000
)
INSERT INTO waste_operations(control_word_id, waste_id, waste_capacity, material_id, material_yield, machinery_id, base_cost, duration)
SELECT CEILING(RAND(CHECKSUM(NEWID())) * 10) + 130, CEILING(RAND(CHECKSUM(NEWID())) * 84), CEILING(RAND(CHECKSUM(NEWID())) * 50000),
    CEILING(RAND(CHECKSUM(NEWID())) * 30000), CEILING(RAND(CHECKSUM(NEWID())) * 5000), CEILING(RAND(CHECKSUM(NEWID())) * 3),
    CEILING(RAND(CHECKSUM(NEWID())) * 3000.0 / CEILING(RAND(CHECKSUM(NEWID())) * 100)), CEILING(RAND(CHECKSUM(NEWID())) * 30)
FROM number_sequence
OPTION (MAXRECURSION 32767);
SELECT * FROM materials;




