-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: adrover
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultas` (
  `id_consulta` int NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL,
  `id_paciente` int NOT NULL,
  `legajo` int DEFAULT NULL,
  `id_tratamiento` int DEFAULT NULL,
  PRIMARY KEY (`id_consulta`),
  UNIQUE KEY `id_consulta` (`id_consulta`),
  KEY `id_paciente` (`id_paciente`),
  KEY `legajo` (`legajo`),
  KEY `id_tratamiento` (`id_tratamiento`),
  CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `consultas_ibfk_2` FOREIGN KEY (`legajo`) REFERENCES `odontologos` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `consultas_ibfk_3` FOREIGN KEY (`id_tratamiento`) REFERENCES `tratamientos` (`id_tratamiento`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consultorios`
--

DROP TABLE IF EXISTS `consultorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultorios` (
  `numero_consultorio` int NOT NULL,
  `nombre_local` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`numero_consultorio`),
  KEY `nombre_local` (`nombre_local`),
  CONSTRAINT `consultorios_ibfk_1` FOREIGN KEY (`nombre_local`) REFERENCES `locales` (`nombre_local`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `num_serie` int NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `fecha_mantenimiento` date DEFAULT NULL,
  `numero_consultorio` int DEFAULT NULL,
  PRIMARY KEY (`num_serie`),
  UNIQUE KEY `num_serie` (`num_serie`),
  KEY `numero_consultorio` (`numero_consultorio`),
  CONSTRAINT `equipos_ibfk_1` FOREIGN KEY (`numero_consultorio`) REFERENCES `consultorios` (`numero_consultorio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales`
--

DROP TABLE IF EXISTS `locales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locales` (
  `nombre_local` varchar(20) NOT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nombre_local`),
  UNIQUE KEY `nombre_local` (`nombre_local`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `event_name` char(20) DEFAULT NULL,
  `event_user` varchar(50) DEFAULT NULL,
  `event_datetime` timestamp NULL DEFAULT NULL,
  `id_paciente` int DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `numero_documento` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `odontologos`
--

DROP TABLE IF EXISTS `odontologos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `odontologos` (
  `legajo` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(50) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `especialidad` varchar(20) DEFAULT NULL,
  `nombre_local` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`legajo`),
  UNIQUE KEY `legajo` (`legajo`),
  KEY `nombre_local` (`nombre_local`),
  CONSTRAINT `odontologos_ibfk_1` FOREIGN KEY (`nombre_local`) REFERENCES `locales` (`nombre_local`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23659 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pacientes`
--

DROP TABLE IF EXISTS `pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pacientes` (
  `id_paciente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `domicilio` varchar(50) NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `sexo` char(1) DEFAULT NULL,
  `telefono` varchar(11) NOT NULL,
  PRIMARY KEY (`id_paciente`),
  UNIQUE KEY `id_paciente` (`id_paciente`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_update_paciente` AFTER UPDATE ON `pacientes` FOR EACH ROW INSERT INTO logs(event_name,event_user,event_datetime,id_paciente,nombre,numero_documento)
VALUES('paciente actualizado',session_user(),current_timestamp(),OLD.id_paciente,OLD.nombre,OLD.numero_documento) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_delete_paciente` BEFORE DELETE ON `pacientes` FOR EACH ROW INSERT INTO logs(event_name,event_user,event_datetime,id_paciente,nombre,numero_documento)
VALUES('paciente eliminado',session_user(),current_timestamp(),OLD.id_paciente,OLD.nombre,OLD.numero_documento) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tratamientos`
--

DROP TABLE IF EXISTS `tratamientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamientos` (
  `id_tratamiento` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `costo` decimal(9,2) DEFAULT '0.00',
  `legajo` int DEFAULT NULL,
  PRIMARY KEY (`id_tratamiento`),
  UNIQUE KEY `id_tratamiento` (`id_tratamiento`),
  KEY `legajo` (`legajo`),
  CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`legajo`) REFERENCES `odontologos` (`legajo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `v_cliente_tratamientos`
--

DROP TABLE IF EXISTS `v_cliente_tratamientos`;
/*!50001 DROP VIEW IF EXISTS `v_cliente_tratamientos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_cliente_tratamientos` AS SELECT 
 1 AS `id_tratamiento`,
 1 AS `tratamiento`,
 1 AS `costo`,
 1 AS `odontologo_legajo`,
 1 AS `paciente`,
 1 AS `telefono`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_costo_tratamientos`
--

DROP TABLE IF EXISTS `v_costo_tratamientos`;
/*!50001 DROP VIEW IF EXISTS `v_costo_tratamientos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_costo_tratamientos` AS SELECT 
 1 AS `id_tratamiento`,
 1 AS `nombre`,
 1 AS `costo`,
 1 AS `legajo`,
 1 AS `IVA`,
 1 AS `TOTAL`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_edad_tipo_cliente`
--

DROP TABLE IF EXISTS `v_edad_tipo_cliente`;
/*!50001 DROP VIEW IF EXISTS `v_edad_tipo_cliente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_edad_tipo_cliente` AS SELECT 
 1 AS `id_paciente`,
 1 AS `nombre`,
 1 AS `domicilio`,
 1 AS `numero_documento`,
 1 AS `fecha_nacimiento`,
 1 AS `sexo`,
 1 AS `telefono`,
 1 AS `edad`,
 1 AS `tipo_cliente`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_fecha_mantenimiento_viejas`
--

DROP TABLE IF EXISTS `v_fecha_mantenimiento_viejas`;
/*!50001 DROP VIEW IF EXISTS `v_fecha_mantenimiento_viejas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_fecha_mantenimiento_viejas` AS SELECT 
 1 AS `num_serie`,
 1 AS `tipo`,
 1 AS `fecha_mantenimiento`,
 1 AS `numero_consultorio`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_cliente_tratamientos`
--

/*!50001 DROP VIEW IF EXISTS `v_cliente_tratamientos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_cliente_tratamientos` AS select `t`.`id_tratamiento` AS `id_tratamiento`,`t`.`nombre` AS `tratamiento`,`t`.`costo` AS `costo`,`t`.`legajo` AS `odontologo_legajo`,`a`.`nombre` AS `paciente`,`a`.`telefono` AS `telefono` from (`tratamientos` `t` join (select `p`.`nombre` AS `nombre`,`p`.`telefono` AS `telefono`,`c`.`id_tratamiento` AS `id_tratamiento` from (`consultas` `c` join `pacientes` `p` on((`c`.`id_paciente` = `p`.`id_paciente`)))) `a` on((`t`.`id_tratamiento` = `a`.`id_tratamiento`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_costo_tratamientos`
--

/*!50001 DROP VIEW IF EXISTS `v_costo_tratamientos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_costo_tratamientos` AS select `tratamientos`.`id_tratamiento` AS `id_tratamiento`,`tratamientos`.`nombre` AS `nombre`,`tratamientos`.`costo` AS `costo`,`tratamientos`.`legajo` AS `legajo`,round((`tratamientos`.`costo` * 0.21),2) AS `IVA`,sum((round((`tratamientos`.`costo` * 0.21),2) + `tratamientos`.`costo`)) AS `TOTAL` from `tratamientos` group by `tratamientos`.`id_tratamiento` order by `tratamientos`.`costo` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_edad_tipo_cliente`
--

/*!50001 DROP VIEW IF EXISTS `v_edad_tipo_cliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_edad_tipo_cliente` AS select `p`.`id_paciente` AS `id_paciente`,`p`.`nombre` AS `nombre`,`p`.`domicilio` AS `domicilio`,`p`.`numero_documento` AS `numero_documento`,`p`.`fecha_nacimiento` AS `fecha_nacimiento`,`p`.`sexo` AS `sexo`,`p`.`telefono` AS `telefono`,round(((to_days(now()) - to_days(`p`.`fecha_nacimiento`)) / 365),0) AS `edad`,(case when (round(((to_days(now()) - to_days(`p`.`fecha_nacimiento`)) / 365),0) > 50) then 'Adulto Mayor' when (round(((to_days(now()) - to_days(`p`.`fecha_nacimiento`)) / 365),0) >= 18) then 'Adulto' else 'Infantes' end) AS `tipo_cliente` from `pacientes` `p` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_fecha_mantenimiento_viejas`
--

/*!50001 DROP VIEW IF EXISTS `v_fecha_mantenimiento_viejas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_fecha_mantenimiento_viejas` AS select `equipos`.`num_serie` AS `num_serie`,`equipos`.`tipo` AS `tipo`,`equipos`.`fecha_mantenimiento` AS `fecha_mantenimiento`,`equipos`.`numero_consultorio` AS `numero_consultorio` from `equipos` where ((to_days(now()) - to_days(`equipos`.`fecha_mantenimiento`)) > 365) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-28 12:59:52
