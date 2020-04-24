USE libreria_cf;

SELECT "Obtener todos los libros escritos por autores que cuenten con un seudónimo." AS Ejercicio_1;

SELECT *
    FROM libros
    WHERE autor_id IN (
	SELECT autor_id
	    FROM autores
	    WHERE seudonimo IS NOT NULL
    );

SELECT "Obtener el título de todos los libros publicados en el año actual cuyos autores poseen un pseudónimo." AS Ejercicio_2;
SELECT titulo
    FROM libros
    WHERE autor_id IN (
	SELECT autor_id
	    FROM autores
	    WHERE seudonimo IS NOT NULL
    ) AND YEAR(fecha_publicacion) = 2018;

SELECT "Obtener todos los libros escritos por autores que cuenten con un seudónimo y que hayan nacido ante de 1965." AS Ejercicio_3;
SELECT *
    FROM libros
    WHERE autor_id IN (
	SELECT autor_id
	    FROM autores
	    WHERE
		seudonimo IS NOT NULL AND
		YEAR(fecha_nacimiento) < 1965
    );

SELECT "Colocar el mensaje no disponible a la columna descripción, en todos los libros publicados antes del año 2000." AS Ejercicio_4;
SELECT
    libro_id, autor_id, titulo, titulo,
    IF (YEAR(fecha_publicacion) < 2000, "No disponible", descripcion) AS descripcion,
    paginas, fecha_publicacion, fecha_creacion, ventas,  stock
    FROM libros;

SELECT "Obtener la llave primaria de todos los libros cuya descripción sea diferente de no disponible." AS Ejercicio_5;
SELECT
    autor_id,
    IF (YEAR(fecha_publicacion) < 2000, "No disponible", descripcion) AS descripcion
    FROM libros
    WHERE descripcion != "No disponible" ;

SELECT "Obtener el título de los últimos 3 libros escritos por el autor con id 2" AS Ejercicio_6;
SELECT titulo
    FROM libros
    WHERE autor_id = 2
    ORDER BY fecha_publicacion DESC
    LIMIT 3;

SELECT "Obtener en un mismo resultado la cantidad de libros escritos por autores con seudónimo y sin seudónimo." AS Ejercicio_7;
SELECT 
    (SELECT COUNT(*)
	FROM libros
        WHERE autor_id IN (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL)
    ) AS "Con seudonimo",
    (SELECT COUNT(*)
	FROM libros
        WHERE autor_id IN (SELECT autor_id FROM autores WHERE seudonimo IS NULL)
    ) AS "Sin seudonimo";
SELECT "Obtener la cantidad de libros publicados entre enero del año 2000 y enero del año 2005." AS Ejercicio_8;

SELECT COUNT(*) FROM libros WHERE YEAR(fecha_publicacion) BETWEEN 2000 AND 2015;

SELECT "Obtener el título y el número de ventas de los cinco libros más vendidos." AS Ejercicio_9;

SELECT titulo, ventas FROM libros ORDER BY ventas DESC LIMIT 5;

SELECT "Obtener el título y el número de ventas de los cinco libros más vendidos de la última década." AS Ejercicio_10;
SELECT titulo, ventas, fecha_publicacion
    FROM libros
    WHERE fecha_publicacion BETWEEN NOW() - INTERVAL 10 YEAR AND NOW()
    ORDER BY fecha_publicacion DESC
    LIMIT 5;

SELECT "Obtener la cantidad de libros vendidos por los autores con id 1, 2 y 3." AS Ejercicio_11;
SELECT autor_id, SUM(ventas) FROM libros WHERE autor_id IN (1,2,3) GROUP BY autor_id;

SELECT "   Obtener el título del libro con más páginas." AS Ejercicio_12;

SELECT titulo FROM libros ORDER BY paginas DESC LIMIT 1;

SELECT "   Obtener todos los libros cuyo título comience con la palabra “La”." AS Ejercicio_13;
SELECT * FROM libros WHERE titulo LIKE "LA%";

SELECT "   Obtener todos los libros cuyo título comience con la palabra “La” y termine con la letra “a”." AS Ejercicio_14;
SELECT * FROM libros WHERE titulo LIKE 'La%a';

SELECT "Establecer el stock en cero a todos los libros publicados antes del año de 1995" AS Ejercicio_15;
 SELECT
    libro_id, autor_id, titulo, descripcion,
    paginas, fecha_publicacion, fecha_creacion, ventas,
    IF (YEAR(fecha_publicacion)<1995, 0, stock) AS stock
FROM libros;

SELECT "   Mostrar el mensaje Disponible si el libro con id 1 posee más de 5 ejemplares en stock, en caso contrario mostrar el mensaje No disponible." AS Ejercicio_16;
SELECT *, IF(stock>5, "Disponible", "No disponible") AS mensaje FROM libros WHERE libro_id = 1;

SELECT "   Obtener el título los libros ordenador por fecha de publicación del más reciente al más viejo." AS Ejercicio_17;
SELECT titulo FROM libros ORDER BY fecha_publicacion DESC;

-- AUTORES

SELECT "Obtener el nombre de los autores cuya fecha de nacimiento sea posterior a 1950" AS Ejercicio_18;
SELECT nombre FROM autores WHERE YEAR(fecha_nacimiento) >  1950;

SELECT "Obtener la el nombre completo y la edad de todos los autores." AS Ejercicio_19;
SELECT
    CONCAT(nombre, " ", apellido) AS nombre_completo,
    YEAR( NOW() - INTERVAL YEAR(fecha_nacimiento) YEAR + INTERVAL DAYOFYEAR(fecha_nacimiento) DAY) AS edad
FROM autores;


SELECT "Obtener el nombre completo de todos los autores cuyo último libro publicado sea posterior al 2005" AS Ejercicio_20;

SELECT CONCAT(nombre, " ", apellido) AS nombre_completo
FROM autores
WHERE autor_id IN (SELECT autor_id FROM libros WHERE YEAR(fecha_publicacion) > 2005 GROUP BY autor_id);

SELECT "Obtener el id de todos los escritores cuyas ventas en sus libros superen el promedio" AS Ejercicio_21;

SELECT autor_id
    FROM libros
    GROUP BY autor_id
    HAVING AVG(ventas) > (
	SELECT AVG(ventas) FROM libros
    );


SELECT "Obtener el id de todos los escritores cuyas ventas en sus libros sean mayores a cien mil ejemplares." AS Ejercicio_22;
SELECT DISTINCT autor_id
    FROM libros
    WHERE ventas > 100;


-- FUNCIONES

SELECT "Crear una función la cual nos permita saber si un libro es candidato a préstamo o no. Retornar “Disponible” si el libro posee por lo menos un ejemplar en stock, en caso contrario retornar “No disponible.”" AS Ejercicio_23;

DROP FUNCTION IF EXISTS disponible_para_prestamo;

DELIMITER //
CREATE FUNCTION disponible_para_prestamo(stock INT)
RETURNS VARCHAR(13)
BEGIN
    RETURN IF(stock > 0, "Disponible", "No disponible");
END //
DELIMITER ;

