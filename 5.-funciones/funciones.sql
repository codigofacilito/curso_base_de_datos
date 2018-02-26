DELIMITER //

CREATE FUNCTION agregar_dias(fecha DATE, dias INT)
RETURNS DATE
BEGIN
  RETURN fecha + INTERVAL dias DAY;
END//

CREATE FUNCTION obtener_paginas()
RETURNS INT
BEGIN
  SET @paginas = (SELECT (ROUND( RAND() * 100 ) * 4 ));
  RETURN @paginas;
END//

CREATE FUNCTION obtener_ventas()
RETURNS INT
BEGIN
  SET @paginas = (SELECT (ROUND( RAND() * 100 ) * 6 ));
  RETURN @paginas;
END//

DELIMITER ;

UPDATE libros SET paginas = obtener_paginas();
UPDATE libros SET ventas = obtener_ventas();
