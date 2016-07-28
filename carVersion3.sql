-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: carmanage
-- ------------------------------------------------------
-- Server version	5.7.12-log

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
-- Table structure for table `bus`
--

DROP TABLE IF EXISTS `bus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bus` (
  `busNo` int(11) NOT NULL,
  `branchNo` varchar(10) NOT NULL COMMENT '车牌号',
  `seat` int(11) NOT NULL COMMENT '车辆座位数',
  `registerdate` date NOT NULL COMMENT '车辆注册日期',
  `insurancedate` date NOT NULL COMMENT '车辆保险日期',
  `driverNo` varchar(30) NOT NULL COMMENT '驾驶员的驾驶证号码',
  `ownerNo` varchar(30) NOT NULL COMMENT '车辆所有者的号码',
  `types` varchar(30) NOT NULL,
  PRIMARY KEY (`busNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus`
--

LOCK TABLES `bus` WRITE;
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;
INSERT INTO `bus` VALUES (1,'2',9,'2016-07-13','2016-07-21','777','1','1'),(2,'2',30,'2015-07-02','2015-07-22','666','2','1'),(3,'2',30,'2015-07-02','2015-07-22','888','3','1'),(4,'2',30,'2015-07-02','2015-07-22','999','4','2'),(5,'2',30,'2015-07-02','2015-07-22','333','6','1'),(6,'2',30,'2015-07-02','2015-07-22','444','7','1'),(11,'11',11,'2016-07-12','2016-07-01','111','111','111');
/*!40000 ALTER TABLE `bus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bustaken`
--

DROP TABLE IF EXISTS `bustaken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bustaken` (
  `bustakenNo` int(11) NOT NULL COMMENT '考虑每天不同时间段的每辆车的实际上车情况，计算出相应的乘坐率',
  `btk_busNo` int(11) NOT NULL,
  `btk_bustimeNo` int(11) NOT NULL,
  `btk_date` date NOT NULL,
  `btk_routeNo` int(11) NOT NULL,
  `takennum` int(11) NOT NULL COMMENT '当天此次班车的实际上车人数',
  `btk_seat` int(11) NOT NULL,
  PRIMARY KEY (`bustakenNo`),
  UNIQUE KEY `bustakenNo_UNIQUE` (`bustakenNo`),
  KEY `btk_busNo_idx` (`btk_busNo`),
  KEY `btk_routeNo_idx` (`btk_routeNo`),
  KEY `btk_bustimeNo_idx` (`btk_bustimeNo`),
  CONSTRAINT `btk_busNo` FOREIGN KEY (`btk_busNo`) REFERENCES `bustime` (`bt_busNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `btk_bustimeNo` FOREIGN KEY (`btk_bustimeNo`) REFERENCES `bustime` (`bustimeNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `btk_routeNo` FOREIGN KEY (`btk_routeNo`) REFERENCES `bustime` (`bt_routeNo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bustaken`
--

LOCK TABLES `bustaken` WRITE;
/*!40000 ALTER TABLE `bustaken` DISABLE KEYS */;
/*!40000 ALTER TABLE `bustaken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bustime`
--

DROP TABLE IF EXISTS `bustime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bustime` (
  `bustimeNo` int(11) NOT NULL COMMENT '管理员手动输入的一个表，记录了每辆车在哪个时间段运行哪个线路，方便进行自动员工班车匹配',
  `bt_busNo` int(11) NOT NULL,
  `busgo` int(11) NOT NULL,
  `busoff` int(11) NOT NULL,
  `bt_routeNo` int(11) NOT NULL,
  `bt_driverNo` int(11) NOT NULL,
  `drivername` varchar(30) NOT NULL COMMENT '司机姓名',
  PRIMARY KEY (`bustimeNo`),
  UNIQUE KEY `bustimeNo_UNIQUE` (`bustimeNo`),
  KEY `bt_busNo_idx` (`bt_busNo`),
  KEY `bt_routeNo_idx` (`bt_routeNo`),
  CONSTRAINT `bt_busNo` FOREIGN KEY (`bt_busNo`) REFERENCES `bus` (`busNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bt_routeNo` FOREIGN KEY (`bt_routeNo`) REFERENCES `route` (`routeNo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bustime`
--

LOCK TABLES `bustime` WRITE;
/*!40000 ALTER TABLE `bustime` DISABLE KEYS */;
/*!40000 ALTER TABLE `bustime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobarrange`
--

DROP TABLE IF EXISTS `jobarrange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobarrange` (
  `ja_staffNo` int(11) NOT NULL COMMENT '员工班号',
  `timego` int(11) NOT NULL COMMENT '上班时间',
  `timeoff` int(11) NOT NULL COMMENT '下班时间',
  `ja_stopNo` int(11) NOT NULL COMMENT '员工上车的站点号',
  `ja_bustimeNo` int(11) NOT NULL COMMENT '员工被分配的乘车区间',
  `date` date NOT NULL,
  `iftaken` tinyint(1) NOT NULL COMMENT '员工是否按时乘车，本字段用于统计乘坐率',
  PRIMARY KEY (`ja_staffNo`),
  KEY `ja_bustime_idx` (`ja_bustimeNo`),
  KEY `ja_stopNo_idx` (`ja_stopNo`),
  CONSTRAINT `ja_bustimeNo` FOREIGN KEY (`ja_bustimeNo`) REFERENCES `bustime` (`bustimeNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ja_staffNo` FOREIGN KEY (`ja_staffNo`) REFERENCES `user` (`userNO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ja_stopNo` FOREIGN KEY (`ja_stopNo`) REFERENCES `stop` (`stopNo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobarrange`
--

LOCK TABLES `jobarrange` WRITE;
/*!40000 ALTER TABLE `jobarrange` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobarrange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opitable`
--

DROP TABLE IF EXISTS `opitable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opitable` (
  `routeNo` int(2) NOT NULL,
  `numOfStops` int(2) DEFAULT NULL,
  `startStop` int(2) DEFAULT NULL,
  PRIMARY KEY (`routeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opitable`
--

LOCK TABLES `opitable` WRITE;
/*!40000 ALTER TABLE `opitable` DISABLE KEYS */;
INSERT INTO `opitable` VALUES (1,5,3),(2,6,3),(3,6,3),(4,7,3);
/*!40000 ALTER TABLE `opitable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position` (
  `positionNo` int(11) NOT NULL AUTO_INCREMENT COMMENT '地图定位需要相应的坐标，添加地点表是因为，一个地点可能重复的成为不同线路上的不同站点，方便进行管理',
  `name` varchar(30) NOT NULL COMMENT '地点名字',
  `x` double NOT NULL COMMENT '地点x坐标',
  `y` double NOT NULL COMMENT '地点y坐标',
  PRIMARY KEY (`positionNo`),
  UNIQUE KEY `positionNo_UNIQUE` (`positionNo`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES (1,'温都金城',116.343746,39.946017),(2,'温都火城',118.363233,40.001),(3,'温度木城',115.770715,39.932458),(4,'温度水城',116.276086,39.753207),(5,'温度土城',116.277521,39.752997),(6,'明光桥站',115.556481,40.096535),(7,'杏坛路站',116.494091,40.120959),(8,'北师大站',116.774645,39.774277),(9,'铜锣湾站',117.027093,39.790673),(22,'',115.792687,39.748983);
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route` (
  `routeNo` int(11) NOT NULL COMMENT '记录所有线路信息',
  `name` varchar(30) NOT NULL COMMENT '线路的名字',
  `startstopNo` int(11) DEFAULT NULL COMMENT '始发站的号码',
  PRIMARY KEY (`routeNo`),
  UNIQUE KEY `routeNo_UNIQUE` (`routeNo`),
  KEY `startstopNo_idx` (`startstopNo`),
  CONSTRAINT `startstopNo` FOREIGN KEY (`startstopNo`) REFERENCES `stop` (`stopNo`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'快一',1),(2,'快二',11),(3,'快三',17),(4,'快四',21),(5,'快五',3);
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialtransaction`
--

DROP TABLE IF EXISTS `specialtransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specialtransaction` (
  `transactionNo` int(11) NOT NULL COMMENT '特殊事务的编号，因为使用复合主键的负责性，因此派生出这个字段进行标识',
  `timestart` date NOT NULL COMMENT '事件开始的时间',
  `timeend` date NOT NULL COMMENT '事件结束的时间',
  `st_busNo` int(11) NOT NULL COMMENT '事件所使用的班车号',
  `st_drivername` varchar(30) NOT NULL COMMENT '因为考虑到不一定是相应的司机驾驶这辆车，因此不设置外键',
  `manager` varchar(30) NOT NULL COMMENT '时间负责人姓名',
  `positionstart` varchar(30) NOT NULL COMMENT '事件发车地点',
  `positionend` varchar(30) NOT NULL COMMENT '事件目的地',
  `cost` int(11) NOT NULL COMMENT '事件花费的金额',
  `ifreturn` tinyint(1) NOT NULL COMMENT '用车是否涉及车辆往返',
  PRIMARY KEY (`transactionNo`),
  UNIQUE KEY `transactionNo_UNIQUE` (`transactionNo`),
  KEY `st_busNo_idx` (`st_busNo`),
  CONSTRAINT `st_busNo` FOREIGN KEY (`st_busNo`) REFERENCES `bus` (`busNo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialtransaction`
--

LOCK TABLES `specialtransaction` WRITE;
/*!40000 ALTER TABLE `specialtransaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `specialtransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stop`
--

DROP TABLE IF EXISTS `stop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stop` (
  `stopNo` int(11) NOT NULL COMMENT '记录所有站点信息，其中下一站站点在表中形成一个递归形式，相当于一个线路上所有站点的顺序链表',
  `s_routeNo` int(11) DEFAULT NULL COMMENT '站点所在的线路',
  `s_positionNo` int(11) DEFAULT NULL COMMENT '站点位置',
  `nextstopNo` int(11) DEFAULT NULL COMMENT '下一个站点号码',
  PRIMARY KEY (`stopNo`),
  UNIQUE KEY `stopNo_UNIQUE` (`stopNo`),
  KEY `s_position_idx` (`s_positionNo`),
  KEY `s_routeNo_idx` (`s_routeNo`),
  CONSTRAINT `s_positionNo` FOREIGN KEY (`s_positionNo`) REFERENCES `position` (`positionNo`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stop`
--

LOCK TABLES `stop` WRITE;
/*!40000 ALTER TABLE `stop` DISABLE KEYS */;
INSERT INTO `stop` VALUES (1,1,3,2),(2,1,4,3),(3,1,1,4),(4,1,2,5),(5,1,5,6),(6,1,6,7),(7,1,7,8),(8,1,8,9),(9,1,9,10),(10,5,1,11),(11,2,3,12),(12,2,5,13),(13,2,6,14),(14,2,8,15),(15,2,9,16),(16,5,3,17),(17,3,3,18),(18,3,4,19),(19,3,9,20),(20,5,3,21),(21,4,3,22),(22,4,1,23),(23,4,4,24),(24,4,6,25),(25,4,9,26),(26,4,2,27),(27,5,3,28);
/*!40000 ALTER TABLE `stop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userNO` int(11) NOT NULL COMMENT '使用系统的人员登录名称',
  `password` varchar(30) NOT NULL DEFAULT '666666' COMMENT '使用者的登录密码',
  `authorize` int(11) NOT NULL COMMENT '使用者的身份类型',
  `name` varchar(30) NOT NULL COMMENT '使用者的姓名，在这里面一般用于记录员工的姓名',
  `group` varchar(30) NOT NULL COMMENT '员工所属的小组',
  `department` varchar(30) NOT NULL COMMENT '员工所属的部门',
  `sex` char(1) NOT NULL,
  `homestation` int(11) DEFAULT NULL,
  `homeRoute` int(11) DEFAULT NULL,
  `islog` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`userNO`),
  UNIQUE KEY `userNo_UNIQUE` (`userNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'666',10,'moshaohua','av001','av001','M',1,1,1),(3,'666',9,'moshaohua','av001','av001','M',1,1,1),(5,'666',7,'moshaohua','av001','av001','M',1,1,0),(10,'666666',8,'ddd','sss','sss','M',1,1,0),(11,'666666',6,'asd','asd','asd','M',1,1,0),(12,'666666',10,'moshaohua','av001','av001','M',2,NULL,0),(13,'666666',9,'moshaohua','av001','av001','M',2,NULL,0),(14,'666666',1,'moshaohua','av001','av001','M',2,NULL,0),(15,'666666',9,'moshaohua','av001','av001','M',2,NULL,0),(16,'666666',8,'moshaohua','av001','av001','M',3,NULL,0),(17,'666666',7,'moshaohua','av001','av001','M',3,NULL,0),(18,'666666',5,'moshaohua','av001','av001','M',3,NULL,0),(19,'666666',4,'moshaohua','av001','av001','M',3,NULL,0),(20,'666666',10,'moshaohua','av001','av001','M',4,NULL,0),(21,'666666',9,'moshaohua','av001','av001','M',4,NULL,0),(22,'666666',1,'moshaohua','av001','av001','M',4,NULL,0),(23,'666666',9,'moshaohua','av001','av001','M',4,NULL,0),(24,'666666',8,'moshaohua','av001','av001','M',5,NULL,0),(25,'666666',7,'moshaohua','av001','av001','M',5,NULL,0),(26,'666666',5,'moshaohua','av001','av001','M',5,NULL,0),(27,'666666',4,'moshaohua','av001','av001','M',5,NULL,0),(28,'666666',10,'moshaohua','av001','av001','M',5,NULL,0),(29,'666666',9,'moshaohua','av001','av001','M',6,NULL,0),(30,'666666',1,'moshaohua','av001','av001','M',6,NULL,0),(31,'666666',9,'moshaohua','av001','av001','M',6,NULL,0),(32,'666666',8,'moshaohua','av001','av001','M',6,NULL,0),(33,'666666',7,'moshaohua','av001','av001','M',6,NULL,0),(36,'666666',10,'moshaohua','av001','av001','M',7,NULL,0),(37,'666666',9,'moshaohua','av001','av001','M',7,NULL,0),(38,'666666',1,'moshaohua','av001','av001','M',7,NULL,0),(39,'666666',9,'moshaohua','av001','av001','M',8,NULL,0),(40,'666666',8,'moshaohua','av001','av001','M',8,NULL,0),(41,'666666',7,'moshaohua','av001','av001','M',8,NULL,0),(42,'666666',5,'moshaohua','av001','av001','M',8,NULL,0),(43,'666666',4,'moshaohua','av001','av001','M',8,NULL,0),(44,'666666',10,'moshaohua','av001','av001','M',8,NULL,0),(45,'666666',9,'moshaohua','av001','av001','M',8,NULL,0),(46,'666666',1,'moshaohua','av001','av001','M',8,NULL,0),(47,'666666',9,'moshaohua','av001','av001','M',8,NULL,0),(48,'666666',8,'moshaohua','av001','av001','M',9,NULL,0),(49,'666666',7,'moshaohua','av001','av001','M',9,NULL,0),(50,'666666',5,'moshaohua','av001','av001','M',9,NULL,0),(51,'666666',4,'moshaohua','av001','av001','M',9,NULL,0),(52,'666666',10,'moshaohua','av001','av001','M',9,NULL,0),(53,'666666',9,'moshaohua','av001','av001','M',9,NULL,0),(54,'666666',1,'moshaohua','av001','av001','M',9,NULL,0),(55,'666666',9,'moshaohua','av001','av001','M',9,NULL,0),(56,'666666',8,'moshaohua','av001','av001','M',9,NULL,0),(57,'666666',7,'moshaohua','av001','av001','M',9,NULL,0),(58,'666666',5,'moshaohua','av001','av001','M',9,NULL,0),(59,'666666',4,'moshaohua','av001','av001','M',9,NULL,0),(60,'666666',10,'moshaohua','av001','av001','M',9,NULL,0),(61,'666666',9,'moshaohua','av001','av001','M',9,NULL,0),(62,'666666',1,'moshaohua','av001','av001','M',9,NULL,0),(63,'666666',9,'moshaohua','av001','av001','M',9,NULL,0),(64,'666666',8,'moshaohua','av001','av001','M',9,NULL,0),(65,'666666',7,'moshaohua','av001','av001','M',9,NULL,0),(66,'666666',5,'moshaohua','av001','av001','M',9,NULL,0),(67,'666666',4,'moshaohua','av001','av001','M',9,NULL,0),(68,'666666',10,'moshaohua','av001','av001','M',9,NULL,0),(69,'666666',9,'moshaohua','av001','av001','M',9,NULL,0),(70,'666666',1,'moshaohua','av001','av001','M',9,NULL,0),(71,'666666',9,'moshaohua','av001','av001','M',9,NULL,0),(72,'666666',8,'moshaohua','av001','av001','M',9,NULL,0),(73,'666666',7,'moshaohua','av001','av001','M',9,NULL,0),(74,'666666',5,'moshaohua','av001','av001','M',9,NULL,0),(75,'666666',4,'moshaohua','av001','av001','M',9,NULL,0),(77,'666666',9,'chenjie','1','1','M',9,1,0),(78,'666666',9,'chenjie','1','1','M',9,1,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-28 11:44:56
