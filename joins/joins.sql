SELECT
  li.titulo,
  CONCAT(au.nombre, " ", au.apellido) AS nombre_autor,
  li.fecha_creacion
FROM libros AS li
INNER JOIN autores AS au ON li.autor_id = au.autor_id;

-------------------------
SELECT
  li.titulo,
  CONCAT(au.nombre, " ", au.apellido) AS nombre_autor,
  li.fecha_creacion
FROM libros AS li
INNER JOIN autores AS au USING(autor_id);

-------------------------

usuario = a
libros_usuarios = b

SELECT
  CONCAT(nombre, " ", apellidos),
  libros_usuarios.libro_id
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NOT NULL;

-------------------------

libros_usuarios = a
usuario = b

SELECT
  CONCAT(nombre, " ", apellidos),
  libros_usuarios.libro_id
FROM libros_usuarios
LEFT JOIN usuarios ON libros_usuarios.usuario_id = usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NOT NULL;


---------------------------

SELECT DISTINCT
  CONCAT(usuarios.nombre, " ", usuarios.apellidos) AS nombre_completo
FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
                          AND DATE(libros_usuarios.fecha_creacion) = CURDATE()
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
INNER JOIN autores ON libros.autor_id = autores.autor_id AND autores.seudonimo IS NOT NULL;
