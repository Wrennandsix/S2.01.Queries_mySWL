-- 1
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;

-- 2
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL ;

-- 3 
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 4
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND RIGHT(nif, 1) = 'K';

-- 5
SELECT nombre
FROM asignatura
WHERE id_grado = 7 AND curso = 3 AND cuatrimestre = 1;

-- 6
SELECT persona.apellido1,persona.apellido2,persona.nombre,departamento.nombre
FROM profesor
JOIN persona ON profesor.id_profesor = persona.id
JOIN departamento ON profesor.id_departamento = departamento.id;

-- 7
SELECT asignatura.nombre ,curso_escolar.anyo_inicio,curso_escolar.anyo_fin
FROM persona
JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE persona.nif = '26902806M';

-- 8
SELECT DISTINCT departamento.nombre as Nom_departament
FROM departamento
JOIN profesor ON departamento.id = profesor.id_departamento
JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
JOIN grado ON asignatura.id_grado = grado.id
WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9
SELECT DISTINCT persona.nombre,persona.apellido1,persona.apellido2
FROM alumno_se_matricula_asignatura
JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE curso_escolar.anyo_inicio = 2018 AND curso_escolar.anyo_fin = 2019;

-- Queries utilitzant nomes LEFT JOIN i RIGHT JOIN:

-- 1
SELECT departamento.nombre,persona.apellido1,persona.apellido2,persona.nombre
FROM persona 
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;

-- 2
SELECT departamento.nombre,persona.apellido1,persona.apellido2,persona.nombre
FROM persona 
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE departamento.nombre is null
ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;

-- 3 

SELECT departamento.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
WHERE profesor.id_departamento IS NULL;

-- 4 
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2
FROM persona 
LEFT JOIN asignatura ON persona.id = asignatura.id_profesor
WHERE asignatura.id IS NULL AND persona.tipo = 'profesor';

-- 5
SELECT asignatura.id, asignatura.nombre 
FROM asignatura 
LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor
WHERE profesor.id_profesor IS NULL;

-- 6
SELECT departamento.id, departamento.nombre
FROM departamento 
WHERE departamento.id NOT IN (
    SELECT DISTINCT departamento.id
    FROM departamento 
    LEFT JOIN profesor ON departamento.id = profesor.id_departamento
    LEFT JOIN asignatura  ON profesor.id_profesor = asignatura.id_profesor
    WHERE asignatura.id IS NOT NULL
);

-- Consultes resum:

-- 1
SELECT COUNT(*) AS total_alumnos
FROM persona
WHERE tipo = 'alumno';

-- 2 
SELECT COUNT(*) AS alumnos_nacidos_en_1999
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 3 
SELECT departamento.nombre AS nombre_departamento, COUNT(persona.id) AS numero_Profesores
FROM departamento 
INNER JOIN profesor ON departamento.id = profesor.id_departamento
INNER JOIN persona ON profesor.id_profesor = persona.id
GROUP BY departamento.nombre
ORDER BY numero_Profesores DESC;

-- 4
SELECT departamento.nombre AS nombre_departamento, (SELECT COUNT(*) FROM profesor WHERE profesor.id_departamento = departamento.id) AS numero_Profesores
FROM departamento 
ORDER BY numero_Profesores DESC;

-- 5
SELECT grado.nombre AS nombre_grado, COUNT(asignatura.id) AS numero_asignaturas
FROM grado 
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
ORDER BY numero_asignaturas DESC;

-- 6
SELECT grado.nombre AS nombre_grado, COUNT(asignatura.id) AS numero_asignaturas
FROM grado 
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
HAVING COUNT(asignatura.id) > 40;

-- 7
SELECT grado.nombre AS nombre_grado,asignatura.tipo AS tipo_asignatura,SUM(asignatura.creditos) AS suma_creditos
FROM grado 
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre, asignatura.tipo
ORDER BY nombre_grado, tipo_asignatura;

-- 8
SELECT anyo_inicio AS año_inicio_curso, COUNT(DISTINCT id_alumno) AS num_alumnos_matriculados
FROM curso_escolar
LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
GROUP BY año_inicio_curso
ORDER BY año_inicio_curso;

-- 9
SELECT persona.id,persona.nombre,persona.apellido1,persona.apellido2,COUNT(asignatura.id) AS numero_asignaturas
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE persona.tipo = 'profesor'
GROUP BY persona.id
HAVING numero_asignaturas = 0;


-- 10
SELECT * FROM persona
WHERE tipo = 'alumno'
ORDER BY fecha_nacimiento DESC
LIMIT 1;

-- 11
SELECT persona.nombre,persona.apellido1,persona.apellido2,COUNT(asignatura.id) AS numero_asignaturas
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE persona.tipo = 'profesor'
GROUP BY persona.id
HAVING numero_asignaturas = 0;
































