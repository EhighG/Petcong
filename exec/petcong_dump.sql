-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: i10a603.p.ssafy.io    Database: petcongdb
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Matching`
--

DROP TABLE IF EXISTS `Matching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Matching` (
  `matching_id` int NOT NULL AUTO_INCREMENT,
  `from_member_id` int NOT NULL,
  `to_member_id` int NOT NULL,
  `call_status` enum('PENDING','MATCHED','REJECTED') DEFAULT NULL,
  PRIMARY KEY (`matching_id`),
  KEY `from_user_id` (`from_member_id`),
  KEY `to_user_id` (`to_member_id`),
  CONSTRAINT `Matching_ibfk_1` FOREIGN KEY (`from_member_id`) REFERENCES `Member` (`member_id`),
  CONSTRAINT `Matching_ibfk_2` FOREIGN KEY (`to_member_id`) REFERENCES `Member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=565 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Matching`
--

LOCK TABLES `Matching` WRITE;
/*!40000 ALTER TABLE `Matching` DISABLE KEYS */;
INSERT INTO `Matching` VALUES (113,39,56,'PENDING'),(195,39,55,'PENDING'),(196,39,57,'PENDING'),(197,39,58,'PENDING'),(198,39,59,'PENDING'),(199,39,60,'PENDING'),(202,39,61,'PENDING'),(203,39,62,'PENDING'),(204,39,63,'PENDING'),(205,39,64,'PENDING'),(206,39,66,'PENDING'),(207,39,65,'PENDING'),(254,170,55,'PENDING'),(255,170,56,'PENDING'),(256,170,57,'PENDING'),(257,170,58,'PENDING'),(258,170,59,'PENDING'),(259,170,60,'PENDING'),(260,170,61,'PENDING'),(261,170,62,'PENDING'),(262,170,63,'PENDING'),(263,170,64,'PENDING'),(264,170,65,'PENDING'),(309,176,64,'PENDING'),(325,176,55,'PENDING'),(327,176,57,'PENDING'),(328,176,56,'PENDING'),(329,176,58,'PENDING'),(331,176,59,'PENDING'),(332,176,61,'PENDING'),(333,176,60,'PENDING'),(334,176,62,'PENDING'),(335,176,63,'PENDING'),(348,187,176,'MATCHED'),(354,189,176,'PENDING'),(360,189,177,'PENDING'),(361,189,178,'PENDING'),(362,189,179,'PENDING'),(363,189,180,'PENDING'),(364,189,181,'PENDING'),(365,189,182,'PENDING'),(366,189,184,'PENDING'),(367,189,183,'PENDING'),(368,189,185,'PENDING'),(369,189,186,'PENDING'),(371,189,187,'PENDING'),(372,176,183,'PENDING'),(373,176,185,'PENDING'),(374,176,186,'PENDING'),(423,148,177,'PENDING'),(424,148,180,'PENDING'),(425,148,179,'PENDING'),(426,148,181,'PENDING'),(427,148,182,'PENDING'),(428,148,183,'PENDING'),(429,148,184,'PENDING'),(430,148,185,'PENDING'),(431,148,186,'PENDING'),(432,148,178,'PENDING'),(434,148,187,'MATCHED'),(437,188,176,'PENDING'),(438,188,148,'PENDING'),(443,170,177,'PENDING'),(444,170,178,'PENDING'),(445,170,179,'PENDING'),(446,170,180,'PENDING'),(447,170,181,'PENDING'),(448,170,182,'PENDING'),(449,170,183,'PENDING'),(450,170,184,'PENDING'),(451,170,185,'PENDING'),(452,170,187,'MATCHED'),(458,170,188,'MATCHED'),(467,165,178,'PENDING'),(468,165,177,'PENDING'),(469,165,179,'PENDING'),(470,165,180,'PENDING'),(471,165,181,'PENDING'),(472,165,182,'PENDING'),(473,188,165,'PENDING'),(474,188,178,'PENDING'),(475,188,177,'PENDING'),(496,170,186,'PENDING'),(555,175,177,'PENDING'),(556,175,178,'PENDING'),(557,187,175,'MATCHED'),(561,190,175,'PENDING'),(562,190,177,'PENDING'),(563,190,178,'PENDING'),(564,190,179,'PENDING');
/*!40000 ALTER TABLE `Matching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Member`
--

DROP TABLE IF EXISTS `Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Member` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `gender` enum('MALE','FEMALE') DEFAULT NULL,
  `age` int NOT NULL,
  `nickname` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `status` enum('ACTIVE','DELETED') DEFAULT NULL,
  `callable` tinyint(1) NOT NULL,
  `preference` enum('MALE','FEMALE','BOTH') DEFAULT NULL,
  `uid` varchar(30) NOT NULL,
  `instagram_id` varchar(30) DEFAULT NULL,
  `kakao_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member`
--

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;
INSERT INTO `Member` VALUES (4,'MALE',10,'tester','signuptest@signuptest.com','korea','1997-01-29 00:00:00','ACTIVE',0,'FEMALE','SA7q9H4r0WfIkvdah6OSIW7Y6XQ2','instatonid','kakaochocolate'),(7,'FEMALE',27,'tester2','test2@petcong.com','Seoul','1997-01-29 00:00:00','ACTIVE',0,'MALE','1997','instakilogram',NULL),(8,'MALE',1,'nickname','smy@petcong.com','Korea','1997-01-29 00:00:00','ACTIVE',0,'FEMALE','1','miligram','macao'),(15,'MALE',27,'jaewon','jaewon@gmail.com','Seoul 212, 1402','2000-01-01 00:00:00','ACTIVE',0,'MALE','bXPUzT3tFOaT2UE9RdxKPHHAIhK2','instaId','moon'),(33,'MALE',10,'nickname','signuptest@signuptest.com','korea','1997-01-29 00:00:00','ACTIVE',0,'FEMALE','signuptest','instatonid','kakaochocolate'),(38,'MALE',1,'string','test@petcong.com','서울특별시 강남구 역삼동 테헤란로 212, 1402호','2022-02-07 00:00:00','ACTIVE',0,'MALE','dsadasdasdasdasdasdsadasd','string','string'),(40,'MALE',1,'string','gogo@yahoo.com',NULL,'2007-02-07 00:00:00','ACTIVE',0,'MALE','comone','string','string'),(41,'MALE',1,'string','test@petcong.com','서울특별시 강남구 역삼동 테헤란로 212, 1402호','2014-02-07 00:00:00','ACTIVE',0,'MALE','hhubuvuvugub','string','string'),(55,'MALE',23,'닉네임2061038756','test2004@petcong.com','서울시 강남구','1995-11-13 00:00:00','ACTIVE',0,'BOTH','1688243545','insta_943840738','kakako_1305820136'),(56,'MALE',21,'닉네임1466778268','test2435@petcong.com','서울시 강남구','1993-08-10 00:00:00','ACTIVE',0,'BOTH','1725438773','insta_1114781105','kakako_1262323325'),(57,'FEMALE',24,'닉네임28765861','test3353@petcong.com','서울시 강남구','1990-08-18 00:00:00','ACTIVE',0,'BOTH','1921871951','insta_386488407','kakako_1432642362'),(58,'FEMALE',29,'닉네임130118261','test2626@petcong.com','서울시 강남구','1997-05-27 00:00:00','ACTIVE',0,'BOTH','1346315578','insta_1676179219','kakako_718778075'),(59,'FEMALE',25,'닉네임404703745','test4913@petcong.com','서울시 강남구','1999-06-02 00:00:00','ACTIVE',0,'BOTH','1688037785','insta_254069702','kakako_1757038071'),(60,'FEMALE',28,'닉네임468673437','test7179@petcong.com','서울시 강남구','1995-07-01 00:00:00','ACTIVE',0,'BOTH','1449846434','insta_813785815','kakako_1799283882'),(61,'MALE',21,'닉네임602513344','test9571@petcong.com','서울시 강남구','1991-11-02 00:00:00','ACTIVE',0,'BOTH','1914170172','insta_1732007338','kakako_738088450'),(62,'MALE',25,'닉네임1163270598','test929@petcong.com','서울시 강남구','1994-04-05 00:00:00','ACTIVE',0,'BOTH','1357726327','insta_49367086','kakako_1472073911'),(63,'MALE',24,'닉네임163202382','test8859@petcong.com','서울시 강남구','1998-02-25 00:00:00','ACTIVE',0,'BOTH','1317023809','insta_1884337300','kakako_8666395'),(64,'MALE',28,'닉네임329653571','test5714@petcong.com','서울시 강남구','1994-03-15 00:00:00','ACTIVE',0,'BOTH','1042723726','insta_974313434','kakako_748858562'),(65,'FEMALE',28,'닉네임1551713807','test7456@petcong.com','서울시 강남구','1996-08-10 00:00:00','ACTIVE',0,'BOTH','1424076814','insta_2087864685','kakako_1298737809'),(66,'FEMALE',24,'닉네임1352725360','test2184@petcong.com','서울시 강남구','1999-05-21 00:00:00','ACTIVE',0,'BOTH','1819550433','insta_677499711','kakako_583309709'),(67,'FEMALE',22,'닉네임587346238','test6948@petcong.com','서울시 강남구','1995-11-27 00:00:00','ACTIVE',0,'BOTH','1138967991','insta_464401682','kakako_1439966257'),(68,'MALE',20,'닉네임742091389','test2690@petcong.com','서울시 강남구','1992-03-11 00:00:00','ACTIVE',0,'BOTH','1406943403','insta_1013364676','kakako_926351061'),(69,'FEMALE',23,'닉네임2048345111','test2870@petcong.com','서울시 강남구','1990-06-28 00:00:00','ACTIVE',0,'BOTH','1845507684','insta_1513354029','kakako_1741268906'),(70,'MALE',24,'닉네임814127114','test7118@petcong.com','서울시 강남구','1995-06-25 00:00:00','ACTIVE',0,'BOTH','1703118096','insta_1918466973','kakako_831698518'),(71,'FEMALE',22,'닉네임1376665783','test6089@petcong.com','서울시 강남구','1990-03-05 00:00:00','ACTIVE',0,'BOTH','1085276906','insta_828575692','kakako_559593328'),(72,'FEMALE',24,'닉네임1970533554','test3854@petcong.com','서울시 강남구','1995-06-03 00:00:00','ACTIVE',0,'BOTH','1638320385','insta_64577933','kakako_2050716807'),(73,'FEMALE',26,'닉네임1911045158','test4600@petcong.com','서울시 강남구','1998-10-21 00:00:00','ACTIVE',0,'MALE','1247111039','insta_1991707466','kakako_388870409'),(74,'FEMALE',24,'닉네임1393423799','test5710@petcong.com','서울시 강남구','1997-08-04 00:00:00','ACTIVE',0,'MALE','1680840149','insta_1795105197','kakako_1334411541'),(75,'FEMALE',27,'닉네임554712705','test3671@petcong.com','서울시 강남구','1995-02-05 00:00:00','ACTIVE',0,'FEMALE','1461292041','insta_1250064174','kakako_979539674'),(76,'MALE',22,'닉네임1675470237','test374@petcong.com','서울시 강남구','1996-02-18 00:00:00','ACTIVE',0,'BOTH','1013166148','insta_1340593524','kakako_1002257533'),(77,'MALE',24,'닉네임752320671','test181@petcong.com','서울시 강남구','1995-11-25 00:00:00','ACTIVE',0,'BOTH','1571038721','insta_2041283168','kakako_503720918'),(78,'FEMALE',30,'닉네임57707870','test5254@petcong.com','서울시 강남구','1992-06-01 00:00:00','ACTIVE',0,'FEMALE','1533079021','insta_1481036350','kakako_482225835'),(79,'FEMALE',22,'닉네임1705056193','test1042@petcong.com','서울시 강남구','1997-09-21 00:00:00','ACTIVE',0,'MALE','1200274620','insta_1512966468','kakako_1488753189'),(80,'FEMALE',23,'닉네임520657855','test9142@petcong.com','서울시 강남구','1995-11-21 00:00:00','ACTIVE',0,'FEMALE','1384904091','insta_1621235102','kakako_930513568'),(81,'MALE',27,'닉네임1061117761','test1461@petcong.com','서울시 강남구','1994-05-18 00:00:00','ACTIVE',0,'FEMALE','1343339151','insta_683892960','kakako_349042603'),(82,'MALE',22,'닉네임70289703','test5769@petcong.com','서울시 강남구','1990-11-06 00:00:00','ACTIVE',0,'MALE','1424285167','insta_1119787264','kakako_1725659340'),(83,'FEMALE',29,'닉네임776604768','test3487@petcong.com','서울시 강남구','1996-06-02 00:00:00','ACTIVE',0,'MALE','1797967658','insta_569145643','kakako_1096840883'),(84,'FEMALE',28,'닉네임1259788697','test2638@petcong.com','서울시 강남구','1997-01-25 00:00:00','ACTIVE',0,'FEMALE','1467720631','insta_313337001','kakako_1594875166'),(85,'FEMALE',30,'닉네임1492391722','test228@petcong.com','서울시 강남구','1992-06-27 00:00:00','ACTIVE',0,'FEMALE','1648993173','insta_738236969','kakako_1781650871'),(86,'MALE',23,'닉네임347669530','test9139@petcong.com','서울시 강남구','1991-08-09 00:00:00','ACTIVE',0,'MALE','1254646055','insta_430226179','kakako_351387380'),(87,'MALE',27,'닉네임1073679095','test9944@petcong.com','서울시 강남구','1991-09-07 00:00:00','ACTIVE',0,'MALE','1414784474','insta_744210287','kakako_1677741863'),(88,'FEMALE',28,'닉네임1124580368','test8147@petcong.com','서울시 강남구','1998-01-22 00:00:00','ACTIVE',0,'FEMALE','1886807946','insta_1143655343','kakako_1618427598'),(89,'FEMALE',23,'닉네임1343975284','test8913@petcong.com','서울시 강남구','1996-03-03 00:00:00','ACTIVE',0,'FEMALE','1179463545','insta_750428629','kakako_341002032'),(90,'MALE',25,'닉네임274013365','test8871@petcong.com','서울시 강남구','1995-10-04 00:00:00','ACTIVE',0,'FEMALE','1868967949','insta_1317447049','kakako_882194558'),(91,'MALE',25,'닉네임536560327','test224@petcong.com','서울시 강남구','1994-03-07 00:00:00','ACTIVE',0,'MALE','1044359174','insta_1875886539','kakako_1091298465'),(92,'FEMALE',29,'닉네임425993460','test5816@petcong.com','서울시 강남구','1999-01-11 00:00:00','ACTIVE',0,'MALE','1824543016','insta_1175122444','kakako_512655437'),(93,'FEMALE',20,'닉네임1133589874','test3431@petcong.com','서울시 강남구','1991-01-14 00:00:00','ACTIVE',0,'FEMALE','1409495867','insta_1873198267','kakako_147587145'),(94,'MALE',22,'닉네임266215624','test6066@petcong.com','서울시 강남구','1997-01-22 00:00:00','ACTIVE',0,'MALE','1195131912','insta_1794239560','kakako_1936783628'),(95,'MALE',28,'닉네임130140868','test1825@petcong.com','서울시 강남구','1996-09-14 00:00:00','ACTIVE',0,'FEMALE','1407835751','insta_1781468584','kakako_746202809'),(96,'MALE',27,'닉네임354522401','test7511@petcong.com','서울시 강남구','1995-10-25 00:00:00','ACTIVE',0,'FEMALE','1474349608','insta_582200443','kakako_1447745827'),(97,'MALE',24,'닉네임1019103552','test926@petcong.com','서울시 강남구','1997-08-14 00:00:00','ACTIVE',0,'FEMALE','1952710024','insta_503778501','kakako_1705092954'),(98,'FEMALE',26,'닉네임2036966443','test9168@petcong.com','서울시 강남구','1999-11-06 00:00:00','ACTIVE',0,'MALE','1553449282','insta_795058482','kakako_483966458'),(99,'MALE',27,'닉네임1939829174','test811@petcong.com','서울시 강남구','1990-02-07 00:00:00','ACTIVE',0,'MALE','1766581594','insta_1874948189','kakako_526309686'),(100,'FEMALE',30,'닉네임2017117468','test8538@petcong.com','서울시 강남구','1991-11-20 00:00:00','ACTIVE',0,'FEMALE','1719435768','insta_1598630087','kakako_717441447'),(101,'MALE',30,'닉네임107719552','test936@petcong.com','서울시 강남구','1992-01-24 00:00:00','ACTIVE',0,'FEMALE','1037562807','insta_550198459','kakako_1907799816'),(102,'FEMALE',27,'닉네임1960420544','test9270@petcong.com','서울시 강남구','1992-09-16 00:00:00','ACTIVE',0,'FEMALE','1056895005','insta_672277957','kakako_1397951998'),(103,'MALE',24,'닉네임15163120','test9172@petcong.com','서울시 강남구','1998-06-04 00:00:00','ACTIVE',0,'FEMALE','1824441926','insta_819699525','kakako_1647281117'),(104,'FEMALE',24,'닉네임157882366','test4206@petcong.com','서울시 강남구','1993-01-20 00:00:00','ACTIVE',0,'MALE','1853117642','insta_1775652246','kakako_676212549'),(105,'FEMALE',30,'닉네임981048772','test7372@petcong.com','서울시 강남구','1996-09-12 00:00:00','ACTIVE',0,'FEMALE','1468989578','insta_71485671','kakako_528567106'),(106,'MALE',26,'닉네임77676192','test4797@petcong.com','서울시 강남구','1990-09-15 00:00:00','ACTIVE',0,'MALE','1951101669','insta_1622070351','kakako_1598815584'),(107,'FEMALE',28,'닉네임1143424201','test137@petcong.com','서울시 강남구','1995-02-02 00:00:00','ACTIVE',0,'MALE','1732008543','insta_1123139815','kakako_422354561'),(108,'MALE',29,'닉네임1828642851','test3727@petcong.com','서울시 강남구','1998-07-09 00:00:00','ACTIVE',0,'MALE','1085966265','insta_1182424868','kakako_798842884'),(109,'FEMALE',24,'닉네임182680309','test9277@petcong.com','서울시 강남구','1997-06-27 00:00:00','ACTIVE',0,'MALE','1909618617','insta_1387755282','kakako_746088070'),(110,'MALE',24,'닉네임454039889','test8977@petcong.com','서울시 강남구','1994-01-16 00:00:00','ACTIVE',0,'MALE','1720275596','insta_2123780769','kakako_147311257'),(111,'FEMALE',29,'닉네임501074858','test2760@petcong.com','서울시 강남구','1997-10-01 00:00:00','ACTIVE',0,'MALE','1073353784','insta_681550789','kakako_353660505'),(112,'MALE',25,'닉네임208990325','test7011@petcong.com','서울시 강남구','1993-11-04 00:00:00','ACTIVE',0,'FEMALE','1879426071','insta_1292586957','kakako_246066953'),(113,'FEMALE',23,'닉네임1213913831','test5689@petcong.com','서울시 강남구','1996-06-01 00:00:00','ACTIVE',0,'MALE','1294446784','insta_536652666','kakako_275770276'),(114,'FEMALE',23,'닉네임95450148','test6817@petcong.com','서울시 강남구','1991-09-07 00:00:00','ACTIVE',0,'MALE','1145636237','insta_1553624792','kakako_2103150725'),(115,'MALE',23,'닉네임100820291','test3828@petcong.com','서울시 강남구','1991-10-16 00:00:00','ACTIVE',0,'MALE','1575987428','insta_1499688051','kakako_692454553'),(116,'FEMALE',25,'닉네임790014525','test3310@petcong.com','서울시 강남구','1996-10-20 00:00:00','ACTIVE',0,'FEMALE','1884859043','insta_958197625','kakako_265914803'),(117,'MALE',28,'닉네임1088598387','test9395@petcong.com','서울시 강남구','1995-05-07 00:00:00','ACTIVE',0,'FEMALE','1080736610','insta_1497975748','kakako_1761453088'),(118,'MALE',21,'닉네임1375148640','test3113@petcong.com','서울시 강남구','1999-06-13 00:00:00','ACTIVE',0,'FEMALE','1913982146','insta_550468728','kakako_1768291885'),(119,'FEMALE',25,'닉네임250122591','test2885@petcong.com','서울시 강남구','1996-02-03 00:00:00','ACTIVE',0,'MALE','1284899428','insta_412404267','kakako_168584127'),(120,'FEMALE',29,'닉네임1602589701','test3315@petcong.com','서울시 강남구','1991-02-26 00:00:00','ACTIVE',0,'MALE','1474650898','insta_428537655','kakako_457378862'),(121,'MALE',26,'닉네임1656018904','test1883@petcong.com','서울시 강남구','1995-03-14 00:00:00','ACTIVE',0,'FEMALE','1347559071','insta_2075909044','kakako_1596548747'),(122,'MALE',20,'닉네임1402149428','test9777@petcong.com','서울시 강남구','1998-01-03 00:00:00','ACTIVE',0,'FEMALE','1050244140','insta_19337225','kakako_1632166971'),(123,'MALE',23,'닉네임882331843','test9357@petcong.com','서울시 강남구','1993-09-04 00:00:00','ACTIVE',0,'FEMALE','1443518130','insta_1358258877','kakako_173673125'),(124,'MALE',27,'닉네임1620356688','test9885@petcong.com','서울시 강남구','1994-04-14 00:00:00','ACTIVE',0,'FEMALE','1635659796','insta_229065279','kakako_374090733'),(125,'FEMALE',24,'닉네임1807319620','test9594@petcong.com','서울시 강남구','1991-09-22 00:00:00','ACTIVE',0,'FEMALE','1343891812','insta_1230335373','kakako_1683730918'),(126,'FEMALE',27,'닉네임1174600609','test2607@petcong.com','서울시 강남구','1992-10-09 00:00:00','ACTIVE',0,'FEMALE','1252485309','insta_1810886389','kakako_801855009'),(127,'MALE',25,'닉네임453346220','test822@petcong.com','서울시 강남구','1992-09-23 00:00:00','ACTIVE',0,'MALE','1980913301','insta_1438152773','kakako_738415796'),(128,'FEMALE',22,'닉네임1150764938','test6350@petcong.com','서울시 강남구','1999-02-26 00:00:00','ACTIVE',0,'MALE','1746210530','insta_1533396104','kakako_582113870'),(129,'FEMALE',30,'닉네임2131564739','test8975@petcong.com','서울시 강남구','1990-10-15 00:00:00','ACTIVE',0,'MALE','1281579348','insta_696299845','kakako_969629476'),(130,'FEMALE',25,'닉네임996725260','test4987@petcong.com','서울시 강남구','1993-03-19 00:00:00','ACTIVE',0,'MALE','1427686121','insta_484944194','kakako_293788652'),(131,'MALE',22,'닉네임196261305','test8274@petcong.com','서울시 강남구','1990-09-03 00:00:00','ACTIVE',0,'MALE','1755249130','insta_1027173076','kakako_1407383782'),(132,'MALE',26,'닉네임1168798779','test2007@petcong.com','서울시 강남구','1990-04-07 00:00:00','ACTIVE',0,'MALE','1575395163','insta_1202263627','kakako_1798929459'),(133,'FEMALE',30,'닉네임807090025','test6802@petcong.com','서울시 강남구','1991-01-16 00:00:00','ACTIVE',0,'FEMALE','1415181203','insta_1253603133','kakako_637361268'),(134,'FEMALE',30,'닉네임2074289927','test9832@petcong.com','서울시 강남구','1997-01-01 00:00:00','ACTIVE',0,'FEMALE','1475460553','insta_823608763','kakako_2089767368'),(135,'MALE',29,'닉네임2054035686','test3165@petcong.com','서울시 강남구','1998-04-09 00:00:00','ACTIVE',0,'FEMALE','1239877272','insta_919296997','kakako_1417754150'),(148,'MALE',27,'dan','32173385@dankook.ac.kr',NULL,'1996-03-30 00:00:00','ACTIVE',0,'FEMALE','5aEg90DTkVMcOemdqjFAD7nhYrD2','danins','dankaka'),(165,'MALE',27,'cebu13','cebu13@gmail.com',NULL,'1996-02-27 00:00:00','ACTIVE',0,'FEMALE','kS95PNT8RUc78Qr7TQ4uRaJmbw23','insa','kaka'),(168,'MALE',25,'Ehigh','rkd2rb@gmail.com',NULL,'1998-12-24 00:00:00','ACTIVE',0,'FEMALE','p7n3ZJ3YmKPIaD3esIb20RTWuyk2','instaid','kakaoid'),(170,'MALE',25,'호구','jujaewon88@gmail.com',NULL,'1998-05-13 00:00:00','ACTIVE',0,'FEMALE','A45f4AW04gST4byDFtlqonJT6Hm1','','joojae1'),(175,'MALE',26,'쫑우','youngjoo000108@gmail.com',NULL,'1997-08-29 00:00:00','ACTIVE',1,'BOTH','4GtzqrsSDBVSC1FkOWXXJ2i7CfA3','jjong__28','jjongwoo97'),(176,'FEMALE',24,'양','petcong17@gmail.com',NULL,'2000-01-08 00:00:00','ACTIVE',0,'BOTH','LDojqImUvegSgU0zJkjJbdk75bx1','ducb',''),(177,'FEMALE',24,'시아','sia@example.com',NULL,NULL,NULL,1,NULL,'sia_uid',NULL,NULL),(178,'FEMALE',25,'나은','naeun@example.com',NULL,NULL,NULL,1,NULL,'naeun_uid',NULL,NULL),(179,'FEMALE',26,'지유','jiyu@example.com',NULL,NULL,NULL,1,NULL,'jiyu_uid',NULL,NULL),(180,'FEMALE',27,'예나','yena@example.com',NULL,NULL,NULL,1,NULL,'yena_uid',NULL,NULL),(181,'FEMALE',28,'하율','hayul@example.com',NULL,NULL,NULL,1,NULL,'hayul_uid',NULL,NULL),(182,'FEMALE',29,'서현','seohyun@example.com',NULL,NULL,NULL,1,NULL,'seohyun_uid',NULL,NULL),(183,'FEMALE',23,'다인','dain@example.com',NULL,NULL,NULL,1,NULL,'dain_uid',NULL,NULL),(184,'FEMALE',24,'채원','chaewon@example.com',NULL,NULL,NULL,1,NULL,'chaewon_uid',NULL,NULL),(185,'FEMALE',25,'예서','yeseo@example.com',NULL,NULL,NULL,1,NULL,'yeseo_uid',NULL,NULL),(186,'FEMALE',26,'리아','ria@example.com',NULL,NULL,NULL,1,NULL,'ria_uid',NULL,NULL),(187,'FEMALE',24,'영주탭','petcongyj@gmail.com',NULL,'2000-01-08 00:00:00','ACTIVE',1,'MALE','Z8RNqMBdk6SuBAuA9i0shV19QSR2','yj_0108_','youngjoo0108'),(188,'FEMALE',25,'하양이','codecrafter603@gmail.com',NULL,'1998-02-26 00:00:00','ACTIVE',0,'MALE','er8WxTkx6JPszf8YuSA5Xw97alp1','hayang','petcong'),(189,'MALE',31,'뽀삐아빠','codecrafter603@gmail.com',NULL,'1993-02-04 00:00:00','ACTIVE',0,'FEMALE','gHVcvjllueRTdd9F6P1M6ZUVi283','paul_lee_jh','kaka'),(190,'FEMALE',24,'펫콩이','petcong2@gmail.com',NULL,'1999-12-12 00:00:00','ACTIVE',1,'BOTH','4oxu3guKGaOUnXOV7jN1Qd3L60g1','ins','kaka');
/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MemberImg`
--

DROP TABLE IF EXISTS `MemberImg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MemberImg` (
  `img_id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `bucket_key` varchar(255) NOT NULL,
  `content_type` varchar(20) NOT NULL,
  `length` int NOT NULL,
  `ordinal` int DEFAULT NULL,
  PRIMARY KEY (`img_id`),
  KEY `user_id` (`member_id`),
  CONSTRAINT `MemberImg_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MemberImg`
--

LOCK TABLES `MemberImg` WRITE;
/*!40000 ALTER TABLE `MemberImg` DISABLE KEYS */;
INSERT INTO `MemberImg` VALUES (9,4,'SA7q9H4r0WfIkvdah6OSIW7Y6XQ2/20240211-141633.jpg','jpg',5838,0),(10,4,'SA7q9H4r0WfIkvdah6OSIW7Y6XQ2/20240211-141633.jpg','jpg',211690,0),(46,12,'4GtzqrsSDBVSC1FkOWXXJ2i7CfA3/20240213-065032.jpg','jpg',56948,0),(47,12,'4GtzqrsSDBVSC1FkOWXXJ2i7CfA3/20240213-065032.jpg','jpg',80560,0),(68,57,'1921871951/20240213-155159.jpg','jpg',311933,0),(69,58,'1346315578/20240213-155200.jpg','jpg',322470,0),(70,59,'1688037785/20240213-155200.jpg','jpg',269561,0),(71,60,'1449846434/20240213-155200.jpg','jpg',294145,0),(72,65,'1424076814/20240213-155200.jpg','jpg',288663,0),(73,66,'1819550433/20240213-155200.jpg','jpg',302055,0),(74,67,'1138967991/20240213-155201.jpg','jpg',218613,0),(75,69,'1845507684/20240213-155201.jpg','jpg',332845,0),(76,71,'1085276906/20240213-155201.jpg','jpg',76121,0),(77,72,'1638320385/20240213-155201.jpg','jpg',185003,0),(78,55,'1688243545/20240213-155242.jpg','jpg',198003,0),(79,56,'1725438773/20240213-155242.jpg','jpg',552416,0),(80,61,'1914170172/20240213-155242.jpg','jpg',231739,0),(81,62,'1357726327/20240213-155243.jpg','jpg',226414,0),(82,63,'1317023809/20240213-155243.jpg','jpg',309996,0),(83,64,'1042723726/20240213-155243.jpg','jpg',190441,0),(84,68,'1406943403/20240213-155243.jpg','jpg',94090,0),(85,70,'1703118096/20240213-155243.jpg','jpg',523569,0),(86,76,'1013166148/20240213-155244.jpg','jpg',164762,0),(87,77,'1571038721/20240213-155244.jpg','jpg',374167,0),(91,148,'5aEg90DTkVMcOemdqjFAD7nhYrD2/20240213-075527.jpg','jpg',460034,0),(92,148,'5aEg90DTkVMcOemdqjFAD7nhYrD2/20240213-075527.jpg','jpg',656956,0),(135,165,'kS95PNT8RUc78Qr7TQ4uRaJmbw23/20240215-012832857.jpg','jpg',594147,0),(136,165,'kS95PNT8RUc78Qr7TQ4uRaJmbw23/20240215-012833154.jpg','jpg',64629,0),(143,170,'A45f4AW04gST4byDFtlqonJT6Hm1/20240215-041519276.jpg','jpg',52256,0),(144,170,'A45f4AW04gST4byDFtlqonJT6Hm1/20240215-041519544.jpg','jpg',60922,0),(147,175,'4GtzqrsSDBVSC1FkOWXXJ2i7CfA3/20240215-102145084.jpg','jpg',194148,0),(148,175,'4GtzqrsSDBVSC1FkOWXXJ2i7CfA3/20240215-102145403.jpg','jpg',177409,0),(149,176,'LDojqImUvegSgU0zJkjJbdk75bx1/20240215-104456864.jpg','jpg',125426,0),(150,176,'LDojqImUvegSgU0zJkjJbdk75bx1/20240215-104456938.jpg','jpg',149173,0),(151,187,'Z8RNqMBdk6SuBAuA9i0shV19QSR2/20240215-162342705.jpg','jpg',18723,0),(152,187,'Z8RNqMBdk6SuBAuA9i0shV19QSR2/20240215-162342769.jpg','jpg',21511,0),(153,187,'Z8RNqMBdk6SuBAuA9i0shV19QSR2/20240215-162342850.jpg','jpg',25361,0),(154,187,'Z8RNqMBdk6SuBAuA9i0shV19QSR2/20240215-162342931.jpg','jpg',32536,0),(155,187,'Z8RNqMBdk6SuBAuA9i0shV19QSR2/20240215-162343012.jpg','jpg',19839,0),(156,188,'er8WxTkx6JPszf8YuSA5Xw97alp1/20240215-170024785.jpg','jpg',14666,0),(157,188,'er8WxTkx6JPszf8YuSA5Xw97alp1/20240215-170024894.jpg','jpg',30100,0),(158,189,'gHVcvjllueRTdd9F6P1M6ZUVi283/20240215-171537936.jpg','jpg',52365,0),(159,189,'gHVcvjllueRTdd9F6P1M6ZUVi283/20240215-171538054.jpg','jpg',277142,0),(160,177,'sia_uid/20240216-032656804.jpg','jpg',464678,0),(161,178,'naeun_uid/20240216-033107851.jpg','jpg',327425,0),(162,179,'jiyu_uid/20240216-033153057.jpg','jpg',470551,0),(163,180,'yena_uid/20240216-033231572.jpg','jpg',332364,0),(164,181,'hayul_uid/20240216-033251230.jpg','jpg',525067,0),(165,182,'seohyun_uid/20240216-033316500.jpg','jpg',348700,0),(166,183,'dain_uid/20240216-033336324.jpg','jpg',406234,0),(167,184,'chaewon_uid/20240216-033356083.jpg','jpg',462579,0),(168,185,'yeseo_uid/20240216-033500068.jpg','jpg',95970,0),(169,186,'ria_uid/20240216-033527009.jpg','jpg',91786,0),(173,190,'4oxu3guKGaOUnXOV7jN1Qd3L60g1/20240216-104605887.jpg','jpg',92934,0),(174,190,'4oxu3guKGaOUnXOV7jN1Qd3L60g1/20240216-104610434.jpg','jpg',78138,0);
/*!40000 ALTER TABLE `MemberImg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pet`
--

DROP TABLE IF EXISTS `Pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pet` (
  `pet_id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `name` varchar(25) NOT NULL,
  `breed` varchar(25) DEFAULT NULL,
  `age` int NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `neutered` tinyint(1) NOT NULL,
  `size` enum('SMALL','MEDIUM','LARGE') DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dbti` char(4) DEFAULT NULL,
  `hobby` varchar(25) DEFAULT NULL,
  `snack` varchar(25) DEFAULT NULL,
  `toy` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`pet_id`),
  KEY `user_id` (`member_id`),
  CONSTRAINT `Pet_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pet`
--

LOCK TABLES `Pet` WRITE;
/*!40000 ALTER TABLE `Pet` DISABLE KEYS */;
INSERT INTO `Pet` VALUES (18,34,'초코','test',12,'MALE',1,'LARGE',12,'test data','istp','sleep','sadas','testval'),(19,38,'string','string',1,'MALE',1,'SMALL',10,'string','stri','string','string','string'),(20,39,'dogdogdogdog','test',12,'MALE',1,'LARGE',12,'test data','istp','sleep','sadas','testval'),(21,40,'string','string',1,'MALE',1,'SMALL',10,'string',NULL,NULL,NULL,NULL),(22,41,'string','string',1,'MALE',1,'SMALL',10,'string','stri','string','string','string'),(23,43,'dognsmd','breed',10,'FEMALE',1,NULL,1,NULL,NULL,NULL,NULL,NULL),(24,45,'ggg','dd',10,'FEMALE',0,NULL,10,NULL,NULL,NULL,NULL,NULL),(26,4,'야옹이','골드 리트리버',1,'FEMALE',0,'LARGE',30,'우리 개는 물어요.','INFP','산책','생닭다리','원반'),(27,51,'dogdogdogdog','test',12,'MALE',1,'LARGE',12,'test data','istp','sleep','sadas','testval'),(28,53,'petname',NULL,10,'FEMALE',0,NULL,0,NULL,NULL,NULL,NULL,NULL),(29,54,'네네',NULL,10,'FEMALE',0,NULL,0,NULL,NULL,NULL,NULL,NULL),(30,55,'구마유시','진돗개',13,'FEMALE',1,'MEDIUM',10,'개들을 풀어라','ESTP','아무것도 안하기','육포','포인터'),(31,56,'이소룡','삽살개',6,'MALE',0,'SMALL',19,'빠지는 털로 목도리를 짤 수 있습니다','INFP','산책','족발','공'),(32,57,'개호주','닥스훈트',14,'MALE',1,'SMALL',17,'세상에 나쁜 개는 없다','ISTJ','아무것도 안하기','스팸','쥐방울'),(33,58,'오딘','치와와',8,'MALE',0,'MEDIUM',18,'개를 위한 나라는 없다','ESTP','수영','햄','개껌'),(34,59,'페리시치','보더콜리',19,'MALE',1,'MEDIUM',14,'저희 개는 안물어요','ESFJ','산책','사과','원반'),(35,60,'니체','삽살개',12,'FEMALE',0,'SMALL',16,'빠지는 털로 목도리를 짤 수 있습니다','ENFP','원반던지기','닭가슴살','포인터'),(36,61,'아르키메데스','셰퍼드',10,'FEMALE',0,'LARGE',17,'개팔자가 상팔자','ISFJ','개껌 씹기','수육','쥐방울'),(37,62,'럼블','보더콜리',6,'FEMALE',0,'MEDIUM',18,'세상에 나쁜 개는 없다','ESTP','개껌 씹기','스테이크','개껌'),(38,63,'루돌프','골든 리트리버',2,'FEMALE',0,'MEDIUM',12,'세상에 나쁜 개는 없다','ENTJ','아무것도 안하기','오리목뼈','개껌'),(39,64,'오딘','셰퍼드',7,'FEMALE',1,'LARGE',13,'바르개 살자','ESTP','수영','스팸','개껌'),(40,65,'김민재','치와와',4,'FEMALE',0,'LARGE',12,'개를 위한 나라는 없다','ISTJ','산책','사과','포인터'),(41,66,'사자','도베르만',14,'FEMALE',0,'MEDIUM',17,'개들을 풀어라','ESTP','개껌 씹기','먹태','포인터'),(42,67,'루돌프','닥스훈트',18,'MALE',0,'SMALL',12,'세상에 나쁜 개는 없다','ENTJ','뒹굴기','생닭','포인터'),(43,68,'루돌프','닥스훈트',19,'MALE',0,'LARGE',9,'세상에 나쁜 개는 없다','INTP','원반던지기','참치캔','포인터'),(44,69,'대상혁','셰퍼드',13,'FEMALE',0,'LARGE',17,'저희 개는 안물어요','ISFJ','뒹굴기','육포','개껌'),(45,70,'토르','골든 리트리버',8,'FEMALE',0,'LARGE',11,'빠지는 털로 목도리를 짤 수 있습니다','ISFP','원반던지기','닭가슴살','공'),(46,71,'메시','도베르만',6,'FEMALE',0,'LARGE',16,'개를 위한 나라는 없다','ISFP','산책','먹태','포인터'),(47,72,'보리','셰퍼드',9,'FEMALE',0,'MEDIUM',15,'배를 만져주면 좋아합니다','ENTJ','아무것도 안하기','족발','포인터'),(48,73,'멍멍이','도베르만',7,'MALE',1,'MEDIUM',17,'세상에 나쁜 개는 없다','ENTJ','산책','족발','원반'),(49,74,'사자','치와와',14,'FEMALE',0,'LARGE',12,'저희 개는 안물어요','ISTJ','아무것도 안하기','햄','원반'),(50,75,'멈뭄미','셰퍼드',8,'MALE',0,'SMALL',13,'개팔자가 상팔자','ISFP','아무것도 안하기','츄르','포인터'),(51,76,'야옹이','시츄',11,'MALE',1,'SMALL',13,'저희 개는 안물어요','ISTJ','원반던지기','수육','포인터'),(52,77,'엘살바도르','시츄',8,'MALE',0,'SMALL',18,'개팔자가 상팔자','INTP','수영','사과','공'),(53,78,'오딘','셰퍼드',17,'FEMALE',0,'SMALL',15,'바르개 살자','ISTJ','뒹굴기','소세지','쥐방울'),(54,79,'제우스','삽살개',19,'FEMALE',0,'MEDIUM',18,'저희 개는 안물어요','ENTP','원반던지기','수육','포인터'),(55,80,'라미엘','시츄',16,'MALE',0,'SMALL',13,'세상에 나쁜 개는 없다','ENTP','뒹굴기','오리목뼈','원반'),(56,81,'플라톤','시츄',4,'MALE',1,'SMALL',17,'개팔자가 상팔자','INTP','원반던지기','츄르','포인터'),(57,82,'사자','치와와',18,'MALE',0,'LARGE',12,'배를 만져주면 좋아합니다','ISTP','뒹굴기','생닭','포인터'),(58,83,'뽀삐','삽살개',9,'FEMALE',0,'LARGE',13,'세상에 나쁜 개는 없다','INTJ','아무것도 안하기','닭가슴살','개껌'),(59,84,'치타','셰퍼드',1,'MALE',1,'MEDIUM',18,'저희 개는 안물어요','ISTJ','수영','소세지','공'),(60,85,'토르','보더콜리',10,'FEMALE',0,'SMALL',10,'산책 안가면 죽는 병에 걸림','ESTJ','뒹굴기','고구마','원반'),(61,86,'즐라탄','시츄',9,'MALE',1,'SMALL',11,'혼낼 때 세상 억울한 표정 지음','ESFP','수영','소세지','공'),(62,87,'딸기','진돗개',3,'FEMALE',1,'MEDIUM',12,'저희 개는 안물어요','ESTP','개껌 씹기','스팸','개껌'),(63,88,'손흥민','치와와',18,'MALE',1,'LARGE',11,'배를 만져주면 좋아합니다','ENFP','수영','수육','원반'),(64,89,'루돌프','보더콜리',10,'FEMALE',0,'MEDIUM',13,'바르개 살자','INFJ','아무것도 안하기','생닭','쥐방울'),(65,90,'초코','시츄',9,'FEMALE',1,'LARGE',19,'개팔자가 상팔자','INTP','산책','스테이크','개껌'),(66,91,'딸기','삽살개',13,'MALE',0,'SMALL',17,'빠지는 털로 목도리를 짤 수 있습니다','INTJ','산책','수육','쥐방울'),(67,92,'딸기','보더콜리',9,'FEMALE',0,'LARGE',11,'저희 개는 안물어요','ESTJ','원반던지기','소세지','공'),(68,93,'치타','진돗개',10,'FEMALE',0,'MEDIUM',16,'혼낼 때 세상 억울한 표정 지음','ENFP','수영','스테이크','포인터'),(69,94,'니체','삽살개',6,'FEMALE',0,'SMALL',18,'세상에 나쁜 개는 없다','ESFP','개껌 씹기','소세지','공'),(70,95,'멍멍이','보더콜리',12,'FEMALE',0,'SMALL',11,'개들을 풀어라','ISFP','산책','오리목뼈','공'),(71,96,'루돌프','허스키',15,'FEMALE',1,'SMALL',10,'빠지는 털로 목도리를 짤 수 있습니다','ESFJ','아무것도 안하기','참치캔','개껌'),(72,97,'오딘','골든 리트리버',11,'MALE',0,'SMALL',16,'바르개 살자','INFJ','원반던지기','스테이크','포인터'),(73,98,'럼블','도베르만',3,'FEMALE',0,'MEDIUM',12,'개팔자가 상팔자','ISTJ','산책','생닭','공'),(74,99,'표범','닥스훈트',4,'FEMALE',0,'LARGE',12,'바르개 살자','ENTP','원반던지기','바나나','개껌'),(75,100,'루돌프','도베르만',13,'MALE',1,'SMALL',9,'저희 개는 안물어요','ENTP','수영','먹태','포인터'),(76,101,'이강인','허스키',19,'FEMALE',0,'SMALL',18,'개를 위한 나라는 없다','ESFJ','수영','먹태','원반'),(77,102,'김민재','셰퍼드',13,'FEMALE',0,'SMALL',16,'개를 위한 나라는 없다','ENTJ','원반던지기','츄르','쥐방울'),(78,103,'제우스','도베르만',8,'FEMALE',1,'SMALL',13,'저희 개는 안물어요','ESTJ','원반던지기','사과','쥐방울'),(79,104,'호날두','진돗개',18,'FEMALE',0,'SMALL',16,'혼낼 때 세상 억울한 표정 지음','ENTJ','개껌 씹기','먹태','공'),(80,105,'훔바훔바','시츄',8,'FEMALE',1,'SMALL',17,'산책 안가면 죽는 병에 걸림','ENFJ','산책','케비아','원반'),(81,106,'즐라탄','셰퍼드',10,'MALE',0,'MEDIUM',11,'개들을 풀어라','INTJ','수영','참치캔','개껌'),(82,107,'대상혁','보더콜리',18,'FEMALE',0,'MEDIUM',14,'혼낼 때 세상 억울한 표정 지음','INTP','수영','고구마','원반'),(83,108,'메시','골든 리트리버',12,'MALE',0,'MEDIUM',17,'빠지는 털로 목도리를 짤 수 있습니다','ISFP','뒹굴기','케비아','공'),(84,109,'오딘','골든 리트리버',3,'FEMALE',0,'SMALL',12,'빠지는 털로 목도리를 짤 수 있습니다','INFJ','수영','사과','공'),(85,110,'니체','셰퍼드',4,'FEMALE',0,'MEDIUM',13,'개팔자가 상팔자','INFP','뒹굴기','참치캔','포인터'),(86,111,'늑대','진돗개',7,'MALE',0,'SMALL',13,'산책 안가면 죽는 병에 걸림','ISTP','수영','닭가슴살','개껌'),(87,112,'제우스','진돗개',16,'MALE',1,'MEDIUM',15,'개를 위한 나라는 없다','ESTP','아무것도 안하기','토마호크','공'),(88,113,'제라드','허스키',5,'MALE',0,'SMALL',10,'바르개 살자','ESFJ','뒹굴기','육포','공'),(89,114,'럼블','셰퍼드',5,'MALE',0,'SMALL',14,'배를 만져주면 좋아합니다','ENTJ','산책','닭가슴살','원반'),(90,115,'재규어','셰퍼드',15,'FEMALE',1,'MEDIUM',19,'산책 안가면 죽는 병에 걸림','ESTJ','원반던지기','먹태','공'),(91,116,'사자','보더콜리',3,'FEMALE',0,'SMALL',10,'개들을 풀어라','ESTP','뒹굴기','육포','포인터'),(92,117,'알아키르','치와와',14,'MALE',0,'SMALL',12,'산책 안가면 죽는 병에 걸림','ISFJ','수영','수육','개껌'),(93,118,'아기','골든 리트리버',3,'MALE',1,'MEDIUM',17,'산책 안가면 죽는 병에 걸림','ESTP','산책','족발','원반'),(94,119,'피즈','닥스훈트',6,'FEMALE',0,'SMALL',10,'저희 개는 안물어요','INTJ','산책','사과','원반'),(95,120,'우유','닥스훈트',3,'FEMALE',0,'MEDIUM',13,'개들을 풀어라','ESFP','수영','바나나','원반'),(96,121,'개호주','골든 리트리버',11,'FEMALE',0,'LARGE',10,'개팔자가 상팔자','ISFP','뒹굴기','참치캔','포인터'),(97,122,'니체','허스키',15,'MALE',0,'LARGE',15,'혼낼 때 세상 억울한 표정 지음','INFP','아무것도 안하기','먹태','원반'),(98,123,'페리시치','도베르만',4,'FEMALE',1,'SMALL',19,'개팔자가 상팔자','ESFJ','원반던지기','사과','쥐방울'),(99,124,'울라리','닥스훈트',16,'FEMALE',0,'MEDIUM',15,'배를 만져주면 좋아합니다','ENFJ','아무것도 안하기','스팸','개껌'),(100,125,'호랑이','셰퍼드',9,'FEMALE',0,'LARGE',13,'바르개 살자','ENFJ','개껌 씹기','사과','쥐방울'),(101,126,'야옹이','셰퍼드',17,'FEMALE',0,'SMALL',18,'개팔자가 상팔자','ISTJ','원반던지기','스테이크','쥐방울'),(102,127,'엘살바도르','골든 리트리버',14,'FEMALE',0,'SMALL',11,'빠지는 털로 목도리를 짤 수 있습니다','ESTJ','뒹굴기','케비아','포인터'),(103,128,'티모','보더콜리',16,'FEMALE',1,'SMALL',10,'산책 안가면 죽는 병에 걸림','ISTP','개껌 씹기','햄','원반'),(104,129,'보리','허스키',6,'MALE',0,'MEDIUM',13,'저희 개는 안물어요','ESTP','수영','닭가슴살','공'),(105,130,'재규어','보더콜리',8,'MALE',0,'MEDIUM',15,'세상에 나쁜 개는 없다','ISTP','수영','육포','쥐방울'),(106,131,'보리','보더콜리',16,'FEMALE',1,'SMALL',18,'바르개 살자','ENFJ','뒹굴기','오리목뼈','포인터'),(107,132,'훔바훔바','셰퍼드',4,'MALE',0,'SMALL',17,'혼낼 때 세상 억울한 표정 지음','ISFP','수영','사과','공'),(108,133,'묠니르','닥스훈트',12,'MALE',0,'LARGE',11,'개들을 풀어라','ESFP','원반던지기','바나나','원반'),(109,134,'아르키메데스','셰퍼드',15,'FEMALE',1,'SMALL',15,'세상에 나쁜 개는 없다','ESFP','원반던지기','닭가슴살','원반'),(110,135,'묠니르','골든 리트리버',11,'FEMALE',1,'SMALL',9,'세상에 나쁜 개는 없다','ESFP','아무것도 안하기','수육','공'),(111,137,'yeet',NULL,10,'FEMALE',0,NULL,0,'One day Two day',NULL,NULL,NULL,NULL),(112,139,'gg',NULL,10,'FEMALE',0,NULL,0,NULL,NULL,NULL,NULL,NULL),(113,140,'도추너',NULL,10,'FEMALE',1,NULL,0,NULL,NULL,NULL,NULL,NULL),(116,147,'꽁이',NULL,13,'MALE',1,NULL,0,'안녕ㅎ',NULL,NULL,NULL,NULL),(117,148,'고미',NULL,7,'FEMALE',1,NULL,0,'나야나 단이',NULL,NULL,NULL,NULL),(121,165,'꽁이',NULL,12,'MALE',1,NULL,0,'나야나',NULL,NULL,NULL,NULL),(122,168,'samplepetname',NULL,6,'MALE',1,NULL,0,'sampleintroduction',NULL,NULL,NULL,NULL),(123,170,'토토',NULL,4,'FEMALE',1,NULL,0,'안녕하세요',NULL,NULL,NULL,NULL),(124,171,'코코',NULL,11,'MALE',0,NULL,0,'내 강아지는 복슬 복슬',NULL,NULL,NULL,NULL),(125,175,'상혁',NULL,2,'FEMALE',0,NULL,0,'하이욤 제 강아지 귀엽쭁?',NULL,NULL,NULL,NULL),(126,176,'시오',NULL,8,'MALE',1,NULL,0,'강아지를 키워요',NULL,NULL,NULL,NULL),(147,177,'두부',NULL,2,'FEMALE',1,'SMALL',5,'Cute and fluffy','1234','Playing fetch','Dog treats','Squeaky toy'),(148,178,'초코',NULL,3,'FEMALE',1,'MEDIUM',25,'Friendly and energetic','5678','Running','Peanut butter bones','Bouncy ball'),(149,179,'모카',NULL,1,'FEMALE',0,'SMALL',7,'Curly and playful','ABCD','Chasing laser pointer','Catnip','Feather wand'),(150,180,'설이',NULL,2,'FEMALE',1,'LARGE',30,'Loyal and friendly','EFGH','Swimming','Dog biscuits','Tug-of-war rope'),(151,181,'토토',NULL,4,'FEMALE',1,'SMALL',10,'Long and cute','IJKL','Digging','Cheese cubes','Plush squeaky toy'),(152,182,'모찌',NULL,2,'FEMALE',1,'MEDIUM',18,'Adorable and affectionate','MNOP','Napping','Chicken jerky','Rubber bone'),(153,183,'송이',NULL,3,'FEMALE',0,'MEDIUM',20,'Independent and spirited','QRST','Chasing butterflies','Salmon bites','Chew ring'),(154,184,'몽이',NULL,1,'FEMALE',1,'SMALL',12,'Sweet and gentle','UVWX','Cuddling','Bacon strips','Soft plush toy'),(155,185,'시루',NULL,2,'FEMALE',1,'SMALL',8,'Energetic and brave','YZAB','Jumping','Beef jerky','Sisal ball'),(156,186,'맥스',NULL,3,'FEMALE',1,'LARGE',35,'Playful and intelligent','CDEF','Howling','Turkey jerky','Tennis ball'),(157,187,'꽁',NULL,13,'MALE',1,NULL,0,'꽁이 보고싶당',NULL,NULL,NULL,NULL),(158,188,'쭝이',NULL,3,'FEMALE',0,NULL,0,'저는 쭝이의 집사 하양이에요!!\n저와 제 강아지는 딸기를 좋아해요! ?',NULL,NULL,NULL,NULL),(159,189,'뽀삐',NULL,7,'MALE',1,NULL,0,'뽀삐 아빠에요! 같이 산책해요!',NULL,NULL,NULL,NULL),(160,190,'콩스',NULL,2,'MALE',0,NULL,0,'안녕하세요!',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SkillMultimedia`
--

DROP TABLE IF EXISTS `SkillMultimedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SkillMultimedia` (
  `multimedia_id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `bucket_key` varchar(255) NOT NULL,
  `content_type` varchar(20) NOT NULL,
  `length` int NOT NULL,
  `ordinal` int DEFAULT NULL,
  PRIMARY KEY (`multimedia_id`),
  KEY `user_id` (`member_id`),
  CONSTRAINT `SkillMultimedia_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SkillMultimedia`
--

LOCK TABLES `SkillMultimedia` WRITE;
/*!40000 ALTER TABLE `SkillMultimedia` DISABLE KEYS */;
INSERT INTO `SkillMultimedia` VALUES (3,55,'1688243545/20240214-095325800.jpg','jpg',262307,0),(4,56,'1725438773/20240214-095326557.jpg','jpg',174804,0),(5,61,'1914170172/20240214-095326775.jpg','jpg',279129,0),(6,62,'1357726327/20240214-095327224.jpg','jpg',394401,0),(7,63,'1317023809/20240214-095327470.jpg','jpg',315274,0),(8,64,'1042723726/20240214-095327663.jpg','jpg',222581,0),(9,68,'1406943403/20240214-095327897.jpg','jpg',165944,0),(10,70,'1703118096/20240214-095328190.jpg','jpg',305608,0),(11,76,'1013166148/20240214-095328409.jpg','jpg',251279,0),(12,77,'1571038721/20240214-095328633.jpg','jpg',158606,0),(13,57,'1921871951/20240214-095613967.jpg','jpg',298093,0),(14,58,'1346315578/20240214-095614757.jpg','jpg',296593,0),(15,59,'1688037785/20240214-095615197.jpg','jpg',229236,0),(16,60,'1449846434/20240214-095615411.jpg','jpg',503122,0),(17,65,'1424076814/20240214-095615687.jpg','jpg',256577,0),(18,66,'1819550433/20240214-095616021.jpg','jpg',305047,0),(19,67,'1138967991/20240214-095616195.jpg','jpg',289367,0),(20,69,'1845507684/20240214-095616411.jpg','jpg',484761,0),(21,71,'1085276906/20240214-095616683.jpg','jpg',231799,0),(22,72,'1638320385/20240214-095616889.jpg','jpg',326081,0);
/*!40000 ALTER TABLE `SkillMultimedia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-16 11:03:40
