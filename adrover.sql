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