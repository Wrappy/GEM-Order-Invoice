CREATE DATABASE  IF NOT EXISTS `4fd3` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `4fd3`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: localhost    Database: 4fd3
-- ------------------------------------------------------
-- Server version	5.1.65-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `quoteinfo`
--

DROP TABLE IF EXISTS `quoteinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quoteinfo` (
  `quoteinfoid` varchar(45) NOT NULL,
  `quote` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `description` varchar(450) DEFAULT NULL,
  `quantity` double DEFAULT '0',
  `price` double DEFAULT '0',
  `unit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`quoteinfoid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quoteinfo`
--

LOCK TABLES `quoteinfo` WRITE;
/*!40000 ALTER TABLE `quoteinfo` DISABLE KEYS */;
INSERT INTO `quoteinfo` VALUES ('1','1','CSE01_1','On Site Work',6,10.5,'hr'),('10','1','CSE01_5','Misc 3',2,10,'Random 3'),('2','1','CSE01_2','Servers',2,200,'server'),('3','1','CSE01_3','Misc',1,10,'random'),('4','1','CSE01_4','Misc 2',2.25,1.75,'random 2'),('5','2','CSE02_1','TEST',10,10,'RANDOM'),('6','2','CSE02_2','TEST',10,10,'RANDOM'),('7','3','CSE03_1','TEST',10,10,'random'),('8','4','CSE022_1','TEST',1,10,'RANDOM'),('9','5','CSE041','TEST',8,8,'TEST');
/*!40000 ALTER TABLE `quoteinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-15 16:04:29
