-- 1
select nombre from producto;

-- 2
select nombre,precio from producto;

-- 3
select * from producto;

-- 4
SELECT nombre,precio,precio * 1.18 As precio_en_Dollars
FROM producto;

-- 5
SELECT nombre AS Nombre_del_Producto, 
precio AS Euros,
precio * 1.18, 2 AS Dolars
FROM producto;

-- 6
SELECT UPPER (nombre), precio
FROM producto;

-- 7
SELECT LOWER (nombre), precio
FROM producto;

-- 8
SELECT nombre, 
UPPER(SUBSTRING(nombre, 1, 2)) AS Dos_Primeros_Caracteres
FROM fabricante;

-- 9
Select nombre,ROUND (precio)
from producto;

-- 10
SELECT nombre, TRUNCATE(precio, 0) AS Precio
FROM producto;

-- 11
Select codigo_fabricante
from producto;

-- 12
SELECT DISTINCT codigo_fabricante
FROM producto;

-- 13
SELECT * FROM fabricante
ORDER BY nombre ASC;

-- 14
SELECT * FROM fabricante
ORDER BY nombre DESC;

-- 15
SELECT nombre , precio
FROM producto
ORDER BY nombre ASC, precio DESC;

-- 16
SELECT * FROM fabricante LIMIT 5;

-- 17
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

-- 18
SELECT nombre , precio 
FROM producto
ORDER BY precio ASC
LIMIT 1;

-- 19
SELECT nombre , precio 
FROM producto
ORDER BY precio DESC
LIMIT 1;

-- 20
Select * from fabricante
where codigo = 2;

-- 21
SELECT producto.nombre , producto.precio , fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 22
SELECT producto.nombre , producto.precio , fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;

-- 23
SELECT p.codigo AS Codigo_Producto, p.nombre AS Nombre_Producto, p.codigo_fabricante AS Codigo_Fabricante, f.nombre AS Nombre_Fabricante
FROM producto AS p
JOIN fabricante AS f ON p.codigo_fabricante = f.codigo;

-- 24
SELECT producto.nombre, producto.precio , fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio
LIMIT 1;

-- 25
SELECT producto.nombre, producto.precio , fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio DESC
LIMIT 1;

-- 26
SELECT producto.nombre , producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

-- 27
SELECT producto.nombre , producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND precio > 200;

-- 28
SELECT producto.nombre,fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

-- 29
select producto.nombre, fabricante.nombre
from producto
join fabricante on producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 30

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE SUBSTRING(fabricante.nombre, -1) = 'e';

-- 31
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';

-- 32 

SELECT producto.nombre , producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio > 180
ORDER BY producto.precio DESC, producto.nombre ASC;

-- 33

SELECT fabricante.codigo, fabricante.nombre
FROM fabricante
WHERE fabricante.codigo IN (SELECT DISTINCT codigo_fabricante FROM producto);

-- 34

SELECT fabricante.nombre , producto.nombre , producto.precio
FROM fabricante
LEFT JOIN producto 
ON fabricante.codigo = producto.codigo_fabricante;

-- 35
SELECT fabricante.nombre, producto.nombre, producto.precio
FROM fabricante
LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
where producto.precio is null;

-- 36
SELECT nombre
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- 37

SELECT * FROM producto
WHERE producto.precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 38 

SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo'
ORDER BY producto.precio DESC
LIMIT 1;

-- 39 
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Hewlett-Packard'
ORDER BY producto.precio ASC
LIMIT 1;

 -- 40
SELECT producto.nombre, producto.precio
FROM producto
WHERE producto.precio >= ( SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
 
 -- 41
SELECT producto.nombre, producto.precio
FROM producto
WHERE producto.codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus')
AND producto.precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));



