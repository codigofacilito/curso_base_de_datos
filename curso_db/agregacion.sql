SELECT AVG(ventas) FROM libros; --320.1818

SELECT CONCAT(nombre, " ", apellido) AS nombre
FROM autores
WHERE autor_id IN(
  SELECT
    autor_id
  FROM libros
  GROUP BY autor_id
  HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros));
