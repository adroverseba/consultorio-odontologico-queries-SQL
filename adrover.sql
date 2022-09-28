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

--                                  INSERCION DE VALORES A LAS TABLAS
INSERT INTO consultas 
VALUES
	(1,'2022-06-16 13:15:00',4,23066,1)
    ,(2,'2022-06-22 12:30:00',7,23657,2)
    ,(3,'2022-07-15 12:45:00',1,23545,3)
    ,(4,'2022-07-15 12:45:00',2,23451,4)
    ,(null,'2022-09-10 12:00:00',3,23066,null)
    ,(null,'2022-09-13 08:00:00',5,23451,null)
;

INSERT INTO consultorios
VALUES 
	(1,'sonrisas brillantes')
    ,(2,'sonrisas brillantes')
    ,(3,'sonrisas brillantes')
    ,(4,'sonrisas brillantes')
    ,(5,'sonrisas cede centro')
    ,(6,'sonrisas cede centro')
;

INSERT INTO equipos
VALUES 
	(1327689,'cubeta par impresion','2019-04-15',1)
    ,(1321321,'taladro dental','2019-05-21',5)
    ,(3183213,'pelicano dental','2019-07-01',4)
    ,(3213212,'mechero odontologico','2020-11-13',6)
    ,(5546546,'separador dental','2021-05-10',2)
    ,(6568546,'turbina','2022-08-03',2)
    ,(8465121,'aplicador amalgama','2019-08-10',3)
    ,(8561218,'abre bocas','2020-08-15',6)
;

INSERT INTO locales
VALUES 
	('﻿sonrisas brillantes','lizandro de la torre 450 - cba')
    ,('sonrisas cede centro','mercado de penaloza 4280 - cba'
);

INSERT INTO odontologos
VALUES 
	(23066,'leonardo davincci','38422658','1994-08-04','dentista general',
    '﻿sonrisas brillantes')
	,(23451,'manuel estrada','40126569','2000-01-10','encias',
    '﻿sonrisas brillantes')
    ,(23545,'facundo rossi','40512632','1993-05-22','cirujano oral',
    'sonrisas cede centro')
    ,(23657,'estelita mercedes','39456215','1995-09-14','ortodoncista',
    'sonrisas cede centro')
;


INSERT INTO pacientes
VALUES
	(null,'Sebastian Adrover','tokio 2020','38756213','1954-04-15','H','351-2156859')
    ,(null,'Maria Laura','tokio 2020','36544985','1998-07-15','M','3541-542356')
    ,(null,'Eikichi Onizuka','escuela n546','45213698','1985-07-27','H','3542-542353')
    ,(null,'Matias Adr','teniente portom 987','65233845','1981-11-10','H','351-2459233')
    ,(null,'Ippo Makunouchi','muelle 787','56244895','1986-03-30','H','354-5135463')
    ,(null,'Ash Ketchup','paleta 543','54546554','2012-03-22','H','3541-542354')
    ,(null,'Kenshin Himura','dojo kamilla 987','89544623','1999-12-11','H','351-5235412')
;


INSERT INTO tratamientos
VALUES
	(1,'blanqueamiento',3000,23066)
	,(2,'limpieza',1500,23657)
	,(3,'esmaltado',6000,23545)
	,(4,'extraccion de muela',12000,23451)
;


--                                     CREACION DE VISTAS


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

SELECT * v_cliente_tratamientos;


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

SELECT * v_edad_tipo_cliente;


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

SELECT * v_maquinas_ubicacion;

--                         ~    CREACION  DE  FUNCIONES    ~

-- funcion que permite calcular la cantidad de fechas que faltan para que un cliente tenga su turno o consulta odontologica. Solo se le debera pasar el id del paciente que queremos consultar devolviendo un valor positivo y mayor que cero en el caso de que la fecha del turno aun no se haya cumplido.
CREATE DEFINER=`root`@`localhost` FUNCTION `dias_turno`(id INT) RETURNS int
    DETERMINISTIC

BEGIN
	DECLARE fecha_turno timestamp;
  DECLARE result INT;
    
	SELECT fecha INTO fecha_turno
  FROM consultas
	WHERE id_paciente=id;

	SELECT timestampdiff(DAY, NOW(), fecha_turno) INTO result;
  RETURN result;
END


-- funcion capaz de calcular el precio total de un producto, incluyendo 3 argumentos. El primero es el precio del producto, el segundo el valor porcentual del impuestos a agregar(sin simbolo '%', ni ningun tipo de calculo adicional) y por ultimo el valor del descuento si es que posee uno(sin '%'), caso contrario se le debe pasar el valor de 0.

CREATE DEFINER=`root`@`localhost` FUNCTION `precio_total`(precio FLOAT,impuesto FLOAT,descuento FLOAT) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE total FLOAT;
    DECLARE precio_descuento FLOAT;

    SET total = precio + (precio * impuesto)/100;
    SET precio_descuento = total - (total * descuento)/100;
    
	RETURN precio_descuento;
END


--                         ~       STORED PROCEDURE          ~ 

-- El primer S.P.  permite indicar a través de un parámetro el campo de ordenamiento de una tabla y
-- mediante un segundo parámetro, si el orden es descendente o ascendente.


DELIMITER $$

CREATE PROCEDURE `sp_get_pacientes_order` (IN field VARCHAR(20), IN order_type VARCHAR(4))
BEGIN
	IF field <> '' THEN
		SET @response = CONCAT('SELECT * FROM adrover.pacientes ORDER BY ',field,' ', order_type);
	ELSE 
		SET @response = 'SELECT \'ERROR: Insertar parametro de ordenamiento\' AS Error';
	END IF;
    
    PREPARE querySQL FROM @response;
	EXECUTE querySQL;
    DEALLOCATE PREPARE querySQL;
END $$

DELIMITER ;



-- Este otro S.P. realiza lo siguiente -> 1: inserta registros en tabla pacientes. 2: eliminar algún registro
-- específico de la tabla pacientes tomando el id_paciente como parametro.)
DELIMITER $$

CREATE PROCEDURE sp_add_delete_data2(IN operation VARCHAR(6), IN dato VARCHAR(100))
BEGIN
	IF operation = 'add' THEN
		SET @resultado= CONCAT('INSERT INTO pacientes
			(nombre,domicilio,numero_documento,fecha_nacimiento,sexo,telefono)
			VALUES (',dato,');');
	ELSEIF operation = 'delete' THEN 
		SET @resultado = CONCAT('DELETE FROM pacientes WHERE id_paciente = ',dato,';');
	ELSEIF operation <> 'add' AND operation <> 'delete' THEN 
		SET @resultado = 'SELECT \'ERROR: Operaciones admitidas son "add" y "delete" \' AS Error';
	ELSE 
		SET @resultado = 'SELECT \'Ha ocurrido un error, verifica tu consulta e intenta nuevamente\' AS Error';
	END IF;
    
    PREPARE querySQL FROM  @resultado;
    EXECUTE querySQL;
    DEALLOCATE PREPARE querySQL;
    
END $$

DELIMITER ;

--                              ejemplos de como realizar las consultas usando la anterior sp 

-- CALL sp_add_delete_data('add','\'joaquin adr\',\'san juan 201\',\'42503856\',\'1999-08-09\',\'H\',\'3541226589\'');
-- CALL sp_add_delete_data('delete','8')
-- CALL sp_add_delete_data2('agreg','\'joaquin adr\',\'san juan 201\',\'42503856\',\'1999-08-09\',\'H\',\'3541226589\'')


--                         ~       TRIGGERS      ~

-- creacion de una tabla de registro "logs" el cual contendra la informacion de las eliminaciones y actizaciones realizadas sobre la tabla de pacientes 
CREATE TABLE logs(
	event_name CHAR(20),
  event_user VARCHAR(50),
  event_datetime TIMESTAMP,
	id_paciente INT,
  nombre VARCHAR(30),
  numero_documento VARCHAR(20)
);

-- 1 trigger que registra las eliminaciones de los pacientes 
CREATE TRIGGER tr_delete_paciente 
BEFORE DELETE ON pacientes
FOR EACH ROW
INSERT INTO logs(event_name,event_user,event_datetime,id_paciente,nombre,numero_documento)
VALUES('paciente eliminado',session_user(),current_timestamp(),OLD.id_paciente,OLD.nombre,OLD.numero_documento);


--2 trigger encargado de registrar las actualizaciones de la misma tabla 
CREATE TRIGGER tr_update_paciente
AFTER UPDATE ON pacientes
FOR EACH ROW
INSERT INTO logs(event_name,event_user,event_datetime,id_paciente,nombre,numero_documento)
VALUES('paciente actualizado',session_user(),current_timestamp(),OLD.id_paciente,OLD.nombre,OLD.numero_documento);


--                 ~      CREACION DE USUARIOS       ~      
CREATE USER 'user1'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';

CREATE USER 'user2'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';

--                  PERMISOS DE USUARIOS
--user1 -> permisos de solo lectura para user1
GRANT SELECT ON *.* TO 'user1'@'localhost';

--user2 -> permiso de lectura, insercion y midificacion de datos para user2
GRANT SELECT,INSERT,UPDATE ON *.* TO 'user2'@'localhost';

--                 ~      SUBLENGUAJE TCL      ~      
USE adrover;

START TRANSACTION;
	DELETE FROM adrover.pacientes WHERE id_paciente = 4;
	DELETE FROM adrover.pacientes WHERE id_paciente = 5;
	DELETE FROM adrover.pacientes WHERE id_paciente = 6;
-- ROLLBACK;
COMMIT;

-- Valores correspondientes a los id 4,5,6 en el caso de ser necesario reingresarlos 
-- INSERT INTO adrover.pacientes 
-- VALUES('4', 'Matias Adr', 'teniente portom 987', '65233845', '1981-11-10', 'H', '351-2459233')
-- 		,('5', 'Ippo Makunouchi', 'muelle 787', '56244895', '1986-03-30', 'H', '354-5135463')
-- 		,('6', 'Ash Ketchup', 'paleta 543', '54546554', '2012-03-22', 'H', '3541-542354');

START TRANSACTION;

	INSERT INTO adrover.odontologos 
    VALUES(NULL, 'leonardo tortuga', '38422789', '1995-08-04', 'dentista general', '﻿sonrisas brillantes')
		,(NULL,'juan domingo','40256985','1990-09-03','dentista encias','﻿sonrisas brillantes')
        ,(NULL,'homero simpsons','42568356','1980-02-22','patologo oral','sonrisas cede centro')
        ,(NULL,'jonhy depp','38526784','1994-02-07','patologo oral','sonrisas cede centro')
    ;
  
-- ROLLBACK;
SAVEPOINT primera_tanda;

INSERT INTO adrover.odontologos 
    VALUES(NULL, 'jesica marian', '40256365', '1997-11-04', 'dentista general', 'sonrisas brillantes')
		,(NULL,'maria del valle','25369852','1980-05-15','dentista encias','sonrisas brillantes')
        ,(NULL,'luisa vega','36987526','1979-01-12','patologo oral','sonrisas cede centro')
    ;
	
SAVEPOINT segunda_tanda;

-- para borrar primer savepoint, descomentar linea de abajo 
-- RELEASE primera_tanda;

-- en el caso de requerir regresar al estado del savepoint primera_tanda, descomentar la linea de abajo
-- ROLLBACK TO primera_tanda;

COMMIT;



--                         ~       BACKUP POR MEDIO DE CLI           ~ 
--COMANDOS 

-- backup de las estructuras de las tablas en la base de datos 
mysqldump -u root -p adrover --no-data > D:\sql-adrover-structure-20220928.sql

-- backup de la data
mysqldump -u root -p adrover --no-create-info > D:\sql-adrover-data-20220928.sql