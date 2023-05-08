CREATE VIEW dbo.containers_producers_indexed
WITH SCHEMABINDING 
AS 
SELECT ci.container_inventory_id, ct.container_type_id, ct.capacity, ct.material, ct.brand, ct.model, t.traduction waste_type, ci.available, ci.in_use, ci.on_maintenance, ci.discarded, ci.lost_quantity, p.name producer
FROM dbo.containers_inventories ci
JOIN dbo.container_types ct ON ci.container_type_id = ct.container_type_id
JOIN dbo.wastes w ON ct.waste_id = w.waste_id
JOIN dbo.traductions t ON w.control_word_id = t.control_word_id
JOIN dbo.producers p  ON ci.producer_id = p.producer_id
GO

CREATE UNIQUE CLUSTERED INDEX UIX_containers_producers_indexed_container_inventory_id__container_type_id ON dbo.containers_producers_indexed
(container_inventory_id, container_type_id);

SELECT * FROM dbo.containers_producers_indexed;