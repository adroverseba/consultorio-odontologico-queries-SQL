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
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (2,'2022-06-22 15:30:00',7,23657,2),(3,'2022-07-15 15:45:00',1,23545,3),(5,'2022-09-10 15:00:00',3,23066,NULL),(6,'2022-09-13 11:00:00',5,23451,NULL);
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `consultorios`
--

LOCK TABLES `consultorios` WRITE;
/*!40000 ALTER TABLE `consultorios` DISABLE KEYS */;
INSERT INTO `consultorios` VALUES (1,'sonrisas brillantes'),(2,'sonrisas brillantes'),(3,'sonrisas brillantes'),(4,'sonrisas brillantes'),(5,'sonrisas cede centro'),(6,'sonrisas cede centro');
/*!40000 ALTER TABLE `consultorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1321321,'taladro dental','2019-05-21',5),(1327689,'cubeta par impresion','2019-04-15',1),(3183213,'pelicano dental','2019-07-01',4),(3213212,'mechero odontologico','2020-11-13',6),(5546546,'separador dental','2021-05-10',2),(6568546,'turbina','2022-08-03',2),(8465121,'aplicador amalgama','2019-08-10',3),(8561218,'abre bocas','2020-08-15',6);
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `locales`
--

LOCK TABLES `locales` WRITE;
/*!40000 ALTER TABLE `locales` DISABLE KEYS */;
INSERT INTO `locales` VALUES ('﻿sonrisas brillantes','lizandro de la torre 450 - cba'),('sonrisas cede centro','mercado de penaloza 4280 - cba');
/*!40000 ALTER TABLE `locales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES ('paciente eliminado','root@localhost','2022-09-15 00:13:42',2,'Maria Laura','36544985'),('paciente actualizado','root@localhost','2022-09-15 00:27:50',7,'Kenshin Himura','89544623'),('paciente eliminado','root@localhost','2022-09-26 20:11:25',4,'Matias Adr','65233845');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `odontologos`
--

LOCK TABLES `odontologos` WRITE;
/*!40000 ALTER TABLE `odontologos` DISABLE KEYS */;
INSERT INTO `odontologos` VALUES (23066,'leonardo davincci','38422658','1994-08-04','dentista general','﻿sonrisas brillantes'),(23451,'manuel estrada','40126569','2000-01-10','encias','﻿sonrisas brillantes'),(23545,'facundo rossi','40512632','1993-05-22','cirujano oral','sonrisas cede centro'),(23657,'estelita mercedes','39456215','1995-09-14','ortodoncista','sonrisas cede centro');
/*!40000 ALTER TABLE `odontologos` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tratamientos`
--

LOCK TABLES `tratamientos` WRITE;
/*!40000 ALTER TABLE `tratamientos` DISABLE KEYS */;
INSERT INTO `tratamientos` VALUES (1,'blanqueamiento',3000.00,23066),(2,'limpieza',1500.00,23657),(3,'esmaltado',6000.00,23545),(4,'extraccion de muela',12000.00,23451);
/*!40000 ALTER TABLE `tratamientos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-28 13:02:35
