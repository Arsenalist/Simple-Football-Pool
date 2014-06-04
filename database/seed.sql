-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: footballpool
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.12.04.1

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
-- Table structure for table `entrants`
--

DROP TABLE IF EXISTS `entrants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrants`
--

LOCK TABLES `entrants` WRITE;
/*!40000 ALTER TABLE `entrants` DISABLE KEYS */;
INSERT INTO `entrants` VALUES (1,'Zarar'),(2,'Mariusz');
/*!40000 ALTER TABLE `entrants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `entrant_id` int(11) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  `home_score` int(3) DEFAULT NULL,
  `away_score` int(3) DEFAULT NULL,
  KEY `game_id` (`game_id`),
  KEY `entrant_id` (`entrant_id`),
  CONSTRAINT `entries_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`),
  CONSTRAINT `entries_ibfk_2` FOREIGN KEY (`entrant_id`) REFERENCES `entrants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` VALUES (1,1,2,2),(1,2,1,2),(1,3,1,0);
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `home_team` char(3) DEFAULT NULL,
  `away_team` char(3) DEFAULT NULL,
  `home_score` int(3) DEFAULT NULL,
  `away_score` int(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,'BRA','CRO',1,1),(2,'MEX','CMR',1,1),(3,'ESP','NED',1,1),(4,'CHI','AUS',1,1),(5,'COL','GRE',1,1),(6,'URU','CRC',1,1),(7,'ENG','ITA',1,1),(8,'CIV','JPN',1,1),(9,'SUI','ECU',1,1),(10,'FRA','HON',1,1),(11,'ARG','BIH',1,1),(12,'GER','POR',1,1),(13,'IRN','NGA',1,1),(14,'GHA','USA',1,1),(15,'BEL','ALG',1,1),(16,'BRA','MEX',1,1),(17,'RUS','KOR',1,1),(18,'AUS','NED',1,1),(19,'ESP','CHI',1,1),(20,'CMR','CRO',1,1),(21,'COL','CIV',1,1),(22,'URU','ENG',1,1),(23,'JPN','GRE',1,1),(24,'ITA','CRC',1,1),(25,'SUI','FRA',1,1),(26,'HON','ECU',1,1),(27,'ARG','IRN',1,1),(28,'GER','GHA',1,1),(29,'NGA','BIH',1,1),(30,'BEL','RUS',1,1),(31,'KOR','ALG',1,1),(32,'USA','POR',1,1),(33,'AUS','ESP',1,1),(34,'NED','CHI',1,1),(35,'CMR','BRA',1,1),(36,'CRO','MEX',1,1),(37,'ITA','URU',1,1),(38,'ENG','CRC',1,1),(39,'JPN','COL',1,1),(40,'CIV','GRE',1,1),(41,'BIH','IRN',1,1),(42,'NGA','ARG',1,1),(43,'HON','SUI',1,1),(44,'ECU','FRA',1,1),(45,'USA','GER',1,1),(46,'POR','GHA',1,1),(47,'KOR','BEL',1,1),(48,'ALG','RUS',1,1);
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-04 14:34:05
