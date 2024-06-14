-- MySQl Distrib 8.0.19, for Win64 (x86_64)
-- Database: db_asia
-- Server version	5.5.5-10.6.16-MariaDB-0ubuntu0.22.04.1

--
-- Table structure for table `Anagrafica`
--

DROP TABLE IF EXISTS `Anagrafica`;
CREATE TABLE `Anagrafica` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(100) NOT NULL,
  `COGNOME` varchar(100) NOT NULL,
  `SESSO` enum('F','M') NOT NULL,
  `NASCITA` date NOT NULL,
  `CODICE_FISCALE` varchar(16) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Anagrafica`
--

LOCK TABLES `Anagrafica` WRITE;
INSERT INTO `Anagrafica` VALUES (1,'Mario','Rossi','M','1999-04-30','1111111111111111'),(2,'Sofia','Nenni','F','2002-06-04','1111111111111112'),(3,'Cosimo','Rossi','F','2005-06-06','1111111111111113'),(4,'mirko','gfdgsd','M','2002-02-22','UWBUIOABRUW'),(6,'Tommaso','Del Grazia','M','1988-12-05','UWBUIOABRUW'),(16,'matteo','fdafs','M','2024-06-29','QWERTY00Q00Q000Q'),(17,'matteo','fsdfsfs','M','2024-05-30','QWERTY00Q00Q000Q'),(18,'matteo','gfdgsd','M','2024-05-30','QWERTY00Q00Q000Q'),(22,'Laura','fdsfsf','M','2024-05-28','QWERTY00Q00Q000Q'),(23,'asdfasdf','fdsfsf','F','2024-06-04','QWERTY00Q00Q000Q'),(24,'Laura','Tamburello','F','2004-08-24','QWERTY00Q00Q000Q');
UNLOCK TABLES;

--
-- Table structure for table `Login`
--

DROP TABLE IF EXISTS `Login`;
CREATE TABLE `Login` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_ACCESSO` datetime NOT NULL,
  `ID_USER` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Login_Utenti_FK` (`ID_USER`),
  CONSTRAINT `Login_Utenti_FK` FOREIGN KEY (`ID_USER`) REFERENCES `Utenti` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Login`
--

LOCK TABLES `Login` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `Utenti`
--

DROP TABLE IF EXISTS `Utenti`;
CREATE TABLE `Utenti` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(100) NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `PASSWORD` varchar(512) NOT NULL,
  `ID_ANAGRAFICA` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Utenti_UNIQUE` (`EMAIL`),
  KEY `Utenti_Anagrafica_FK` (`ID_ANAGRAFICA`),
  CONSTRAINT `Utenti_Anagrafica_FK` FOREIGN KEY (`ID_ANAGRAFICA`) REFERENCES `Anagrafica` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Utenti`
--

LOCK TABLES `Utenti` WRITE;
INSERT INTO `Utenti` VALUES (1,'Mario432','mario@gmail.com','JDKB38429h982GHO',1),(2,'Sofyyy','sofia@gmail.com','verhaousfoepaJUBFOQA',2),(3,'RosCos','cosimo@gmail.com','pr9qeyn8935938jù',3),(4,'prova','miao@gmail.com','0c9cf6dc9d6db94ed4d80524b2747a3bd0afa3089022d52bf6b3d225a42997ef',4),(5,'Tommy','Tommy@gmail.com','c17a1459af9d3c0c3a03d1423f6a8182e27dd9cecf12cd3597cff5d2fc2dbf04',6),(12,'prova','miao4@gmail.com','03d6eaf8e1ccd837dff677bbed496cccb49502ad49eaea49d06714e34bbec010',16),(13,'prova','miaoa@gmail.com','03d6eaf8e1ccd837dff677bbed496cccb49502ad49eaea49d06714e34bbec010',17),(14,'prova','emiao@gmail.com','03d6eaf8e1ccd837dff677bbed496cccb49502ad49eaea49d06714e34bbec010',18),(15,'Stage','fusiasiaandrea@gmail.com','3007673112cda0064a53671db5dc11df9b45b5a323c5f210e77cd4a2c038f567',22),(16,'Tommy','m6iao@gmail.com','3007673112cda0064a53671db5dc11df9b45b5a323c5f210e77cd4a2c038f567',23),(17,'Patatina','patata@hotmail.com','c0e498464b51ce989b9c406ca35aff2f6a17ed97c6eef712a12807ac264abf7c',24);
UNLOCK TABLES;

--
-- Table structure for table `Utenti_Videogiochi`
--

DROP TABLE IF EXISTS `Utenti_Videogiochi`;
CREATE TABLE `Utenti_Videogiochi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_UTENTE` int(11) DEFAULT NULL,
  `ID_VIDEOGIOCO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Giocati_Videogiochi_FK` (`ID_VIDEOGIOCO`),
  KEY `Giocati_Utenti_FK` (`ID_UTENTE`),
  CONSTRAINT `Giocati_Utenti_FK` FOREIGN KEY (`ID_UTENTE`) REFERENCES `Utenti` (`ID`),
  CONSTRAINT `Giocati_Videogiochi_FK` FOREIGN KEY (`ID_VIDEOGIOCO`) REFERENCES `Videogiochi` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Utenti_Videogiochi`
--

LOCK TABLES `Utenti_Videogiochi` WRITE;
INSERT INTO `Utenti_Videogiochi` VALUES (1,4,1),(2,4,4),(3,4,5),(4,5,21),(5,5,4),(6,5,20),(7,12,12),(8,5,3),(9,12,5),(10,12,7),(11,13,9),(12,13,2),(14,13,4),(40,4,56);
UNLOCK TABLES;

--
-- Table structure for table `Videogiochi`
--

DROP TABLE IF EXISTS `Videogiochi`;
CREATE TABLE `Videogiochi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITOLO` varchar(100) DEFAULT NULL,
  `GENERE` varchar(100) DEFAULT NULL,
  `DATA_RILASCIO` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Videogiochi`
--

LOCK TABLES `Videogiochi` WRITE;
INSERT INTO `Videogiochi` VALUES (1,'Dark Souls','Soulslike','2011-09-22'),(2,'Dark Souls 2','Soulslike','2014-03-11'),(3,'Dark Souls 3','Soulslike','2016-03-26'),(4,'The Last Of Us','Action-Adventure','2013-06-14'),(5,'The Last Of Us 2','Action-Adventure','2020-06-19'),(6,'Call of Duty','FPS','2003-10-29'),(7,'Call of Duty 2','FPS','2005-10-25'),(8,'Call of Duty 3','FPS','2006-11-07'),(9,'Call of Duty 4: Modern Warfare','FPS','2007-11-06'),(10,'Call of Duty: World at War','FPS','2008-11-11'),(11,'Call of Duty: Modern Warfare 2','FPS','2009-11-10'),(12,'Call of Duty: Black Ops','FPS','2010-11-09'),(13,'Call of Duty: Modern Warfare 3','FPS','2011-11-08'),(14,'Call of Duty: Black Ops 2','FPS','2012-11-12'),(15,'Call of Duty: Ghosts','FPS','2013-11-05'),(16,'Call of Duty: Advanced Warfare','FPS','2014-11-03'),(18,'Call of Duty: Black Ops 3','FPS','2015-11-06'),(19,'Call of Duty: Infinite Warfare','FPS','2016-11-04'),(20,'Call of Duty: World War II','FPS','2017-11-03'),(21,'Call of Duty: Black Ops 4 and Blackout','FPS','2018-10-12'),(22,'Call of Duty: Mobile','FPS','2019-10-01'),(23,'Call of Duty: Modern Warfare','FPS','2019-10-25'),(24,'Call of Duty: Warzone','FPS','2020-03-10'),(25,'Call of Duty: Black Ops Cold War','FPS','2020-11-13'),(26,'Call of Duty: Vanguard','FPS','2021-11-05'),(27,'Call of Duty: Modern Warfare 2','FPS','2022-10-25'),(28,'Call of Duty: Warzone 2.0 and DMZ','FPS','2022-11-16'),(29,'Call of Duty: Modern Warfare 3','FPS','2023-11-10'),(30,'Call of Duty: Warzone Mobile','FPS','2024-03-21'),(56,'BALDURS GATE','rpg','2024-05-27');
UNLOCK TABLES;
