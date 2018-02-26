DROP DATABASE IF EXISTS libreria_cf;
CREATE DATABASE IF NOT EXISTS libreria_cf;

USE libreria_cf;

CREATE TABLE autores(
  autor_id INT,
  nombre VARCHAR(25),
  apellido VARCHAR(25),
  genero CHAR(1), -- M o F
  fecha_nacimiento DATE,
  pais_origen VARCHAR(40)
);

INSERT INTO autores(autor_id, nombre, genero, fecha_nacimiento, pais_origen)
VALUES  (1, 'Codi', 'M', '2018-01-01', 'México'),
        (2, 'Codi', 'M', '2018-01-01', 'México'),
        (3, 'Codi', 'M', '2018-01-01', 'México'),
        (4, 'Codi', 'M', '2018-01-01', 'México'),
        (5, 'Codi', 'M', '2018-01-01', 'México');

SELECT * FROM autores;
