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
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (2,'2022-06-22 15:30:00',7,23657,2),(3,'2022-07-15 15:45:00',1,23545,3),(5,'2022-09-10 15:00:00',3,23066,NULL),(6,'2022-09-13 11:00:00',5,23451,NULL);
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `consultorios`
--

LOCK TABLES `consultorios` WRITE;
/*!40000 ALTER TABLE `consultorios` DISABLE KEYS */;
INSERT INTO `consultorios` VALUES (1,'sonrisas brillantes'),(2,'sonrisas brillantes'),(3,'sonrisas brillantes'),(4,'sonrisas brillantes'),(5,'sonrisas cede centro'),(6,'sonrisas cede centro');
/*!40000 ALTER TABLE `consultorios` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1321321,'taladro dental','2019-05-21',5),(1327689,'cubeta par impresion','2019-04-15',1),(3183213,'pelicano dental','2019-07-01',4),(3213212,'mechero odontologico','2020-11-13',6),(5546546,'separador dental','2021-05-10',2),(6568546,'turbina','2022-08-03',2),(8465121,'aplicador amalgama','2019-08-10',3),(8561218,'abre bocas','2020-08-15',6);
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `locales`
--

LOCK TABLES `locales` WRITE;
/*!40000 ALTER TABLE `locales` DISABLE KEYS */;
INSERT INTO `locales` VALUES ('﻿sonrisas brillantes','lizandro de la torre 450 - cba'),('sonrisas cede centro','mercado de penaloza 4280 - cba');
/*!40000 ALTER TABLE `locales` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES ('paciente eliminado','root@localhost','2022-09-15 00:13:42',2,'Maria Laura','36544985'),('paciente actualizado','root@localhost','2022-09-15 00:27:50',7,'Kenshin Himura','89544623'),('paciente eliminado','root@localhost','2022-09-26 20:11:25',4,'Matias Adr','65233845');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `odontologos`
--

LOCK TABLES `odontologos` WRITE;
/*!40000 ALTER TABLE `odontologos` DISABLE KEYS */;
INSERT INTO `odontologos` VALUES (23066,'leonardo davincci','38422658','1994-08-04','dentista general','﻿sonrisas brillantes'),(23451,'manuel estrada','40126569','2000-01-10','encias','﻿sonrisas brillantes'),(23545,'facundo rossi','40512632','1993-05-22','cirujano oral','sonrisas cede centro'),(23657,'estelita mercedes','39456215','1995-09-14','ortodoncista','sonrisas cede centro');
/*!40000 ALTER TABLE `odontologos` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES (1,'Sebastian Adrover','tokio 2020','38756213','1954-04-15','H','351-2156859'),(3,'Eikichi Onizuka','escuela n546','45213698','1985-07-27','H','3542-542353'),(4,'Matias Adr','teniente portom 987','65233845','1981-11-10','H','351-2459233'),(5,'Ippo Makunouchi','muelle 787','56244895','1986-03-30','H','354-5135463'),(6,'Ash Ketchup','paleta 543','54546554','2012-03-22','H','3541-542354'),(7,'Kenshin Himura - Battousai','dojo kamilla 987','89544623','1999-12-11','H','351-5235412');
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `tratamientos`
--

LOCK TABLES `tratamientos` WRITE;
/*!40000 ALTER TABLE `tratamientos` DISABLE KEYS */;
INSERT INTO `tratamientos` VALUES (1,'blanqueamiento',3000.00,23066),(2,'limpieza',1500.00,23657),(3,'esmaltado',6000.00,23545),(4,'extraccion de muela',12000.00,23451);
/*!40000 ALTER TABLE `tratamientos` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2022-09-27 18:30:36
