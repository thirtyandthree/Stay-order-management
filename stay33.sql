-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: stay33
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Current Database: `stay33`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `stay33` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `stay33`;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `coverImg` varchar(255) NOT NULL,
  `date` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
INSERT INTO `announcements` VALUES (1,'营养均衡饮食','保证每天摄入足够的蛋白质、碳水化合物、维生素和矿物质,维持身体健康。','https://qiniu.staykoi.asia/2024-2-9/%E5%8A%A8%E6%BC%AB/2023020102260894.webp','2023-04-17'),(2,'多吃蔬菜水果','蔬菜水果富含丰富的维生素和膳食纤维,有助于预防疾病,促进肠道健康。','https://qiniu.staykoi.asia/2024-2-9/%E5%8A%A8%E6%BC%AB/2023020102260925.webp','2023-04-18'),(3,'少食多餐','将一天的进食量分成3-5次小餐,有助于提高代谢率,控制体重。','https://qiniu.staykoi.asia/2024-2-9/%E5%8A%A8%E6%BC%AB/2023020102261028.webp','2023-04-18'),(4,'合理控制饮酒','适量饮酒可以提高心血管健康,但过量饮酒会对身体造成伤害。','https://qiniu.staykoi.asia/2024-2-9/%E5%8A%A8%E6%BC%AB/2023020102261240.webp','2023-04-18'),(5,'保持良好饮食习惯','养成规律的饮食时间和合理的饮食结构,有助于维持身心健康。','https://qiniu.staykoi.asia/2024-2-9/%E5%8A%A8%E6%BC%AB/2023020102261396.webp','2023-04-18'),(6,'你好','阿达的','https://qiniu.staykoi.asia/2024-2-9/%E5%8A%A8%E6%BC%AB/2023020102261396.webp','2024-05-12'),(8,'哈哈哈哈哈','很好啊','https://qiniu.staykoi.asia/2024-2-9/%E5%8A%A8%E6%BC%AB/2023020102260894.webp','2024-5-13');
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cheapgoods`
--

DROP TABLE IF EXISTS `cheapgoods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cheapgoods` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `ImageUrl` varchar(255) DEFAULT NULL,
  `Sizes` text,
  `Temperatures` text,
  `Addons` text,
  `Stock` int DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheapgoods`
--

LOCK TABLES `cheapgoods` WRITE;
/*!40000 ALTER TABLE `cheapgoods` DISABLE KEYS */;
INSERT INTO `cheapgoods` VALUES (1,'青珂奶茶',0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','[\"大杯\"]','[\"常温\"]','[\"珍珠\"]',10,'经典'),(2,'柠檬水',10.00,'https://qiniu.staykoi.asia/2024-3-14/20240220164826237.jpg','[\"中杯\"]','[\"加冰\"]','[\"椰果\"]',10,'经典'),(3,'冰水',4.00,'https://qiniu.staykoi.asia/2024-3-14/20240220164813599.jpg','[\"大杯\"]','[\"常温\"]','[\"珍珠\"]',10,'原味');
/*!40000 ALTER TABLE `cheapgoods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logo_url` varchar(255) NOT NULL,
  `smtp` varchar(255) NOT NULL,
  `port` int NOT NULL,
  `sender` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `server_address` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sender` (`sender`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
INSERT INTO `email` VALUES (1,'https://qiniu.staykoi.asia/2024-2-15/102169262_p0_master1200.jpg','smtp.qq.com',465,'2580996608@qq.com','bkfcxlsebrlpeacb','smtp.qq.com','2024-04-09 03:58:26');
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `email_3` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,'stay33','2580996608@qq.com','123mysql'),(2,'西蒙','3535724271@qq.com','ximeng'),(7,'西西萌','755503413@qq.com','123456'),(8,'超','672121445@qq.com','123456'),(9,'111','2832762626@qq.com','123456'),(11,'2022200523','2133129978@qq.com','123456'),(13,'eloise','451688895@qq.com','147852'),(14,'54321','3637992712@qq.com','123mysql'),(15,'lixiao','1073145516@qq.com','123mysql'),(16,'苏志阳','2772842798@qq.com','123456789');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `goods_name` varchar(255) DEFAULT NULL,
  `goods_weight` varchar(255) DEFAULT NULL,
  `goods_number` int DEFAULT NULL,
  `goods_price` decimal(10,2) DEFAULT NULL,
  `goods_total_price` decimal(10,2) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `goods_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,1,'T-shirt','200g',2,15.00,30.00,'https://example.com/t-shirt','In Stock'),(2,1,'Jeans','800g',1,50.00,50.00,'https://example.com/jeans','In Stock'),(9,10,'卡布奇诺','100g',1,15.00,15.00,'https://qiniu.staykoi.asia/2024-5-3/kabuqinuo.webp',''),(10,11,'美式咖啡','100g',1,44.00,44.00,'https://qiniu.staykoi.asia/2024-5-3/meishi.jpg',''),(11,11,'拿铁','100g',1,8.00,8.00,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg',''),(12,15,'卡布奇诺','100g',1,15.00,15.00,'https://qiniu.staykoi.asia/2024-5-3/kabuqinuo.webp',''),(13,17,'抹茶拿铁','100g',1,4.00,4.00,'https://qiniu.staykoi.asia/2024-5-3/mocha.jpg','进行中'),(14,18,'拿铁','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg','进行中'),(15,19,'青珂奶茶','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','进行中'),(16,21,'青珂奶茶','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','进行中'),(17,23,'青珂奶茶','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','进行中'),(18,24,'青珂奶茶','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','进行中'),(19,25,'青珂奶茶','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','进行中'),(20,26,'拿铁','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg','进行中'),(21,27,'拿铁','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg','进行中'),(22,28,'特选珍珠奶茶','100g',1,100.00,100.00,'https://qiniu.staykoi.asia/2024-5-3/%E5%85%91%E6%8D%A2%E7%A0%81%20%281%29.png','进行中'),(23,29,'仙草椰果茶','100g',1,20.00,20.00,'https://qiniu.staykoi.asia/2024-5-3/%E5%85%91%E6%8D%A2%E7%A0%81%20%281%29.png','进行中'),(24,30,'特选珍珠奶茶','100g',1,100.00,100.00,'https://qiniu.staykoi.asia/2024-5-3/%E5%85%91%E6%8D%A2%E7%A0%81%20%281%29.png','进行中'),(25,31,'特选珍珠奶茶','100g',1,100.00,100.00,'https://qiniu.staykoi.asia/2024-5-3/%E5%85%91%E6%8D%A2%E7%A0%81%20%281%29.png','进行中'),(26,32,'特选珍珠奶茶','100g',1,100.00,100.00,'https://qiniu.staykoi.asia/2024-5-3/%E5%85%91%E6%8D%A2%E7%A0%81%20%281%29.png','进行中'),(27,33,'特选珍珠奶茶','100g',1,100.00,100.00,'https://qiniu.staykoi.asia/2024-5-3/%E5%85%91%E6%8D%A2%E7%A0%81%20%281%29.png','进行中'),(28,34,'拿铁','100g',2,0.10,0.20,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg','进行中'),(29,35,'青珂奶茶','100g',0,0.10,0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','进行中'),(30,35,'柠檬水','100g',0,10.00,10.00,'https://qiniu.staykoi.asia/2024-3-14/20240220164826237.jpg','进行中'),(31,35,'冰水','100g',0,4.00,4.00,'https://qiniu.staykoi.asia/2024-3-14/20240220164813599.jpg','进行中'),(32,36,'青珂奶茶','100g',0,0.10,0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','进行中'),(33,36,'柠檬水','100g',0,10.00,10.00,'https://qiniu.staykoi.asia/2024-3-14/20240220164826237.jpg','进行中'),(34,36,'冰水','100g',0,4.00,4.00,'https://qiniu.staykoi.asia/2024-3-14/20240220164813599.jpg','进行中'),(35,37,'青珂奶茶','100g',0,0.10,0.10,'https://qiniu.staykoi.asia/2024-3-14/20240220164836743.jpg','进行中'),(36,37,'柠檬水','100g',0,10.00,10.00,'https://qiniu.staykoi.asia/2024-3-14/20240220164826237.jpg','进行中'),(37,37,'冰水','100g',0,4.00,4.00,'https://qiniu.staykoi.asia/2024-3-14/20240220164813599.jpg','进行中'),(38,38,'拿铁','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg','进行中'),(39,39,'拿铁','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg','进行中'),(40,40,'拿铁','100g',1,0.10,0.10,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg','进行中');
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_number` varchar(255) NOT NULL,
  `order_price` decimal(10,2) DEFAULT NULL,
  `order_user` varchar(255) DEFAULT NULL,
  `pay_status` varchar(50) DEFAULT NULL,
  `is_send` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_number` (`order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'afagag',60.00,'John','0','0','2024-03-31 10:00:00'),(2,'ABC1234',50.00,'stay','1','0','2024-04-01 10:45:20'),(5,'订单编号1',50.00,'张三','1','0','2024-04-02 10:00:00'),(6,'订单编号2',75.50,'李四','1','0','2024-04-02 11:30:00'),(7,'订单编号3',30.25,'王五','0','0','2024-04-03 09:45:00'),(8,'订单编号4',100.75,'张三','1','是','2024-04-03 14:20:00'),(9,'订单编号5',45.80,'赵六','1','否','2024-04-04 16:00:00'),(10,'你好啊',15.00,'3535724271@qq.com','1','1','2024-05-09 15:11:44'),(11,'自动生成的',52.00,'3535724271@qq.com','0','0','2024-05-09 15:20:38'),(15,'3535724271@qq.com',15.00,'3535724271@qq.com','0','0','2024-05-09 15:44:03'),(17,'15',4.00,'3535724271@qq.com','0','0','2024-05-09 16:33:48'),(18,'17',0.10,'3535724271@qq.com','1','0','2024-05-10 16:43:02'),(19,'18',0.10,'3535724271@qq.com','1','0','2024-05-11 15:50:56'),(21,'19',0.10,'3535724271@qq.com','1','0','2024-05-11 15:53:42'),(23,'21',0.10,'3535724271@qq.com','1','0','2024-05-11 15:57:58'),(24,'23',0.10,'3535724271@qq.com','1','0','2024-05-11 15:58:25'),(25,'24',0.10,'3535724271@qq.com','1','0','2024-05-11 15:59:46'),(26,'25',0.10,'3535724271@qq.com','1','0','2024-05-11 16:01:56'),(27,'26',0.10,'3535724271@qq.com','1','0','2024-05-11 16:02:17'),(28,'27',100.00,'3535724271@qq.com','1','0','2024-05-12 12:52:55'),(29,'28',20.00,'3535724271@qq.com','1','0','2024-05-12 12:54:26'),(30,'29',100.00,'3535724271@qq.com','1','0','2024-05-12 13:00:23'),(31,'30',100.00,'3535724271@qq.com','1','0','2024-05-12 13:02:22'),(32,'31',100.00,'3535724271@qq.com','1','0','2024-05-12 13:04:29'),(33,'32',100.00,'3535724271@qq.com','1','0','2024-05-12 21:06:49'),(34,'33',0.20,'3535724271@qq.com','1','0','2024-05-13 16:45:23'),(35,'34',0.10,'3535724271@qq.com','1','0','2024-05-13 17:04:19'),(36,'35',0.10,'3535724271@qq.com','1','0','2024-05-13 17:06:13'),(37,'36',0.10,'3535724271@qq.com','1','0','2024-05-13 17:06:26'),(38,'37',0.10,'3535724271@qq.com','1','0','2024-05-13 17:08:28'),(39,'38',0.10,'3535724271@qq.com','1','0','2024-05-13 17:08:53'),(40,'39',0.10,'3535724271@qq.com','1','0','2024-05-13 17:12:03');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay`
--

DROP TABLE IF EXISTS `pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) NOT NULL,
  `private_key` text NOT NULL,
  `alipay_public_key` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_id` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay`
--

LOCK TABLES `pay` WRITE;
/*!40000 ALTER TABLE `pay` DISABLE KEYS */;
INSERT INTO `pay` VALUES (1,'2021004132668048','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');
/*!40000 ALTER TABLE `pay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pesonlist`
--

DROP TABLE IF EXISTS `pesonlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pesonlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pesonlist`
--

LOCK TABLES `pesonlist` WRITE;
/*!40000 ALTER TABLE `pesonlist` DISABLE KEYS */;
INSERT INTO `pesonlist` VALUES (1,'','','东区','山东省青岛市崂山区仙霞岭路18号','北京市 北京市'),(3,'3535724271@qq.com','男','天津市 天津市','山东省青岛市崂山区仙霞岭路18号','天津市 天津市'),(6,'3535724271@qq.com','男','13561739670','山东省青岛市崂山区仙霞岭路18号','天津市 天津市'),(7,'3535724271@qq.com','','天津市 天津市','13561739670','山东省青岛市崂山区仙霞岭路18号');
/*!40000 ALTER TABLE `pesonlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `ImageUrl` varchar(255) DEFAULT NULL,
  `Sizes` text,
  `Temperatures` text,
  `Addons` text,
  `Stock` int DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_product_name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (2,'美式咖啡',41.00,'https://qiniu.staykoi.asia/2024-5-3/meishi.jpg','[\"大杯\",\"小杯\"]','[\"常温\"]','[\"珍珠\",\"椰果\",\"红豆\"]',60,'经典'),(3,'特选珍珠奶茶',100.00,'https://img.zcool.cn/community/01ee045a95fbfea8012045b3874580.jpg@1280w_1l_2o_100sh.jpg','[\"大杯\",\"中杯\"]','[\"常温\",\"加冰\",\"少冰\"]','[\"珍珠\",\"椰果\",\"红豆\"]',73,'飘香'),(4,'仙草椰果茶',20.00,'https://tse3-mm.cn.bing.net/th/id/OIP-C.rx_RehSnGl5esTkfEBhbAgHaLH?w=203&h=304&c=7&r=0&o=5&dpr=1.5&pid=1.7','[\"大杯\", \"中杯\"]','[\"常温\", \"加冰\", \"少冰\"]','[\"珍珠\", \"椰果\", \"红豆\"]',30,'全部'),(5,'拿铁',0.10,'https://qiniu.staykoi.asia/2024-5-3/natie.jpg','[\"大杯\"]','[\"常温\"]','[\"珍珠\"]',10,'经典'),(7,'意式浓缩',10.00,'https://qiniu.staykoi.asia/2024-5-3/yishi.webp','[\"中杯\"]','[\"加冰\"]','[\"椰果\"]',4,'飘香'),(8,'抹茶拿铁',4.00,'https://qiniu.staykoi.asia/2024-5-3/mocha.jpg','[\"大杯\"]','[\"常温\"]','[\"珍珠\"]',10,'特色');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `redeem`
--

DROP TABLE IF EXISTS `redeem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `redeem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `codeTtatus` enum('待兑换','已兑换','已过期') NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `redeem`
--

LOCK TABLES `redeem` WRITE;
/*!40000 ALTER TABLE `redeem` DISABLE KEYS */;
INSERT INTO `redeem` VALUES (2,'1ISMVHFE8B29DQ7GXJ6UCCCRSWJGWV','特选珍珠奶茶','2024-05-12 18:12:51','1901-01-30 00:05:43','待兑换',100.00),(3,'SKZI2AARNPZS17UVXSW7LCHGGTGVTO','仙草椰果茶','2024-05-12 18:12:51','1901-01-29 00:05:43','待兑换',20.00),(4,'7JWM29GTMZW1WIOUSJG5P1Y3EN925I','特选珍珠奶茶','2024-05-12 18:40:47','1901-01-30 00:05:43','已兑换',100.00),(8,'Q80I6KHBG88CAR2D0ATLIKWLZO797U','仙草椰果茶','2024-05-12 18:44:51','2024-05-07 16:00:00','已兑换',20.00),(9,'R40XDH1Z1DXK31NXZ1AYSHKDNRBW9V','特选珍珠奶茶','2024-05-12 21:03:51','2024-05-29 16:00:00','已兑换',100.00),(10,'TFEERB7HBT0Q6TRHZOKNUZ7ETYK8OU','美式咖啡','2024-05-13 21:12:16','2024-05-07 16:00:00','待兑换',44.00);
/*!40000 ALTER TABLE `redeem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservationlist`
--

DROP TABLE IF EXISTS `reservationlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `numOfPeople` int DEFAULT NULL,
  `reservationTime` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `table_id` (`table_id`),
  CONSTRAINT `reservationlist_ibfk_1` FOREIGN KEY (`table_id`) REFERENCES `tablelist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationlist`
--

LOCK TABLES `reservationlist` WRITE;
/*!40000 ALTER TABLE `reservationlist` DISABLE KEYS */;
INSERT INTO `reservationlist` VALUES (2,'李四',4,'2024-04-03 19:00:00','已预订',2,NULL),(3,'王五',6,'2024-04-04 20:00:00','已预订',3,NULL),(4,'stay33',2,'2024-04-02 12:27:16','已预订',3,NULL),(5,'stay33',2,'2024-04-02 12:27:16','已预订',4,NULL),(7,'stay',1,'2024-04-22 16:00:00','已预订',1,NULL),(8,'默认用户名',1,'2024-05-11 09:00:00','已预订',1,NULL),(9,'	 3535724271@qq.com',2,'2024-05-11 09:01:00','已预订',1,NULL),(10,'3535724271@qq.com',2,'2024-05-11 09:01:00','已预订',1,NULL),(11,'3535724271@qq.com',2,'2024-05-15 16:00:00','已预订',1,NULL),(12,'stay33',2,'2024-05-11 13:04:01','已预订',2,'hhhhh'),(13,'stay33',5,'2024-05-11 09:00:00','已预订',1,'adjaodj'),(14,'李晓硕',1,'2024-05-11 09:02:00','已预订',1,'一个人');
/*!40000 ALTER TABLE `reservationlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UpdateTableStatusAfterReservation` AFTER INSERT ON `reservationlist` FOR EACH ROW BEGIN
    UPDATE tableList SET status = '使用中'
    WHERE id = NEW.table_id AND NEW.status = '已预订';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tablelist`
--

DROP TABLE IF EXISTS `tablelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tablelist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tablelist`
--

LOCK TABLES `tablelist` WRITE;
/*!40000 ALTER TABLE `tablelist` DISABLE KEYS */;
INSERT INTO `tablelist` VALUES (1,'桌子1',3,'空闲','https://img.zcool.cn/community/0158f65603a36932f875a132050063.jpg@1280w_1l_2o_100sh.jpg'),(2,'桌子2',2,'使用中','https://m1-cdn.imeijian.cn/810734b76d53fabeb8b46f2777cf351c.jpg@!3000wh'),(3,'桌子3',4,'使用中','https://img.zcool.cn/community/01445f5da565e6a801204cd039eaeb.jpg@2o.jpg'),(4,'餐桌4',3,'使用中','https://img.zcool.cn/community/019fd758ce34dca801219c775ba92b.jpg@1280w_1l_2o_100sh.jpg');
/*!40000 ALTER TABLE `tablelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `date` date DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('2024-05-13','1820304552@qq.com','','1820304552@qq.com','female',''),('2024-03-23','stay1','北京市/市辖区/东城区','2580','male','1111'),('2024-05-08','3535724271@qq.com','13561739670','3535724271@qq.com','female','天津市 天津市'),('2024-05-07','stay','北京市/市辖区/东城区','3637992712@qq.com','female',''),('2024-04-01','李四','上海市浦东新区','lisi@example.com','male','13987654321'),('2024-04-01','王五','广州市天河区','wangwu@example.com','male','13698765432'),('2024-05-10','小明','成都市武侯区','xiaoming@example.com','male','13765432109'),('2024-04-01','张三','北京市朝阳区','zhangs111an@example.com','male','13812345678'),('2024-03-30','John Doe','北京市朝阳区朝阳门外大街','zhangsan@example.com','female','12345678901'),('2024-03-23','Jane Smith','北京市朝阳区朝阳门外大街11','zhangsan@example.com111','male','123456'),('2024-04-01','赵六','深圳市福田区','zhaoliu@example.com','female','13567894567');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `userchart`
--

DROP TABLE IF EXISTS `userchart`;
/*!50001 DROP VIEW IF EXISTS `userchart`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `userchart` AS SELECT 
 1 AS `date`,
 1 AS `user_name`,
 1 AS `gender`,
 1 AS `total_spending`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `userinfo`
--

DROP TABLE IF EXISTS `userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) DEFAULT NULL,
  `nickname` varchar(50) NOT NULL,
  `age` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobilePhoneNumber` varchar(20) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `hobby` text,
  `work` varchar(100) DEFAULT NULL,
  `design` text,
  PRIMARY KEY (`id`),
  KEY `fk_email` (`email`),
  CONSTRAINT `fk_email` FOREIGN KEY (`email`) REFERENCES `manager` (`email`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userinfo`
--

LOCK TABLES `userinfo` WRITE;
/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` VALUES (3,'https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/new2.avif','stay',35,'2580996608@qq.com','13812345678',0,'zhangsan','北京','健身、旅行','软件工程师','对未知事物充满热情'),(4,'https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/new2.avif','张三',25,'2580996608@qq.com','13812345678',1,'zhangsan','北京','健身、旅行','软件工程师','对UI/UX设计充满热情');
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users1`
--

DROP TABLE IF EXISTS `users1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) NOT NULL,
  `session_key` varchar(255) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `avatar_url` varchar(255) NOT NULL,
  `gender` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users1`
--

LOCK TABLES `users1` WRITE;
/*!40000 ALTER TABLE `users1` DISABLE KEYS */;
INSERT INTO `users1` VALUES (1,'oIzyJ5dU065woubFm1bT26W9-pQA','s4QMJNiOM3OmeDS45VOihQ==','微信用户','https://thirdwx.qlogo.cn/mmopen/vi_32/POgEwh4mIHO4nibH0KlMECNjjGxQUq24ZEaGT4poC6icRiccVGKSyXwibcPq4BWmiaIGuG1icwxaQX6grC9VemZoJ8rg/132',0);
/*!40000 ALTER TABLE `users1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wpay`
--

DROP TABLE IF EXISTS `wpay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wpay` (
  `AppID` varchar(255) NOT NULL,
  `AppSecret` varchar(255) NOT NULL,
  `MchId` varchar(255) NOT NULL,
  `MchKey` varchar(255) NOT NULL,
  `MchNumber` varchar(255) NOT NULL,
  `PrivateKey` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wpay`
--

LOCK TABLES `wpay` WRITE;
/*!40000 ALTER TABLE `wpay` DISABLE KEYS */;
INSERT INTO `wpay` VALUES ('wxb81f3be1431eec4c','48210615f8114fe2cd3f5441d44b5fc4','1676366315','2580996608qqcom3535724271qqcom36','73740AE5A750B94691985FA058B762DAF6E0932B','-----BEGIN PRIVATE KEY-----\r\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC1RcS33NExwJl3\r\nN9rok2+TmjOBYttQ3kdZNQnD1xKkvCIfL4ybnvEBHYbK+feyylei035E/qjd3QZS\r\nD5hKy1yzShkz4xB9YF62S+d3pCnbuZO6y0pYK7xGYwrizPZVay7LU+YyyqCFeszS\r\nWr+WwvQXjGC73KCGlR11uyBGZFZVcuW96R6kVdvifnHv7bVDXld/MM20yUBwgpkT\r\ni2s+ImhUWQilSTCVTcDRz+6ssohCPbbz4L1HwnyMRU1rD0vBOY3gbkNH8A8cBiL7\r\nHrjy+y59QBieJnp5sHU3/DZSd2US8Nn8WYPz8hgJv3HvvvUXQnegPt7BpfF9ws2T\r\na2+ispbNAgMBAAECggEBAKBNxp1iJY196TlIp8otN+qr3wh4x8JID4iQIsaRl+ce\r\niH5TqmCkujRmTCGL1MTDs6RGq8+P9P3ezAwdxmu+U4gp6we7sYVuh9NmZJelEW9C\r\nOaZiyKgYZTNJuwK+hskbNBKTa2tXTYU9B4yuu+czGHEKrzDy9vKNQ7Qte2lEqiR9\r\nLgA0o0RLEZ0UXS9aMCcm+Bhpupnq6rKi+Y0SVM+FCl/6kieR88GKwJIPVKnQr+F3\r\nCVjF/jOQw0lvTrFucLH/Zf5Iik78CXcgbC7NAz+NHb+Sd766oWJMqbm0KCoAW+Fd\r\nKmYFQNnu5qE85vngBCS3weBb7LPJoCJdkHski45e1IECgYEA3o/ZIyCzaerazkQa\r\nRdFqHTYl4Tge466fleK66RVWq/6fIhmFxNV9QOGgM4MpQ4HcETDB3k8jmyPeb2Wo\r\nkKd8zWwVxcglT4pAN853MK6pXQz69qeFfv4ycYvsGsrSauGDaSEQoh1zn4k6QT26\r\nhT81uR7H8suGUP9et1r5umtpZskCgYEA0IHaU0meSN6cnWrzHgW85Jz12XomW5EU\r\nKmWk4Fwq+oYUtScfaA8MBA9syBu2okwOaoUx9SNrImIVKs4zHI73yFPFcyE8sOP6\r\nBr2nt7RavCmcyhwlen9n1xV3H+/+JG5YGSdC2DHFX0nSB6gcFhERFES6zLmCkkC8\r\n4GGW+gWt/eUCgYEA0d/iij6nEaV3qnUMNXSSVXOfau/KKTidovFJAs2tism0dKqO\r\nu5v63nkl4g24lsFZrhhFaYdFc2HyuyepOqfGh8x6B6WCkaw0fKvFN/ItIeNAseIt\r\ngCDjnrGs92L14/Y/Pp8AmW+eff4hIi68ujRuS+Cb+vgz9COsxMkUn9f0cAkCgYEA\r\nzowj06e0xejH6mTcyxvSAAHAxRvszX5NJKamCp8i8CNMdht4UCO/unHxR9W0ONfw\r\n2/JwB697XIcfAtVa6mpx6J+blC4TqgNcVbsgXqmpzIXITKpPMibtnbIk3J1n+3zX\r\nhqtO202KgJdnGLCeifmEGrju9wi54NmCgSALaEeiEUUCgYAjg9H2c9VP8HPRjb1x\r\n0+UrcRJ+YJQmu34SMieSs/pfrrGusmCcO94Zf4y2Hfy6kOsSIakZdJQMX9E0lnpP\r\n092XWIEHhBrDDYcyvCGLOTYSRBTnWQpRPi8uexBRyxd2+RVJGiI2aCBGzppiotrs\r\nhJY/89h5jRMkujuAMWQ6UPKoSQ==\r\n-----END PRIVATE KEY-----'),('hhhhh','48210615f8114fe2cd3f5441d44b5fc4','1676366315','2580996608qqcom3535724271qqcom36','73740AE5A750B94691985FA058B762DAF6E0932B','-----BEGIN PRIVATE KEY-----\r\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC1RcS33NExwJl3\r\nN9rok2+TmjOBYttQ3kdZNQnD1xKkvCIfL4ybnvEBHYbK+feyylei035E/qjd3QZS\r\nD5hKy1yzShkz4xB9YF62S+d3pCnbuZO6y0pYK7xGYwrizPZVay7LU+YyyqCFeszS\r\nWr+WwvQXjGC73KCGlR11uyBGZFZVcuW96R6kVdvifnHv7bVDXld/MM20yUBwgpkT\r\ni2s+ImhUWQilSTCVTcDRz+6ssohCPbbz4L1HwnyMRU1rD0vBOY3gbkNH8A8cBiL7\r\nHrjy+y59QBieJnp5sHU3/DZSd2US8Nn8WYPz8hgJv3HvvvUXQnegPt7BpfF9ws2T\r\na2+ispbNAgMBAAECggEBAKBNxp1iJY196TlIp8otN+qr3wh4x8JID4iQIsaRl+ce\r\niH5TqmCkujRmTCGL1MTDs6RGq8+P9P3ezAwdxmu+U4gp6we7sYVuh9NmZJelEW9C\r\nOaZiyKgYZTNJuwK+hskbNBKTa2tXTYU9B4yuu+czGHEKrzDy9vKNQ7Qte2lEqiR9\r\nLgA0o0RLEZ0UXS9aMCcm+Bhpupnq6rKi+Y0SVM+FCl/6kieR88GKwJIPVKnQr+F3\r\nCVjF/jOQw0lvTrFucLH/Zf5Iik78CXcgbC7NAz+NHb+Sd766oWJMqbm0KCoAW+Fd\r\nKmYFQNnu5qE85vngBCS3weBb7LPJoCJdkHski45e1IECgYEA3o/ZIyCzaerazkQa\r\nRdFqHTYl4Tge466fleK66RVWq/6fIhmFxNV9QOGgM4MpQ4HcETDB3k8jmyPeb2Wo\r\nkKd8zWwVxcglT4pAN853MK6pXQz69qeFfv4ycYvsGsrSauGDaSEQoh1zn4k6QT26\r\nhT81uR7H8suGUP9et1r5umtpZskCgYEA0IHaU0meSN6cnWrzHgW85Jz12XomW5EU\r\nKmWk4Fwq+oYUtScfaA8MBA9syBu2okwOaoUx9SNrImIVKs4zHI73yFPFcyE8sOP6\r\nBr2nt7RavCmcyhwlen9n1xV3H+/+JG5YGSdC2DHFX0nSB6gcFhERFES6zLmCkkC8\r\n4GGW+gWt/eUCgYEA0d/iij6nEaV3qnUMNXSSVXOfau/KKTidovFJAs2tism0dKqO\r\nu5v63nkl4g24lsFZrhhFaYdFc2HyuyepOqfGh8x6B6WCkaw0fKvFN/ItIeNAseIt\r\ngCDjnrGs92L14/Y/Pp8AmW+eff4hIi68ujRuS+Cb+vgz9COsxMkUn9f0cAkCgYEA\r\nzowj06e0xejH6mTcyxvSAAHAxRvszX5NJKamCp8i8CNMdht4UCO/unHxR9W0ONfw\r\n2/JwB697XIcfAtVa6mpx6J+blC4TqgNcVbsgXqmpzIXITKpPMibtnbIk3J1n+3zX\r\nhqtO202KgJdnGLCeifmEGrju9wi54NmCgSALaEeiEUUCgYAjg9H2c9VP8HPRjb1x\r\n0+UrcRJ+YJQmu34SMieSs/pfrrGusmCcO94Zf4y2Hfy6kOsSIakZdJQMX9E0lnpP\r\n092XWIEHhBrDDYcyvCGLOTYSRBTnWQpRPi8uexBRyxd2+RVJGiI2aCBGzppiotrs\r\nhJY/89h5jRMkujuAMWQ6UPKoSQ==\r\n-----END PRIVATE KEY-----'),('123','48210615f8114fe2cd3f5441d44b5fc4','1676366315','2580996608qqcom3535724271qqcom36','73740AE5A750B94691985FA058B762DAF6E0932B','-----BEGIN PRIVATE KEY-----\r\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC1RcS33NExwJl3\r\nN9rok2+TmjOBYttQ3kdZNQnD1xKkvCIfL4ybnvEBHYbK+feyylei035E/qjd3QZS\r\nD5hKy1yzShkz4xB9YF62S+d3pCnbuZO6y0pYK7xGYwrizPZVay7LU+YyyqCFeszS\r\nWr+WwvQXjGC73KCGlR11uyBGZFZVcuW96R6kVdvifnHv7bVDXld/MM20yUBwgpkT\r\ni2s+ImhUWQilSTCVTcDRz+6ssohCPbbz4L1HwnyMRU1rD0vBOY3gbkNH8A8cBiL7\r\nHrjy+y59QBieJnp5sHU3/DZSd2US8Nn8WYPz8hgJv3HvvvUXQnegPt7BpfF9ws2T\r\na2+ispbNAgMBAAECggEBAKBNxp1iJY196TlIp8otN+qr3wh4x8JID4iQIsaRl+ce\r\niH5TqmCkujRmTCGL1MTDs6RGq8+P9P3ezAwdxmu+U4gp6we7sYVuh9NmZJelEW9C\r\nOaZiyKgYZTNJuwK+hskbNBKTa2tXTYU9B4yuu+czGHEKrzDy9vKNQ7Qte2lEqiR9\r\nLgA0o0RLEZ0UXS9aMCcm+Bhpupnq6rKi+Y0SVM+FCl/6kieR88GKwJIPVKnQr+F3\r\nCVjF/jOQw0lvTrFucLH/Zf5Iik78CXcgbC7NAz+NHb+Sd766oWJMqbm0KCoAW+Fd\r\nKmYFQNnu5qE85vngBCS3weBb7LPJoCJdkHski45e1IECgYEA3o/ZIyCzaerazkQa\r\nRdFqHTYl4Tge466fleK66RVWq/6fIhmFxNV9QOGgM4MpQ4HcETDB3k8jmyPeb2Wo\r\nkKd8zWwVxcglT4pAN853MK6pXQz69qeFfv4ycYvsGsrSauGDaSEQoh1zn4k6QT26\r\nhT81uR7H8suGUP9et1r5umtpZskCgYEA0IHaU0meSN6cnWrzHgW85Jz12XomW5EU\r\nKmWk4Fwq+oYUtScfaA8MBA9syBu2okwOaoUx9SNrImIVKs4zHI73yFPFcyE8sOP6\r\nBr2nt7RavCmcyhwlen9n1xV3H+/+JG5YGSdC2DHFX0nSB6gcFhERFES6zLmCkkC8\r\n4GGW+gWt/eUCgYEA0d/iij6nEaV3qnUMNXSSVXOfau/KKTidovFJAs2tism0dKqO\r\nu5v63nkl4g24lsFZrhhFaYdFc2HyuyepOqfGh8x6B6WCkaw0fKvFN/ItIeNAseIt\r\ngCDjnrGs92L14/Y/Pp8AmW+eff4hIi68ujRuS+Cb+vgz9COsxMkUn9f0cAkCgYEA\r\nzowj06e0xejH6mTcyxvSAAHAxRvszX5NJKamCp8i8CNMdht4UCO/unHxR9W0ONfw\r\n2/JwB697XIcfAtVa6mpx6J+blC4TqgNcVbsgXqmpzIXITKpPMibtnbIk3J1n+3zX\r\nhqtO202KgJdnGLCeifmEGrju9wi54NmCgSALaEeiEUUCgYAjg9H2c9VP8HPRjb1x\r\n0+UrcRJ+YJQmu34SMieSs/pfrrGusmCcO94Zf4y2Hfy6kOsSIakZdJQMX9E0lnpP\r\n092XWIEHhBrDDYcyvCGLOTYSRBTnWQpRPi8uexBRyxd2+RVJGiI2aCBGzppiotrs\r\nhJY/89h5jRMkujuAMWQ6UPKoSQ==\r\n-----END PRIVATE KEY-----');
/*!40000 ALTER TABLE `wpay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `stay33`
--

USE `stay33`;

--
-- Final view structure for view `userchart`
--

/*!50001 DROP VIEW IF EXISTS `userchart`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `userchart` AS select cast(`o`.`create_time` as date) AS `date`,`u`.`name` AS `user_name`,`u`.`gender` AS `gender`,sum(`o`.`order_price`) AS `total_spending` from (`orders` `o` join `user` `u` on((`o`.`order_user` = `u`.`name`))) group by cast(`o`.`create_time` as date),`u`.`name`,`u`.`gender` */;
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

-- Dump completed on 2024-05-14 20:30:34
