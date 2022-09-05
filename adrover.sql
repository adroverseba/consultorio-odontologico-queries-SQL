CREATE DATABASE IF NOT EXISTS adrover;

USE adrover;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS pacientes(
  id_paciente INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  domicilio VARCHAR(50) NOT NULL,
  numero_documento VARCHAR(20) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  sexo CHAR (1),  -- H o M
  telefono VARCHAR(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS consultas(
  id_consulta INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  fecha TIMESTAMP NOT NULL,
  id_paciente INT NOT NULL,
  legajo INT,
  id_tratamiento INT,
  FOREIGN KEY (id_paciente)
    REFERENCES pacientes(id_paciente)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY (legajo)
    REFERENCES odontologos(legajo)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(id_tratamiento)
    REFERENCES tratamientos(id_tratamiento)
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);

CREATE TABLE IF NOT EXISTS odontologos(
  legajo INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  nombre_completo VARCHAR(50) NOT NULL,
  dni VARCHAR(20) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  especialidad VARCHAR(20),
  nombre_local VARCHAR(20),
  FOREIGN KEY (nombre_local)
    REFERENCES locales(nombre_local)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS tratamientos(
  id_tratamiento INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  costo DECIMAL(9,2) DEFAULT 0,
  legajo INT,
  FOREIGN KEY (legajo)
    REFERENCES odontologos(legajo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS locales(
  nombre_local VARCHAR(20) NOT NULL UNIQUE PRIMARY KEY,
  direccion VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS consultorios(
  numero_consultorio INT NOT NULL PRIMARY KEY,
  nombre_local VARCHAR(20),
    FOREIGN KEY (nombre_local)
      REFERENCES locales(nombre_local)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS equipos(
  num_serie INT NOT NULL UNIQUE PRIMARY KEY,
  tipo  VARCHAR(20) NOT NULL,
  fecha_mantenimiento DATE,
  numero_consultorio INT,
    FOREIGN KEY (numero_consultorio)
    REFERENCES consultorios(numero_consultorio)
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);

SET FOREIGN_KEY_CHECKS = 1;


--                                  creacion de VISTAS


-- genero la vista de los costos de tratamientos, el IVA de los mismos y su costo total
CREATE VIEW v_costo_tratamientos AS 
SELECT *, ROUND(costo*0.21,2) IVA, SUM(ROUND(costo*0.21,2)+costo) TOTAL
FROM tratamientos 
GROUP BY id_tratamiento
ORDER BY costo DESC
;

SELECT * FROM v_costo_tratamientos;


-- vista de equipos con fecha de mantenimiento mayores a un anho
CREATE OR REPLACE VIEW v_fecha_mantenimiento_viejas AS
SELECT * FROM equipos
WHERE DATEDIFF(NOW(),fecha_mantenimiento) > 365 
;

SELECT * v_fecha_mantenimiento_viejas;



-- vista con datos del cliente, tratamiento, costos y n de legajo del odontologo
CREATE OR REPLACE VIEW v_cliente_tratamientos AS 
SELECT t.id_tratamiento, t.nombre as tratamiento, t.costo, t.legajo as odontologo_legajo, a.nombre as paciente, a.telefono
FROM tratamientos t  
JOIN 
(
	SELECT p.nombre, p.telefono ,c.id_tratamiento
	FROM consultas c
	JOIN pacientes p ON (c.id_paciente=p.id_paciente)
) a ON t.id_tratamiento= a.id_tratamiento
;

-- vista que contiene calculo de edad del paciente y condicional CASE que 
-- define el tipo de cliente segun su edad 
CREATE OR REPLACE VIEW v_edad_tipo_cliente AS
SELECT *, ROUND(DATEDIFF(NOW(), p.fecha_nacimiento)/365,0) as edad,
CASE
	WHEN ROUND(DATEDIFF(NOW(), p.fecha_nacimiento)/365,0) > 50 THEN 'Adulto Mayor'
    WHEN ROUND(DATEDIFF(NOW(), p.fecha_nacimiento)/365,0) >= 18 THEN 'Adulto' 
    ELSE 'Infantes'
END as tipo_cliente
FROM pacientes p
;

-- vista para mostrar en que local estan las maquinas utilizadas 
CREATE OR REPLACE VIEW v_maquinas_ubicacion AS
SELECT c.numero_consultorio
	,nombre_local
    , num_serie as num_serie_maquina
    , tipo as tipo_maquina 
    ,fecha_mantenimiento
FROM consultorios c
JOIN equipos e ON c.numero_consultorio=e.numero_consultorio
;