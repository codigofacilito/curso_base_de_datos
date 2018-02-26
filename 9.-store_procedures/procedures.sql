DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
BEGIN
  SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);


  IF cantidad > 0 THEN

    INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
    UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

  --ELSEIF condición THEN

  ELSE

    SELECT "No es posible realizar el prestamo" AS mensaje;

  END IF;
END//

CREATE PROCEDURE tipo_lector(usuario_id INT)
BEGIN
  SET @cantidad = (SELECT COUNT(*) FROM libros_usuarios WHERE libros_usuarios.usuario_id = usuario_id);

  CASE
    WHEN @cantidad > 20 THEN
      SELECT "Fanatico" AS mensaje;
    WHEN @cantidad > 10 AND @cantidad < 20 THEN
      SELECT "Afionado" AS mensaje;
    WHEN @cantidad > 5 AND @cantidad < 10 THEN
      SELECT "Promedio" AS mensaje;
    ELSE
      SELECT "Nuevo" AS mensaje;
  END CASE;
END//

CREATE PROCEDURE libros_azar_1()
BEGIN
  SET @iteraciones= 0;

  WHILE @iteraciones < 5 DO
    SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
    SET @iteraciones = @iteraciones + 1;
  END WHILE;

END//

CREATE PROCEDURE libros_azar_2()
BEGIN
  SET @iteraciones= 0;

  REPEAT
    SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
    SET @iteraciones = @iteraciones + 1;

    UNTIL @iteraciones >= 5
  END REPEAT;

END//

DELIMITER ;
