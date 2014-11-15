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
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `clientID` varchar(45) NOT NULL,
  `clientname` varchar(45) DEFAULT NULL,
  `contactperson` varchar(45) DEFAULT NULL,
  `contacttitle` varchar(45) DEFAULT NULL,
  `address1` varchar(45) DEFAULT NULL,
  `address2` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `prov` varchar(45) DEFAULT NULL,
  `postal` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `web` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `rep` varchar(45) DEFAULT NULL,
  `tech` varchar(45) DEFAULT NULL,
  `followupdate` varchar(45) DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `notes` longtext,
  `active` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`clientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES ('CSE01','AComputer Support Experts Inc','Blake Heald','Owner','2133 Royal Windsor Drive','Unit 2','Mississauga','ON','L5J 1K5','9058550533','9058552752','http://www.cse.ca','gordcoyle86@gmail.com','GC','GC','20141231',30.85,'Notes Go Here','true'),('CSE02','BComputer Support Experts Inc2','Blake Heald','Owner','2133 Royal Windsor Drive','Unit 2','Mississauga','ON','L5J 1K5','9058550533','9058552752','http://www.cse.ca','gordcoyle86@gmail.com','GC','GC','20141230',20.27,'Some Notes','true'),('CSE03','CComputer Support Experts Inc3','Blake Heald','Owner','5600 Finch Avenue East','Unit 2','Mississauga','ON','L5J 1K5','9058550533','9058552752','http://www.cse.ca','gordcoyle86@gmail.com','ML','ES','20141220',30.75,'Who Needs Notes','false'),('CSE04','DComputer Support Experts Inc4','Blake Heald','Owner','5600 Finch Avenue East','Unit 2','Mississauga','ON','L5J 1K5','9058550533','9058552752','http://www.cse.ca','gordcoyle86@gmail.com','ML','ES','20141228',50.67,'DASFJKHASJKLGO','true'),('CSE05','EComputer Support Experts Inc','Blake Heald','Owner','2133 Royal Windsor Drive','Unit 2','Mississauga','ON','L5J 1K5','9058550533','9058552752','http://www.cse.ca','gordcoyle86@gmail.com','ML','ES','20141223',54.86,'asuidasodiuy','true');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
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
