/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.28 : Database - healthcontrol
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`healthcontrol` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_cs_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `healthcontrol`;

/*Table structure for table `appuser` */

DROP TABLE IF EXISTS `appuser`;

CREATE TABLE `appuser` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '用户主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `UserName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `Email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `Birth` datetime DEFAULT NULL COMMENT '出生年月',
  `PhoneNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `RoleType` int DEFAULT NULL COMMENT '角色',
  `ImageUrls` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `Password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `Gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `OpenId` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'OpenId',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';

/*Data for the table `appuser` */

insert  into `appuser`(`Id`,`CreationTime`,`UserName`,`Email`,`Name`,`Birth`,`PhoneNumber`,`RoleType`,`ImageUrls`,`Password`,`Gender`,`OpenId`) values (1,'2025-10-08 12:08:44','admin','1317425625@qq.com','管理员','2025-10-21 00:00:00','15211323826',1,'http://localhost:7245/72091794/mmexport1549447640824.jpg','MD521232f297a57a5a743894a0e4a801fc3','女',NULL),(2,'2025-10-11 15:37:57','lilin','1317425625@qq.com','李林','2025-10-15 13:09:13','15211323825',2,'http://localhost:7245/799032297/OtMWDqcrWcei06c2e2efa1f14a78335e5c3923334a2e.png','MD5e10adc3949ba59abbe56e057f20f883e','男',null),(4,'2025-10-28 16:13:39','lilin2','lilinlipeng@sohu.com','李林','2025-10-20 00:00:00','15211323826',2,'http://localhost:7245/318013635/39.png','MD51e53b3189de058f873604013cdb18415','男',NULL);

insert into `appuser`(`Id`, `CreationTime`, `UserName`, `Email`, `Name`, `Birth`, `PhoneNumber`, `RoleType`,
                      `ImageUrls`, `Password`, `Gender`, `OpenId`)
values (1, '2025-10-08 12:08:44', 'admin', '1317425625@qq.com', '管理员', '2025-10-21 00:00:00', '15211323826', 1,
        'http://localhost:7245/72091794/mmexport1549447640824.jpg', 'MD521232f297a57a5a743894a0e4a801fc3', '女', NULL),
       (2, '2025-10-11 15:37:57', 'lilin', '1317425625@qq.com', '李林', '2025-10-15 13:09:13', '15211323825', 2,
        'http://localhost:7245/799032297/OtMWDqcrWcei06c2e2efa1f14a78335e5c3923334a2e.png',
        'MD5e10adc3949ba59abbe56e057f20f883e', '男', null),
       (4, '2025-10-28 16:13:39', 'lilin2', 'lilinlipeng@sohu.com', '李林', '2025-10-20 00:00:00', '15211323826', 2,
        'http://localhost:7245/318013635/39.png', 'MD51e53b3189de058f873604013cdb18415', '男', NULL);

/*Table structure for table `collectrecord` */

DROP TABLE IF EXISTS `collectrecord`;

CREATE TABLE `collectrecord` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '收藏记录主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `CollectUserId` int DEFAULT NULL COMMENT '收藏人',
  `CollectType` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收藏类型',
  `RelativeId` int DEFAULT NULL COMMENT '关联资源Id',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `CollectUserId` (`CollectUserId`) USING BTREE,
  CONSTRAINT `collectrecord_ibfk_1` FOREIGN KEY (`CollectUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='收藏记录表';

/*Data for the table `collectrecord` */

insert  into `collectrecord`(`Id`,`CreationTime`,`CollectUserId`,`CollectType`,`RelativeId`) values (6,'2025-11-09 10:59:18',2,'食谱',8),(7,'2025-11-09 11:50:30',2,'食谱',6),(8,'2025-11-09 13:15:14',2,'健康知识',13),(9,'2025-11-09 13:15:27',2,'食谱',12),(11,'2025-11-09 14:20:35',2,'健康知识',15);

/*Table structure for table `dietrecord` */

DROP TABLE IF EXISTS `dietrecord`;

CREATE TABLE `dietrecord` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '饮食记录主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `FoodId` int DEFAULT NULL COMMENT '记录食物',
  `RecordUserId` int DEFAULT NULL COMMENT '记录人',
  `FoodUnitId` int DEFAULT NULL COMMENT '食物单位',
  `RecordTime` datetime DEFAULT NULL COMMENT '记录时间',
  `RecordValue` int DEFAULT NULL COMMENT '记录值',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `RecordUserId` (`RecordUserId`) USING BTREE,
  KEY `FoodId` (`FoodId`) USING BTREE,
  KEY `FoodUnitId` (`FoodUnitId`) USING BTREE,
  CONSTRAINT `dietrecord_ibfk_1` FOREIGN KEY (`RecordUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `dietrecord_ibfk_2` FOREIGN KEY (`FoodId`) REFERENCES `food` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `dietrecord_ibfk_3` FOREIGN KEY (`FoodUnitId`) REFERENCES `foodunit` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='饮食记录表';

/*Data for the table `dietrecord` */

insert  into `dietrecord`(`Id`,`CreationTime`,`FoodId`,`RecordUserId`,`FoodUnitId`,`RecordTime`,`RecordValue`) values (1,'2025-10-31 16:06:06',17,2,31,'2025-10-31 15:52:23',1),(2,'2025-10-31 16:07:20',13,2,25,'2025-10-31 16:07:14',1),(3,'2025-10-31 16:10:59',18,2,34,'2025-10-31 07:10:26',1),(4,'2025-10-31 16:16:43',14,2,27,'2025-10-15 12:16:21',1),(5,'2025-10-31 17:31:32',16,2,30,'2025-10-31 12:17:05',1),(6,'2025-10-31 17:32:05',5,2,9,'2025-10-31 19:31:52',1),(7,'2025-11-01 11:17:25',13,2,25,'2025-11-01 11:17:14',1),(8,'2025-11-01 11:22:29',17,2,31,'2025-11-01 11:22:26',1),(9,'2025-11-01 13:42:03',20,2,38,'2025-11-01 13:42:00',1),(10,'2025-11-01 13:48:33',28,2,65,'2025-11-01 13:48:30',1),(11,'2025-11-02 11:54:59',27,2,63,'2025-11-02 11:54:56',1),(12,'2025-11-06 10:42:04',27,2,63,'2025-11-06 10:41:54',300),(13,'2025-11-06 11:40:39',17,2,41,'2025-11-06 11:40:31',2),(14,'2025-11-06 12:03:27',27,2,63,'2025-11-06 12:03:24',1),(15,'2025-11-08 12:52:42',29,2,66,'2025-11-08 12:52:40',1),(17,'2025-11-16 11:45:08',21,NULL,50,'2025-11-16 11:44:54',1),(20,'2025-11-16 11:46:48',4,NULL,10,'2025-11-16 11:46:33',2),(21,'2025-11-16 11:47:15',6,NULL,14,'2025-11-16 11:47:10',1),(22,'2025-11-16 11:47:19',5,NULL,12,'2025-11-16 11:47:17',1),(23,'2025-11-16 11:49:03',17,NULL,41,'2025-11-16 11:49:00',1),(24,'2025-11-16 13:47:59',27,2,62,'2025-11-16 13:47:56',1),(25,'2025-11-16 13:57:29',12,2,29,'2025-11-16 13:57:26',1),(26,'2025-11-16 13:57:35',5,2,13,'2025-11-16 13:57:32',1),(27,'2025-11-16 13:57:44',21,2,50,'2025-11-16 13:57:43',1),(28,'2025-11-16 13:58:06',14,2,38,'2025-11-16 13:58:04',1),(29,'2025-11-16 13:58:15',16,2,39,'2025-11-16 13:58:11',1),(30,'2025-11-16 13:58:23',7,2,16,'2025-11-16 13:58:21',1),(32,'2025-11-16 14:12:47',2,2,5,'2025-11-16 14:12:40',3),(33,'2025-11-16 14:13:05',3,2,8,'2025-11-16 14:12:51',10),(34,'2025-11-16 14:13:19',4,2,10,'2025-11-16 14:13:07',2),(35,'2025-11-16 14:13:32',17,2,41,'2025-11-16 14:13:27',2),(38,'2025-11-16 14:15:29',16,2,39,'2025-11-16 14:15:27',1),(39,'2025-11-16 14:29:09',29,2,67,'2025-11-16 14:29:07',1),(40,'2025-11-16 14:29:31',24,2,56,'2025-11-16 14:29:12',5),(41,'2025-11-16 14:29:42',25,2,58,'2025-11-16 14:29:33',5),(42,'2025-11-16 14:30:00',2,2,4,'2025-11-16 14:29:54',6),(43,'2025-11-16 14:30:09',3,2,6,'2025-11-16 14:30:03',5),(44,'2025-11-17 13:42:16',21,2,50,'2025-11-17 13:42:09',1),(45,'2025-11-17 13:42:33',14,2,34,'2025-11-17 13:42:27',1),(46,'2025-11-17 13:43:13',8,2,18,'2025-11-17 13:43:10',1),(47,'2025-11-17 13:43:33',2,2,4,'2025-11-17 13:43:19',3),(48,'2025-11-17 13:43:57',24,2,56,'2025-11-17 13:43:42',1),(49,'2025-11-18 14:53:18',28,2,64,'2025-11-18 14:53:16',1),(50,'2025-11-18 14:53:29',25,2,58,'2025-11-18 14:53:22',3),(51,'2025-11-18 14:53:38',22,2,52,'2025-11-18 14:53:36',1),(52,'2025-11-18 14:53:56',13,2,30,'2025-11-18 14:53:55',1),(53,'2025-11-18 14:54:05',16,2,40,'2025-11-18 14:54:03',1),(54,'2025-11-18 14:54:16',6,2,15,'2025-11-18 14:54:14',1),(55,'2025-11-18 14:54:23',7,2,17,'2025-11-18 14:54:20',1),(56,'2025-11-18 14:54:29',1,2,1,'2025-11-18 14:54:27',1),(57,'2025-11-18 14:54:41',2,2,4,'2025-11-18 14:54:33',5),(58,'2025-11-18 14:54:48',9,2,21,'2025-11-18 14:54:45',1),(59,'2025-11-18 14:55:00',17,2,41,'2025-11-18 14:54:58',1);

/*Table structure for table `food` */

DROP TABLE IF EXISTS `food`;

CREATE TABLE `food` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '食物主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '食物名称',
  `Cover` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  `FoodTypeId` int DEFAULT NULL COMMENT '食物类型',
  `Calories` double(20,8) DEFAULT NULL COMMENT '热量',
  `Protein` double(20,8) DEFAULT NULL COMMENT '蛋白质',
  `Carbohydrates` double(20,8) DEFAULT NULL COMMENT '糖水化合物',
  `Fat` double(20,8) DEFAULT NULL COMMENT '脂肪',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `FoodTypeId` (`FoodTypeId`) USING BTREE,
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`FoodTypeId`) REFERENCES `foodtype` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='食物表';

/*Data for the table `food` */

insert  into `food`(`Id`,`CreationTime`,`Name`,`Cover`,`FoodTypeId`,`Calories`,`Protein`,`Carbohydrates`,`Fat`) values (1,'2025-10-29 15:49:44','白米饭','http://localhost:7245/520597902/0.jpg',1,1.16000000,0.02650000,0.25900000,0.01000000),(2,'2025-10-29 15:49:44','全麦面包','http://localhost:7245/403658766/0.jpg',1,2.46000000,0.08500000,0.41300000,0.03500000),(3,'2025-10-29 15:49:44','燕麦片','http://localhost:7245/615429339/0.jpg',1,0.15610000,0.00120000,0.00550000,0.00086000),(4,'2025-10-29 15:49:44','面条','http://localhost:7245/503705980/9258.jpg_wh860.jpg',1,1.38000000,0.04500000,0.28200000,0.00700000),(5,'2025-10-29 15:49:44','西兰花','http://localhost:7245/281803355/0.jpg',2,0.34000000,0.02800000,0.06600000,0.00400000),(6,'2025-10-29 15:49:44','胡萝卜','http://localhost:7245/252784128/1.jpg',2,0.41000000,0.00900000,0.09600000,0.00200000),(7,'2025-10-29 15:49:44','菠菜','http://localhost:7245/738682644/1.jpg',2,0.23000000,0.02900000,0.03600000,0.00400000),(8,'2025-10-29 15:49:44','番茄','http://localhost:7245/92020754/34599220_184700067104_2.jpg',2,0.18000000,0.00900000,0.03900000,0.00200000),(9,'2025-10-29 15:49:44','苹果','http://localhost:7245/611104701/3.jpg',3,0.52000000,0.00300000,0.13800000,0.00200000),(10,'2025-10-29 15:49:44','香蕉','http://localhost:7245/235794952/0.jpg',3,0.89000000,0.01100000,0.22800000,0.00300000),(11,'2025-10-29 15:49:44','橙子','http://localhost:7245/614436376/1.jpg',3,0.47000000,0.00900000,0.11800000,0.00100000),(12,'2025-10-29 15:49:44','草莓','http://localhost:7245/979591374/5254.jpg_wh860.jpg',3,0.32000000,0.00700000,0.07700000,0.00300000),(13,'2025-10-29 15:49:44','鸡胸肉','http://localhost:7245/866647149/2.jpg',4,1.65000000,0.31000000,0.00000000,0.03600000),(14,'2025-10-29 15:49:44','牛肉','http://localhost:7245/496011459/0049.jpg_wh860.jpg',4,2.50000000,0.26000000,0.00000000,0.15000000),(15,'2025-10-29 15:49:44','猪肉','http://localhost:7245/578884240/0.jpg',4,2.42000000,0.25000000,0.00000000,0.14000000),(16,'2025-10-29 15:49:44','三文鱼','http://localhost:7245/471255669/0.jpg',4,2.08000000,0.20000000,0.00000000,0.13000000),(17,'2025-10-29 15:49:44','鸡蛋','http://localhost:7245/219715542/1.jpg',5,1.55000000,0.13000000,0.01100000,0.11000000),(18,'2025-10-29 15:49:44','牛奶','http://localhost:7245/689816223/1.jpg',5,0.61000000,0.03200000,0.04800000,0.03300000),(19,'2025-10-29 15:49:44','酸奶','http://localhost:7245/939569687/7.jpg',5,0.59000000,0.03300000,0.03600000,0.03200000),(20,'2025-10-29 15:49:44','奶酪','http://localhost:7245/524296852/2947.jpg_wh860.jpg',5,4.02000000,0.25000000,0.01300000,0.33000000),(21,'2025-10-29 15:49:44','豆腐','http://localhost:7245/110764414/0.jpg',6,0.76000000,0.08100000,0.01900000,0.04200000),(22,'2025-10-29 15:49:44','豆浆','http://localhost:7245/663718641/5558.jpg_wh860.jpg',6,0.33000000,0.02900000,0.02400000,0.01600000),(23,'2025-10-29 15:49:44','毛豆','http://localhost:7245/162827450/2971.jpg_wh860.jpg',6,1.31000000,0.13100000,0.10500000,0.05200000),(24,'2025-10-29 15:49:44','杏仁','http://localhost:7245/998652480/0.jpg',7,5.78000000,0.21200000,0.21700000,0.49400000),(25,'2025-10-29 15:49:44','核桃','http://localhost:7245/107095725/1.jpg',7,6.54000000,0.15200000,0.13700000,0.65200000),(26,'2025-10-29 15:49:44','花生','http://localhost:7245/75392590/14083847_144801445000_2.jpg',7,5.67000000,0.25800000,0.16100000,0.49200000),(27,'2025-10-29 15:49:44','橙汁','http://localhost:7245/211866371/9483.jpg_wh860.jpg',8,0.45000000,0.00700000,0.10400000,0.00200000),(28,'2025-10-29 15:49:44','绿茶','http://localhost:7245/157698696/1.jpg',8,0.01000000,0.00200000,0.00300000,0.00000000),(29,'2025-10-29 15:49:44','咖啡','http://localhost:7245/967617704/6199.jpg_wh860.jpg',8,0.01000000,0.00100000,0.00000000,0.00000000);

/*Table structure for table `foodtype` */

DROP TABLE IF EXISTS `foodtype`;

CREATE TABLE `foodtype` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '食物类型主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `Sort` int DEFAULT NULL COMMENT '显示顺序',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='食物类型表';

/*Data for the table `foodtype` */

insert  into `foodtype`(`Id`,`CreationTime`,`Name`,`Sort`) values (1,'2025-10-29 15:49:44','主食类',1),(2,'2025-10-29 15:49:44','蔬菜类',2),(3,'2025-10-29 15:49:44','水果类',3),(4,'2025-10-29 15:49:44','肉类',4),(5,'2025-10-29 15:49:44','蛋奶类',5),(6,'2025-10-29 15:49:44','豆制品',6),(7,'2025-10-29 15:49:44','坚果类',7),(8,'2025-10-29 15:49:44','饮料类',8);

/*Table structure for table `foodunit` */

DROP TABLE IF EXISTS `foodunit`;

CREATE TABLE `foodunit` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '食物单位主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `FoodId` int DEFAULT NULL COMMENT '食物',
  `UnitName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '单位名称',
  `UnitValue` int DEFAULT NULL COMMENT '单位值',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `FoodId` (`FoodId`) USING BTREE,
  CONSTRAINT `foodunit_ibfk_1` FOREIGN KEY (`FoodId`) REFERENCES `food` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='食物单位表';

/*Data for the table `foodunit` */

insert  into `foodunit`(`Id`,`CreationTime`,`FoodId`,`UnitName`,`UnitValue`) values (1,'2025-10-29 15:50:00',1,'碗（小）',150),(2,'2025-10-29 15:50:00',1,'碗（大）',250),(3,'2025-10-29 15:50:00',1,'100克',100),(4,'2025-10-29 15:50:00',2,'片',35),(5,'2025-10-29 15:50:00',2,'个',70),(6,'2025-10-29 15:50:00',3,'杯（干）',40),(7,'2025-10-29 15:50:00',3,'份',50),(8,'2025-10-29 15:50:00',3,'小包',40),(9,'2025-10-29 15:50:00',4,'小份（干）',50),(10,'2025-10-29 15:50:00',4,'50克（干）',50),(11,'2025-10-29 15:50:00',5,'朵',80),(12,'2025-10-29 15:50:00',5,'份',100),(13,'2025-10-29 15:50:00',5,'碗（切块）',150),(14,'2025-10-29 15:50:00',6,'根（中）',20),(15,'2025-10-29 15:50:00',6,'份',100),(16,'2025-10-29 15:50:00',7,'把',50),(17,'2025-10-29 15:50:00',7,'碗（煮熟）',180),(18,'2025-10-29 15:50:00',8,'个（中）',150),(19,'2025-10-29 15:50:00',8,'克',100),(20,'2025-10-29 15:50:00',9,'个（中）',180),(21,'2025-10-29 15:50:00',9,'克',100),(22,'2025-10-29 15:50:00',10,'根（中）',120),(23,'2025-10-29 15:50:00',10,'100克',100),(24,'2025-10-29 15:50:00',11,'个（中）',130),(25,'2025-10-29 15:50:00',11,'片',20),(26,'2025-10-29 15:50:00',11,'100克',100),(27,'2025-10-29 15:50:00',12,'颗',15),(28,'2025-10-29 15:50:00',12,'碗',200),(29,'2025-10-29 15:50:00',12,'100克',100),(30,'2025-10-29 15:50:00',13,'块（小）',120),(31,'2025-10-29 15:50:00',13,'盘',150),(32,'2025-10-29 15:50:00',13,'100克',100),(33,'2025-10-29 15:50:00',14,'块',150),(34,'2025-10-29 15:50:00',14,'盘',80),(35,'2025-10-29 15:50:00',14,'100克',100),(36,'2025-10-29 15:50:00',15,'块',70),(37,'2025-10-29 15:50:00',15,'100克',100),(38,'2025-10-29 15:50:00',14,'盘',150),(39,'2025-10-29 15:50:00',16,'片',100),(40,'2025-10-29 15:50:00',16,'50克',50),(41,'2025-10-29 15:50:00',17,'个',50),(42,'2025-10-29 15:50:00',17,'克',100),(43,'2025-10-29 15:50:00',18,'杯（小）',200),(44,'2025-10-29 15:50:00',18,'杯（大）',250),(45,'2025-10-29 15:50:00',18,'毫升',100),(46,'2025-10-29 15:50:00',19,'杯（小）',150),(47,'2025-10-29 15:50:00',19,'克',100),(48,'2025-10-29 15:50:00',20,'片',20),(49,'2025-10-29 15:50:00',20,'克',100),(50,'2025-10-29 15:50:00',21,'块',180),(51,'2025-10-29 15:50:00',21,'克',100),(52,'2025-10-29 15:50:00',22,'杯',250),(53,'2025-10-29 15:50:00',22,'毫升',100),(54,'2025-10-29 15:50:00',23,'碗（带壳）',120),(55,'2025-10-29 15:50:00',23,'100克（豆仁）',100),(56,'2025-10-29 15:50:00',24,'粒',5),(57,'2025-10-29 15:50:00',24,'100克',100),(58,'2025-10-29 15:50:00',25,'个',15),(59,'2025-10-29 15:50:00',25,'100克',100),(60,'2025-10-29 15:50:00',26,'粒',2),(61,'2025-10-29 15:50:00',26,'100克',100),(62,'2025-10-29 15:50:00',27,'杯',200),(63,'2025-10-29 15:50:00',27,'毫升',100),(64,'2025-10-29 15:50:00',28,'杯',250),(65,'2025-10-29 15:50:00',28,'毫升',100),(66,'2025-10-29 15:50:00',29,'杯（小）',150),(67,'2025-10-29 15:50:00',29,'杯（大）',350);

/*Table structure for table `healtharticle` */

DROP TABLE IF EXISTS `healtharticle`;

CREATE TABLE `healtharticle` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '健康知识主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `HealthArticleTypeId` int DEFAULT NULL COMMENT '分类',
  `Cover` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  `PublishUserId` int DEFAULT NULL COMMENT '发布人',
  `Content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `ViewCount` int DEFAULT NULL COMMENT '浏览量',
  `AuditStatus` int DEFAULT NULL COMMENT '审核状态枚举(1:待审核,2:审核通过,3:审核失败)',
  `AuditTime` datetime DEFAULT NULL COMMENT '审核时间',
  `AuditUserId` int DEFAULT NULL COMMENT '审核人',
  `AuditReply` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审核回复',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `PublishUserId` (`PublishUserId`) USING BTREE,
  KEY `AuditUserId` (`AuditUserId`) USING BTREE,
  KEY `HealthArticleTypeId` (`HealthArticleTypeId`) USING BTREE,
  CONSTRAINT `healtharticle_ibfk_1` FOREIGN KEY (`PublishUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `healtharticle_ibfk_2` FOREIGN KEY (`AuditUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `healtharticle_ibfk_3` FOREIGN KEY (`HealthArticleTypeId`) REFERENCES `healtharticletype` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='健康知识表';

/*Data for the table `healtharticle` */

insert  into `healtharticle`(`Id`,`CreationTime`,`Title`,`HealthArticleTypeId`,`Cover`,`PublishUserId`,`Content`,`ViewCount`,`AuditStatus`,`AuditTime`,`AuditUserId`,`AuditReply`) values (1,'2025-09-18 17:00:00','科学饮食搭配：均衡营养的重要性',1,'http://localhost:7245/319786480/8.jpg',2,'<p>均衡营养是维持身体健康的基础。合理的饮食搭配应该包含碳水化合物、蛋白质、脂肪、维生素和矿物质等多种营养成分。</p><p>建议每日摄入：<br/>- 谷物类：250-400g<br/>- 蔬菜类：300-500g<br/>- 水果类：200-350g<br/>- 肉蛋类：120-200g<br/>- 奶类：300ml</p>',156,2,'2025-09-18 17:30:00',1,NULL),(2,'2025-09-18 17:05:00','有氧运动的健康益处及注意事项',2,'http://localhost:7245/259974475/6.jpg',2,'<p>有氧运动是指人体在氧气充分供应的情况下进行的体育锻炼，如跑步、游泳、骑车等。</p><p>主要益处包括：<br/>1. 增强心肺功能<br/>2. 提高新陈代谢<br/>3. 控制体重<br/>4. 改善睡眠质量<br/>5. 增强免疫力</p><p>运动时间建议每周150分钟中等强度运动。</p>',246,2,'2025-09-18 17:35:00',1,NULL),(3,'2025-09-18 17:10:00','糖尿病的预防与日常管理',3,'http://localhost:7245/588204342/7.jpg',2,'<p>糖尿病是一种慢性代谢性疾病，预防和管理至关重要。</p><p>预防措施：<br/>- 保持健康体重<br/>- 规律运动<br/>- 合理饮食<br/>- 定期体检</p><p>日常管理要点：<br/>- 监测血糖<br/>- 按时服药<br/>- 控制饮食<br/>- 适量运动<br/>- 定期复查</p>',188,2,'2025-09-18 17:40:00',1,NULL),(4,'2025-09-18 17:15:00','职场压力管理与心理调适',4,'http://localhost:7245/728344018/8.jpg',2,'<p>现代职场压力日益增大，学会有效的压力管理和心理调适非常重要。</p><p>压力管理技巧：<br/>1. 时间管理<br/>2. 设定合理目标<br/>3. 学会说\"不\"<br/>4. 寻求支持<br/>5. 放松技巧</p><p>心理调适方法：<br/>- 深呼吸练习<br/>- 冥想<br/>- 运动放松<br/>- 音乐疗法<br/>- 与朋友交流</p>',301,2,'2025-09-18 17:45:00',1,NULL),(5,'2025-09-18 17:20:00','优质睡眠的重要性及改善方法',5,'http://localhost:7245/427812113/0.jpg',2,'<p>睡眠是人体恢复和修复的重要过程，优质睡眠对身心健康至关重要。</p><p>睡眠不足的危害：<br/>- 免疫力下降<br/>- 记忆力减退<br/>- 情绪不稳定<br/>- 新陈代谢紊乱</p><p>改善睡眠的方法：<br/>- 规律作息<br/>- 睡前放松<br/>- 适宜环境<br/>- 避免刺激性食物<br/>- 限制电子设备使用</p>',322,2,'2025-11-07 10:49:26',1,'通过'),(6,'2025-09-18 17:25:00','中医养生之四季调理',6,'http://localhost:7245/490949313/2.jpg',2,'<p>中医强调\"天人合一\"，根据四季变化调理身体是传统养生智慧。</p><p>春季养生：<br/>- 养肝护肝<br/>- 适当运动<br/>- 调节情志</p><p>夏季养生：<br/>- 养心安神<br/>- 清热解暑<br/>- 适量出汗</p><p>秋季养生：<br/>- 润肺防燥<br/>- 早睡早起<br/>- 收敛神气</p><p>冬季养生：<br/>- 养肾藏精<br/>- 温补阳气<br/>- 避寒就温</p>',418,2,'2025-09-18 17:55:00',1,NULL),(7,'2025-09-18 17:30:00','女性月经期的健康护理',7,'http://localhost:7245/377615911/0.jpg',2,'<p>月经期是女性生理周期的重要组成部分，正确的护理有助于维护女性健康。</p><p>月经期护理要点：<br/>- 保持外阴清洁<br/>- 选择合适的卫生用品<br/>- 注意保暖<br/>- 适度休息<br/>- 避免剧烈运动</p><p>饮食建议：<br/>- 多吃温热食物<br/>- 补充铁质<br/>- 避免生冷食物<br/>- 适量补充维生素</p>',278,2,'2025-09-18 18:00:00',1,NULL),(8,'2025-09-18 17:35:00','儿童营养与健康成长',8,'http://localhost:7245/116412152/10.jpg',2,'<p>儿童期是生长发育的关键时期，合理的营养搭配对健康成长至关重要。</p><p>儿童营养需求：<br/>- 蛋白质：促进生长发育<br/>- 钙质：骨骼和牙齿发育<br/>- 维生素D：促进钙吸收<br/>- 铁质：预防贫血<br/>- 维生素A：视力发育</p><p>健康饮食习惯：<br/>- 定时定量<br/>- 多样化饮食<br/>- 少吃零食<br/>- 多喝水<br/>- 适量运动</p>',357,2,'2025-11-06 19:29:37',1,'通过'),(9,'2025-09-18 17:40:00','高血压的预防与控制',3,'http://localhost:7245/410124028/2.jpg',2,'<p>高血压是常见的心血管疾病，被称为\"无声的杀手\"，预防和控制非常重要。</p><p>预防措施：<br/>- 低盐饮食<br/>- 控制体重<br/>- 规律运动<br/>- 戒烟限酒<br/>- 减轻压力</p><p>日常控制：<br/>- 定期监测血压<br/>- 按时服药<br/>- 健康饮食<br/>- 适量运动<br/>- 保持良好心态</p>',192,2,'2025-09-18 18:10:00',1,NULL),(10,'2025-09-18 17:45:00','维生素D的重要性与补充方法',1,'http://localhost:7245/769775197/0.jpg',2,'<p>维生素D被称为\"阳光维生素\"，对骨骼健康、免疫功能等都有重要作用。</p><p>维生素D的作用：<br/>- 促进钙磷吸收<br/>- 维护骨骼健康<br/>- 调节免疫功能<br/>- 预防某些疾病</p><p>补充方法：<br/>- 适当日晒<br/>- 食物补充（鱼类、蛋黄等）<br/>- 维生素D补充剂<br/>- 强化食品</p>',302,2,'2025-09-18 22:09:35',1,'欧克'),(11,'2025-09-18 17:50:00','瑜伽练习的身心益处',2,'http://localhost:7245/510337014/0.jpg',2,'<p>瑜伽是一种古老的身心练习方式，结合体位、呼吸和冥想，带来全面的健康益处。</p><p>身体益处：<br/>- 增强柔韧性<br/>- 改善平衡感<br/>- 强化核心肌群<br/>- 缓解肌肉紧张<br/>- 改善姿态</p><p>心理益处：<br/>- 减轻压力<br/>- 改善情绪<br/>- 提高专注力<br/>- 促进放松<br/>- 增强自我意识</p>',198,2,'2025-09-18 22:37:54',1,'欧克'),(12,'2025-09-18 17:55:00','焦虑情绪的识别与应对',4,'http://localhost:7245/500552150/0.jpg',2,'<p>焦虑是现代人常见的心理问题，学会识别和应对焦虑情绪对心理健康很重要。</p><p>焦虑症状：<br/>- 过度担心<br/>- 紧张不安<br/>- 心跳加速<br/>- 呼吸困难<br/>- 睡眠问题</p><p>应对方法：<br/>- 深呼吸练习<br/>- 渐进性肌肉放松<br/>- 认知重构<br/>- 规律运动<br/>- 寻求专业帮助</p>',145,3,'2025-09-18 22:37:56',1,'欧克'),(13,'2025-09-18 18:00:00','戒烟的健康益处与方法',5,'http://localhost:7245/19294796/1.jpg',2,'<p>吸烟对健康危害极大，戒烟是改善健康最有效的方法之一。</p><p>戒烟益处：<br/>- 降低癌症风险<br/>- 改善心肺功能<br/>- 提高免疫力<br/>- 改善口气和牙齿<br/>- 节约金钱</p><p>戒烟方法：<br/>- 制定戒烟计划<br/>- 寻找替代活动<br/>- 避免诱因<br/>- 寻求支持<br/>- 考虑药物辅助</p>',224,2,'2025-09-18 22:37:59',1,'欧克'),(14,'2025-09-18 18:05:00','艾灸养生的原理与应用1',6,'http://localhost:7245/917508801/0.jpg',2,'<p>艾灸是中医传统疗法，通过燃烧艾草刺激穴位，达到调理身体的目的。</p><p>艾灸原理：</p><p>-&nbsp;温通经络</p><p>-&nbsp;调和气血</p><p>-&nbsp;扶正祛邪</p><p>-&nbsp;回阳救逆</p><p>常用穴位：</p><p>-&nbsp;足三里：强身健体</p><p>-&nbsp;关元：补肾壮阳</p><p>-&nbsp;神阙：调理脾胃</p><p>-&nbsp;大椎：预防感冒</p><p>注意事项：</p><p>-&nbsp;选择合适时间</p><p>-&nbsp;注意防火安全</p><p>-&nbsp;孕妇慎用</p>',168,2,'2025-09-18 22:38:01',1,'欧克'),(15,'2025-09-18 18:10:00','更年期女性的健康管理1',7,'http://localhost:7245/451510764/16.jpg',2,'<p>更年期是女性生命中的重要阶段，科学的健康管理有助于平稳度过这一时期。</p><p>更年期症状：</p><p>- 月经不规律</p><p>- 潮热出汗</p><p>- 情绪波动</p><p>- 睡眠问题</p><p>- 骨质疏松</p><p>健康管理：</p><p>- 均衡饮食</p><p>- 规律运动</p><p>- 心理调适</p><p>- 定期体检</p><p>- 必要时激素替代治疗</p>',250,2,'2025-09-18 22:38:03',1,'欧克'),(18,'2025-11-08 19:14:25','测试',8,'http://localhost:7245/657338450/6marGUOvQWGY26cb4edbbb447d13059343b2484cf6ab.jpg',2,'<p>小城市</p>',1,2,'2025-11-08 19:14:58',1,'欧克');

/*Table structure for table `healtharticletype` */

DROP TABLE IF EXISTS `healtharticletype`;

CREATE TABLE `healtharticletype` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '健康知识分类主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `Sort` int DEFAULT NULL COMMENT '显示顺序',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='健康知识分类表';

/*Data for the table `healtharticletype` */

insert  into `healtharticletype`(`Id`,`CreationTime`,`Name`,`Sort`) values (1,'2025-09-18 16:00:00','营养饮食',1),(2,'2025-09-18 16:01:00','运动健身',2),(3,'2025-09-18 16:02:00','疾病预防',3),(4,'2025-09-18 16:03:00','心理健康',4),(5,'2025-09-18 16:04:00','生活习惯',5),(6,'2025-09-18 16:05:00','中医养生',6),(7,'2025-09-18 16:06:00','女性健康',7),(8,'2025-09-18 16:07:00','儿童健康',8);

/*Table structure for table `healthindicator` */

DROP TABLE IF EXISTS `healthindicator`;

CREATE TABLE `healthindicator` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '健康指标主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '指标名称',
  `BelongUserId` int DEFAULT NULL COMMENT '所属人',
  `Content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '描述内容',
  `Cover` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  `IsComm` tinyint(1) DEFAULT NULL COMMENT '是否公用',
  `Threshold` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '阈值',
  `HealthIndicatorTypeId` int DEFAULT NULL COMMENT '指标归类',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `HealthIndicatorTypeId` (`HealthIndicatorTypeId`) USING BTREE,
  KEY `BelongUserId` (`BelongUserId`) USING BTREE,
  CONSTRAINT `healthindicator_ibfk_1` FOREIGN KEY (`HealthIndicatorTypeId`) REFERENCES `healthindicatortype` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `healthindicator_ibfk_2` FOREIGN KEY (`BelongUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='健康指标表';

/*Data for the table `healthindicator` */

insert  into `healthindicator`(`Id`,`CreationTime`,`Name`,`BelongUserId`,`Content`,`Cover`,`IsComm`,`Threshold`,`HealthIndicatorTypeId`) values (1,'2025-09-17 14:15:10','空腹血糖',1,'测量空腹状态下的血糖浓度，正常范围为3.9-6.1mmol/L','http://localhost:7245/14065116/居民画像_空腹血糖.png',1,'3.9-6.1',1),(2,'2025-09-17 14:15:11','餐后2小时血糖',1,'餐后2小时血糖浓度，正常应小于7.8mmol/L','http://localhost:7245/164981706/餐后血糖.png',1,'<7.8',1),(3,'2025-09-17 14:15:12','糖化血红蛋白',1,'反映近2-3个月平均血糖水平，正常范围4.0-6.0%','http://localhost:7245/980324809/糖化血红蛋白.png',1,'4.0-6.0',1),(10,'2025-09-17 14:15:20','身高',1,'身体的高度，单位厘米','http://localhost:7245/329875860/身高.png',1,'>0',2),(11,'2025-09-17 14:15:21','体重',1,'身体的重量，单位千克','http://localhost:7245/391186749/体重.png',1,'>0',2),(12,'2025-09-17 14:15:22','体温',1,'正常体温范围36.0-37.2℃','http://localhost:7245/400225390/体温计.png',1,'36.0-37.2',2),(13,'2025-09-17 14:15:23','BMI指数',1,'身体质量指数，正常范围18.5-23.9','http://localhost:7245/735864646/女童BMI指数.png',1,'18.5-23.9',2),(20,'2025-09-17 14:15:30','收缩压',1,'心脏收缩时的血压，正常范围90-140mmHg','http://localhost:7245/845319992/收缩压-舒张压.png',1,'90-140',3),(21,'2025-09-17 14:15:31','舒张压',1,'心脏舒张时的血压，正常范围60-90mmHg','http://localhost:7245/546415844/舒张压.png',1,'60-90',3),(30,'2025-09-17 14:15:40','总胆固醇',1,'血液中胆固醇总量，正常范围3.1-5.2mmol/L','http://localhost:7245/313050190/总胆固醇.png',1,'3.1-5.2',4),(31,'2025-09-17 14:15:41','甘油三酯',1,'血液中甘油三酯含量，正常范围0.45-1.69mmol/L','http://localhost:7245/997661853/甘油三酯.png',1,'0.45-1.69',4),(32,'2025-09-17 14:15:42','低密度脂蛋白',1,'坏胆固醇，正常范围<3.4mmol/L','http://localhost:7245/861150599/低密度脂蛋白.png',1,'<3.4',4),(33,'2025-09-17 14:15:43','高密度脂蛋白',1,'好胆固醇，正常范围>1.04mmol/L','http://localhost:7245/50950967/高密度脂蛋白.png',1,'>1.04',4),(40,'2025-09-17 14:15:50','静息心率',1,'安静状态下的心率，正常范围60-100次/分','http://localhost:7245/191674168/平均静息心率.png',1,'60-100',5),(41,'2025-09-17 14:15:51','运动心率',1,'运动时的心率，一般不超过220-年龄','http://localhost:7245/367154365/运动心率.png',1,'>80',5),(50,'2025-09-17 14:16:00','谷丙转氨酶',1,'ALT，正常范围7-40U/L','http://localhost:7245/207668167/谷丙转氨酶.png',1,'7-40',6),(51,'2025-09-17 14:16:01','谷草转氨酶',1,'AST，正常范围13-35U/L','http://localhost:7245/443387109/谷草转氨酶.png',1,'13-35',6),(52,'2025-09-17 14:16:02','总胆红素',1,'正常范围3.4-17.1μmol/L','http://localhost:7245/954686567/肝胆科 (1).png',1,'3.4-17.1',6),(60,'2025-09-17 14:16:10','血肌酐',1,'正常范围男性53-106μmol/L，女性44-97μmol/L','http://localhost:7245/895615856/血肌酐.png',1,'44-106',7),(61,'2025-09-17 14:16:11','血尿素氮',1,'正常范围2.9-8.2mmol/L','http://localhost:7245/769771736/产物纯化.png',1,'2.9-8.2',7),(62,'2025-09-17 14:16:12','尿酸',1,'正常范围男性150-416μmol/L，女性89-357μmol/L','http://localhost:7245/310898369/尿酸 svg.png',1,'89-416',7),(70,'2025-09-17 14:16:20','白细胞计数',1,'正常范围3.5-9.5×10^9/L','http://localhost:7245/321568698/WaterMeter.png',1,'3.5-9.5',8),(71,'2025-09-17 14:16:21','红细胞计数',1,'正常范围男性4.3-5.8×10^12/L，女性3.8-5.1×10^12/L','http://localhost:7245/685035095/红细胞.png',1,'3.8-5.8',8),(72,'2025-09-17 14:16:22','血红蛋白',1,'正常范围男性130-175g/L，女性115-150g/L','http://localhost:7245/931079264/血红蛋白.png',1,'115-175',8),(73,'2025-09-17 14:16:23','血小板计数',1,'正常范围125-350×10^9/L','http://localhost:7245/656661389/血小板计数.png',1,'125-350',8),(80,'2025-09-17 14:16:30','肺活量',1,'正常范围因年龄性别而异，一般2500-4000ml','http://localhost:7245/700181048/肺活量.png',1,'2500-4000',9),(81,'2025-09-17 14:16:31','血氧饱和度',1,'正常范围95-100%','http://localhost:7245/468831795/血氧饱和度.png',1,'95-100',9),(90,'2025-09-17 14:16:40','促甲状腺激素',1,'TSH，正常范围0.27-4.2mIU/L','http://localhost:7245/940825789/PH.png',1,'0.27-4.2',10),(91,'2025-09-17 14:16:41','游离甲状腺素',1,'FT4，正常范围12-22pmol/L','http://localhost:7245/895254848/Hexagon.png',1,'12-22',10),(92,'2025-09-17 14:16:42','游离三碘甲状腺原氨酸',1,'FT3，正常范围3.1-6.8pmol/L','http://localhost:7245/775280119/iconfont.png',1,'3.1-6.8',10),(93,'2025-09-17 14:17:00','钠离子',1,'血清钠，正常范围135-145mmol/L','http://localhost:7245/527398131/bf330df20abe78.jpeg',1,'135-145',11),(94,'2025-09-17 14:17:01','钾离子',1,'血清钾，正常范围3.5-5.5mmol/L','http://localhost:7245/907766237/钾离子.png',1,'3.5-5.5',11),(95,'2025-09-17 14:17:02','氯离子',1,'血清氯，正常范围98-106mmol/L','http://localhost:7245/179937857/氯离子.png',1,'98-106',11),(96,'2025-09-17 14:17:03','二氧化碳结合力',1,'反映碳酸氢根水平，正常范围22-29mmol/L','http://localhost:7245/71805980/可视化_二氧化碳.png',1,'22-29',11),(97,'2025-09-17 14:17:10','尿蛋白',1,'定性应为阴性（−）','http://localhost:7245/699787056/尿蛋白分析.png',1,'>0',12),(98,'2025-09-17 14:17:11','尿糖',1,'定性应为阴性（−）','http://localhost:7245/640617695/尿糖.png',1,'>0',12),(99,'2025-09-17 14:17:12','尿潜血',1,'定性应为阴性（−）','http://localhost:7245/387334241/健康-潜血.png',1,'>0',12),(100,'2025-09-17 14:17:13','尿比重',1,'正常范围1.015-1.025','http://localhost:7245/739233256/比重1.png',1,'1.015-1.025',12),(101,'2025-09-17 14:17:20','免疫球蛋白G',1,'IgG，正常范围7.0-16.0g/L','http://localhost:7245/754782943/免疫球蛋白+补体.png',1,'7.0-16.0',13),(102,'2025-09-17 14:17:21','免疫球蛋白A',1,'IgA，正常范围0.7-4.0g/L','http://localhost:7245/315594375/免疫球蛋白 (1).png',1,'0.7-4.0',13),(103,'2025-09-17 14:17:22','免疫球蛋白M',1,'IgM，正常范围0.4-2.3g/L','http://localhost:7245/228768492/免疫球蛋白.png',1,'0.4-2.3',13),(104,'2025-09-17 14:17:23','C反应蛋白',1,'CRP，正常<5mg/L','http://localhost:7245/985189710/C反应蛋白.png',1,'<5',13),(105,'2025-09-17 14:17:30','血清钙',1,'总钙，正常范围2.1-2.6mmol/L','http://localhost:7245/880702492/健康特质-钙.png',1,'2.1-2.6',14),(106,'2025-09-17 14:17:31','血清磷',1,'无机磷，正常范围0.81-1.45mmol/L','http://localhost:7245/102844321/血磷.png',1,'0.81-1.45',14),(107,'2025-09-17 14:17:32','碱性磷酸酶',1,'ALP，成人正常范围40-150U/L','http://localhost:7245/435443497/活性酶.png',1,'40-150',14),(112,'2025-09-17 14:17:50','维生素D(25-OH-D)',1,'25(OH)D，总体适宜20-50ng/mL','http://localhost:7245/22567226/005-d.png',1,'20-50',16),(113,'2025-09-17 14:17:51','维生素B12',1,'常见参考145-569pmol/L','http://localhost:7245/666152348/血浆维生素B12浓度.png',1,'145-569',16),(114,'2025-09-17 14:17:52','叶酸',1,'常见参考>3ng/mL','http://localhost:7245/82862410/叶酸.png',1,'>3',16),(115,'2025-09-17 14:18:00','体脂率（男）',1,'体脂百分比，成年男性10-20%','http://localhost:7245/669770895/25.png',1,'10-20',17),(116,'2025-09-17 14:18:01','基础代谢量',1,'BMR，单位kcal/d，个体相关无固定阈值','http://localhost:7245/717979317/基础代谢量.png',1,'>1600',17),(117,'2025-09-17 14:18:02','内脏脂肪等级',1,'常用等级1-10为正常','http://localhost:7245/708031285/内脏脂肪等级.png',1,'1-10',17),(121,'2025-10-16 14:42:16','体脂率（女）',1,'体脂百分比，\n女性18-28%为宜','http://localhost:7245/559871854/Hexagon.png',1,'18-28',17),(152,'2025-11-10 18:42:14','体重',2,'身体的重量，单位千克','http://localhost:7245/391186749/体重.png',0,'>0',35),(153,'2025-11-10 18:42:21','静息心率',2,'安静状态下的心率，正常范围60-100次/分','http://localhost:7245/191674168/平均静息心率.png',0,'60-100',36),(154,'2025-11-10 18:42:41','BMI指数',2,'身体质量指数，正常范围18.5-23.9','http://localhost:7245/735864646/女童BMI指数.png',0,'18.5-23.9',35),(155,'2025-11-10 18:49:30','血肌酐',2,'正常范围男性53-106μmol/L，女性44-97μmol/L','http://localhost:7245/895615856/血肌酐.png',0,'44-106',37),(156,'2025-11-11 13:12:47','空腹血糖',2,'测量空腹状态下的血糖浓度，正常范围为3.9-6.1mmol/L','http://localhost:7245/14065116/居民画像_空腹血糖.png',0,'3.9-6.1',38),(165,'2025-11-16 14:24:09','血红蛋白',2,'正常范围男性130-175g/L，女性115-150g/L','http://localhost:7245/931079264/血红蛋白.png',0,'115-175',46),(166,'2025-11-16 14:25:35','尿蛋白',2,'定性应为阴性（−）','http://localhost:7245/699787056/尿蛋白分析.png',0,'>0',47);

/*Table structure for table `healthindicatorrecord` */

DROP TABLE IF EXISTS `healthindicatorrecord`;

CREATE TABLE `healthindicatorrecord` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '健康指标记录主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `HealthIndicatorTypeId` int DEFAULT NULL COMMENT '指标分类',
  `HealthIndicatorId` int DEFAULT NULL COMMENT '健康指标',
  `RecordUserId` int DEFAULT NULL COMMENT '记录人',
  `RecordTime` datetime DEFAULT NULL COMMENT '记录时间',
  `RecordValue` double(20,8) DEFAULT NULL COMMENT '记录值',
  `IsAbnormity` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否异常',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `HealthIndicatorId` (`HealthIndicatorId`) USING BTREE,
  KEY `RecordUserId` (`RecordUserId`) USING BTREE,
  KEY `HealthIndicatorTypeId` (`HealthIndicatorTypeId`) USING BTREE,
  CONSTRAINT `healthindicatorrecord_ibfk_1` FOREIGN KEY (`HealthIndicatorId`) REFERENCES `healthindicator` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `healthindicatorrecord_ibfk_2` FOREIGN KEY (`RecordUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `healthindicatorrecord_ibfk_3` FOREIGN KEY (`HealthIndicatorTypeId`) REFERENCES `healthindicatortype` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='健康指标记录表';

/*Data for the table `healthindicatorrecord` */

insert  into `healthindicatorrecord`(`Id`,`CreationTime`,`HealthIndicatorTypeId`,`HealthIndicatorId`,`RecordUserId`,`RecordTime`,`RecordValue`,`IsAbnormity`) values (16,'2025-11-10 18:43:46',36,153,2,'2025-11-10 18:43:22',69.00000000,'N'),(17,'2025-11-10 18:43:46',35,10,2,'2025-11-10 18:43:22',170.00000000,'N'),(18,'2025-11-10 18:43:46',35,152,2,'2025-11-10 18:43:22',52.00000000,'N'),(20,'2025-11-10 18:51:34',37,155,2,'2025-11-10 18:51:20',98.00000000,'N'),(21,'2025-11-11 13:13:41',38,156,2,'2025-11-11 13:13:09',4.10000000,'N'),(23,'2025-11-11 13:13:41',35,10,2,'2025-11-11 13:13:09',170.00000000,'N'),(24,'2025-11-11 13:13:41',35,152,2,'2025-11-11 13:13:09',52.00000000,'N'),(28,'2025-11-11 14:29:52',37,155,2,'2025-11-11 14:29:44',92.00000000,'N'),(29,'2025-11-11 15:04:00',37,155,2,'2025-11-11 15:03:47',145.00000000,'Y'),(30,'2025-11-11 15:04:00',36,153,2,'2025-11-11 15:03:47',81.00000000,'N'),(31,'2025-11-11 15:36:23',36,153,2,'2025-11-11 15:36:10',66.00000000,'N'),(32,'2025-11-11 15:54:36',37,155,2,'2025-11-11 15:54:28',55.00000000,'N'),(33,'2025-11-11 15:56:40',38,156,2,'2025-11-11 15:56:18',5.00000000,'N'),(34,'2025-11-11 15:56:40',35,154,2,'2025-11-11 15:56:18',19.00000000,'N'),(35,'2025-11-11 15:56:40',35,152,2,'2025-11-11 15:56:18',56.00000000,'N'),(36,'2025-11-11 15:56:40',35,10,2,'2025-11-11 15:56:18',170.00000000,'N'),(37,'2025-11-12 10:26:19',38,156,2,'2025-11-12 10:25:58',4.30000000,'N'),(38,'2025-11-12 10:26:19',37,155,2,'2025-11-12 10:20:58',66.00000000,'N'),(39,'2025-11-12 10:26:19',36,153,2,'2025-11-12 10:25:58',83.00000000,'N'),(40,'2025-11-12 10:26:52',37,155,2,'2025-11-12 10:26:45',69.00000000,'N'),(41,'2025-11-12 11:36:27',37,155,2,'2025-11-12 11:36:20',56.00000000,'N'),(42,'2025-11-12 11:37:57',35,10,2,'2025-11-12 11:37:35',170.00000000,'N'),(43,'2025-11-12 11:37:57',35,152,2,'2025-11-12 11:37:35',53.00000000,'N'),(44,'2025-11-12 11:37:57',37,155,2,'2025-11-12 11:37:35',99.00000000,'N'),(45,'2025-11-12 11:40:47',37,155,2,'2025-11-12 11:40:39',100.00000000,'N'),(46,'2025-11-13 19:45:36',38,156,2,'2025-11-13 19:45:05',4.50000000,'N'),(47,'2025-11-13 19:45:36',35,10,2,'2025-11-13 19:45:05',170.00000000,'N'),(48,'2025-11-13 19:45:36',36,153,2,'2025-11-13 19:45:05',75.00000000,'N'),(49,'2025-11-13 19:45:36',37,155,2,'2025-11-13 19:45:05',89.00000000,'N'),(55,'2025-11-16 14:24:40',46,165,2,'2025-11-16 14:24:28',155.00000000,'N'),(56,'2025-11-16 14:25:56',47,166,2,'2025-11-16 14:25:45',1.00000000,'N'),(57,'2025-11-16 14:27:08',47,166,2,'2025-11-08 14:26:34',1.00000000,'N'),(58,'2025-11-16 14:27:08',46,165,2,'2025-11-08 14:26:34',160.00000000,'N'),(59,'2025-11-16 14:28:23',47,166,2,'2025-11-14 14:27:57',0.50000000,'N'),(60,'2025-11-16 14:28:23',46,165,2,'2025-11-14 14:27:57',158.00000000,'N'),(61,'2025-11-17 13:44:50',47,166,2,'2025-11-17 13:44:20',0.60000000,'N'),(62,'2025-11-17 13:44:50',38,156,2,'2025-11-17 13:44:20',4.00000000,'N'),(63,'2025-11-17 13:44:50',37,155,2,'2025-11-17 13:44:20',68.00000000,'N'),(64,'2025-11-17 13:44:50',36,153,2,'2025-11-17 13:44:20',76.00000000,'N'),(65,'2025-11-17 13:44:50',35,152,2,'2025-11-17 13:44:20',52.00000000,'N'),(66,'2025-11-18 14:55:55',37,155,2,'2025-11-18 14:55:45',89.00000000,'N'),(67,'2025-11-18 14:55:55',36,153,2,'2025-11-18 14:55:45',76.00000000,'N');

/*Table structure for table `healthindicatortype` */

DROP TABLE IF EXISTS `healthindicatortype`;

CREATE TABLE `healthindicatortype` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '健康指标分类主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `BelongUserId` int DEFAULT NULL COMMENT '所属人',
  `IsComm` tinyint(1) DEFAULT NULL COMMENT '是否公用',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `BelongUserId` (`BelongUserId`) USING BTREE,
  CONSTRAINT `healthindicatortype_ibfk_1` FOREIGN KEY (`BelongUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='健康指标分类表';

/*Data for the table `healthindicatortype` */

insert  into `healthindicatortype`(`Id`,`CreationTime`,`Name`,`BelongUserId`,`IsComm`) values (1,'2025-09-17 14:06:19','血糖',1,1),(2,'2025-09-17 14:06:40','基础指标',1,1),(3,'2025-09-17 14:14:12','血压',1,0),(4,'2025-09-17 14:14:16','血脂',1,0),(5,'2025-09-17 14:15:00','心率',1,1),(6,'2025-09-17 14:15:01','肝功能',1,1),(7,'2025-09-17 14:15:02','肾功能',1,1),(8,'2025-09-17 14:15:03','血常规',1,1),(9,'2025-09-17 14:15:04','呼吸系统',1,1),(10,'2025-09-17 14:15:05','内分泌',1,1),(11,'2025-09-17 14:16:50','电解质',1,1),(12,'2025-09-17 14:16:51','尿常规',1,1),(13,'2025-09-17 14:16:52','免疫功能',1,1),(14,'2025-09-17 14:16:53','骨代谢',1,1),(16,'2025-09-17 14:16:55','营养维生素',1,1),(17,'2025-09-17 14:16:56','体成分',1,1),(35,'2025-11-10 18:42:13','基础指标',2,0),(36,'2025-11-10 18:42:21','心率',2,0),(37,'2025-11-10 18:49:30','肾功能',2,0),(38,'2025-11-11 13:12:47','血糖',2,0),(46,'2025-11-16 14:24:09','血常规',2,0),(47,'2025-11-16 14:25:35','尿常规',2,0);

/*Table structure for table `healthnotice` */

DROP TABLE IF EXISTS `healthnotice`;

CREATE TABLE `healthnotice` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '健康提醒主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `PublishUserId` int DEFAULT NULL COMMENT '提醒人',
  `Content` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提醒内容',
  `Title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提醒标题',
  `Num` int DEFAULT NULL COMMENT '提醒次数',
  `RemindTime` datetime DEFAULT NULL COMMENT '提醒时间',
  `RemindType` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提醒方式',
  `IsRemind` tinyint(1) DEFAULT NULL COMMENT '是否提醒',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `PublishUserId` (`PublishUserId`) USING BTREE,
  CONSTRAINT `healthnotice_ibfk_1` FOREIGN KEY (`PublishUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='健康提醒表';

/*Data for the table `healthnotice` */

insert  into `healthnotice`(`Id`,`CreationTime`,`PublishUserId`,`Content`,`Title`,`Num`,`RemindTime`,`RemindType`,`IsRemind`) values (1,'2025-11-16 16:55:58',2,'测试','测试',1,'2025-11-16 20:36:57','邮件',1),(2,'2025-11-16 20:39:48',2,'cs','cs',1,'2025-11-16 20:41:26','邮件',1),(3,'2025-11-16 20:51:01',2,'xs','xs',1,'2025-11-16 20:51:45','邮件',1),(4,'2025-11-16 21:03:23',2,'ok','ok',1,'2025-11-17 12:01:03','邮件',1);

/*Table structure for table `likerecord` */

DROP TABLE IF EXISTS `likerecord`;

CREATE TABLE `likerecord` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '点赞记录主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `LikeUserId` int DEFAULT NULL COMMENT '点赞人',
  `LikeType` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '点赞类型',
  `RelativeId` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联Id',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `LikeUserId` (`LikeUserId`) USING BTREE,
  CONSTRAINT `likerecord_ibfk_1` FOREIGN KEY (`LikeUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='点赞记录表';

/*Data for the table `likerecord` */

insert  into `likerecord`(`Id`,`CreationTime`,`LikeUserId`,`LikeType`,`RelativeId`) values (1,'2025-11-09 10:49:04',2,'健康知识','15'),(5,'2025-11-09 10:59:20',2,'食谱','8'),(6,'2025-11-09 11:50:31',2,'食谱','6'),(7,'2025-11-09 13:15:13',2,'健康知识','13'),(8,'2025-11-09 13:15:26',2,'食谱','12');

/*Table structure for table `messagenotice` */

DROP TABLE IF EXISTS `messagenotice`;

CREATE TABLE `messagenotice` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '消息通知主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `RelationNo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联单号',
  `UserId` int DEFAULT NULL COMMENT '接受人',
  `ActualSendTime` datetime DEFAULT NULL COMMENT '实际发送时间',
  `Type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型',
  `TargetKey` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '目标',
  `Content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '通知内容',
  `IsSuccess` tinyint(1) DEFAULT NULL COMMENT '是否成功',
  `IsSend` tinyint(1) DEFAULT NULL COMMENT '是否发送',
  `Title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '通知标题',
  `PlanSendTime` datetime DEFAULT NULL COMMENT '计划发送时间',
  `ResultMsg` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送结果',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `UserId` (`UserId`) USING BTREE,
  CONSTRAINT `messagenotice_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='消息通知表';

/*Data for the table `messagenotice` */

insert  into `messagenotice`(`Id`,`CreationTime`,`RelationNo`,`UserId`,`ActualSendTime`,`Type`,`TargetKey`,`Content`,`IsSuccess`,`IsSend`,`Title`,`PlanSendTime`,`ResultMsg`) values (4,'2025-11-16 20:35:32','1',2,'2025-11-16 20:47:22','健康提醒','1317425625@qq.com','测试',1,1,'测试','2025-11-16 20:36:57','发送成功'),(5,'2025-11-16 20:39:48','2',2,'2025-11-16 20:47:23','健康提醒','1317425625@qq.com','cs',1,1,'cs','2025-11-16 20:41:26','发送成功'),(8,'2025-11-16 21:08:06','3',2,'2025-11-16 21:08:11','健康提醒','1317425625@qq.com','xs',1,1,'xs','2025-11-16 20:51:45','发送成功'),(9,'2025-11-17 12:00:24','4',2,'2025-11-17 12:01:12','健康提醒','1317425625@qq.com','ok',1,1,'ok','2025-11-17 12:01:03','发送成功');

/*Table structure for table `recipe` */

DROP TABLE IF EXISTS `recipe`;

CREATE TABLE `recipe` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '食谱主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `Cover` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  `ImageUrls` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '详细图',
  `Content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `ViewCount` int DEFAULT NULL COMMENT '浏览量',
  `VideoUrl` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频路径',
  `AuditUserId` int DEFAULT NULL COMMENT '审核人',
  `PublishUserId` int DEFAULT NULL COMMENT '发布人',
  `AuditTime` datetime DEFAULT NULL COMMENT '审核时间',
  `AuditStatus` int DEFAULT NULL COMMENT '审核状态枚举(1:待审核,2:审核通过,3:审核失败)',
  `AuditReply` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审核回复',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `PublishUserId` (`PublishUserId`) USING BTREE,
  KEY `AuditUserId` (`AuditUserId`) USING BTREE,
  CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`PublishUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`AuditUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='食谱表';

/*Data for the table `recipe` */

insert  into `recipe`(`Id`,`CreationTime`,`Title`,`Cover`,`ImageUrls`,`Content`,`ViewCount`,`VideoUrl`,`AuditUserId`,`PublishUserId`,`AuditTime`,`AuditStatus`,`AuditReply`) values (1,'2025-09-19 10:00:00','蒸蛋羹配时蔬','http://localhost:7245/103337687/0.jpg','http://localhost:7245/902754450/8.jpg,http://localhost:7245/598913973/14.jpg,http://localhost:7245/346098126/2.jpg','<p>营养丰富的蒸蛋羹，搭配新鲜时蔬，口感嫩滑，营养均衡。</p><p><strong>食材：</strong><br/>鸡蛋 2个<br/>西兰花 100g<br/>胡萝卜 50g<br/>香菇 3朵</p><p><strong>制作步骤：</strong><br/>1. 鸡蛋打散，加入温水搅拌均匀<br/>2. 过筛去泡沫，倒入蒸碗<br/>3. 蒸锅水开后放入，蒸10分钟<br/>4. 蔬菜焯水摆盘装饰</p>',246,'http://localhost:7245/recipe001/video.mp4',1,2,'2025-09-19 10:30:00',2,'营养搭配合理，制作简单'),(2,'2025-09-19 10:15:00','燕麦香蕉早餐杯','http://localhost:7245/63139665/0.jpg','http://localhost:7245/829362408/15.jpg,http://localhost:7245/900214172/1.jpg','<p>高纤维低脂的健康早餐，富含维生素和矿物质。</p><p><strong>食材：</strong><br/>燕麦片 50g<br/>香蕉 1根<br/>酸奶 100ml<br/>蓝莓 适量<br/>蜂蜜 1勺</p><p><strong>制作步骤：</strong><br/>1. 燕麦片用热水冲泡5分钟<br/>2. 香蕉切片铺底<br/>3. 倒入燕麦，加酸奶<br/>4. 撒上蓝莓，淋蜂蜜</p>',189,'http://localhost:7245/recipe002/video.mp4',1,2,'2025-09-19 10:45:00',2,'健康营养，适合减脂期'),(3,'2025-09-19 10:30:00','清蒸鲈鱼配柠檬','http://localhost:7245/615654493/0.jpg','http://localhost:7245/960520362/1.jpg,http://localhost:7245/306550710/17.jpg,http://localhost:7245/765209516/18.jpg,http://localhost:7245/416382145/8.jpg,http://localhost:7245/638052766/13.jpg','<p>高蛋白低脂肪的优质蛋白来源，肉质鲜嫩，营养价值高。</p><p><strong>食材：</strong><br/>鲈鱼 1条<br/>柠檬 半个<br/>生姜 3片<br/>葱丝 适量<br/>蒸鱼豉油 2勺</p><p><strong>制作步骤：</strong><br/>1. 鲈鱼洗净打花刀<br/>2. 鱼身塞姜片，淋料酒腌制<br/>3. 蒸锅水开后蒸8分钟<br/>4. 撒葱丝，淋蒸鱼豉油和柠檬汁</p>',317,'http://localhost:7245/recipe003/video.mp4',1,2,'2025-09-19 11:00:00',2,'制作精美，营养丰富'),(4,'2025-09-19 10:45:00','彩虹沙拉配坚果','http://localhost:7245/320306615/0.jpg','http://localhost:7245/698945553/1.jpg,http://localhost:7245/12594412/5.jpg,http://localhost:7245/973940562/8.jpg','<p>色彩丰富的蔬菜沙拉，富含维生素、纤维和健康脂肪。</p><p><strong>食材：</strong><br/>生菜 100g<br/>紫甘蓝 50g<br/>胡萝卜丝 50g<br/>圣女果 10个<br/>核桃仁 20g<br/>橄榄油醋汁 适量</p><p><strong>制作步骤：</strong><br/>1. 所有蔬菜洗净切好<br/>2. 圣女果对半切开<br/>3. 摆盘成彩虹色<br/>4. 撒坚果，淋沙拉汁</p>',156,'http://localhost:7245/recipe004/video.mp4',1,2,'2025-09-19 11:15:00',2,'颜值很高，营养全面'),(5,'2025-09-19 11:00:00','紫薯银耳羹','http://localhost:7245/927693796/0.jpg','http://localhost:7245/438134063/1.jpg,http://localhost:7245/356421221/9.jpg,http://localhost:7245/344531454/11.jpg','<p>养颜美容的甜品，富含胶原蛋白和花青素，口感Q弹香甜。</p><p><strong>食材：</strong><br/>紫薯 200g<br/>银耳 1朵<br/>冰糖 适量<br/>枸杞 10粒<br/>牛奶 100ml</p><p><strong>制作步骤：</strong><br/>1. 银耳提前泡发去根<br/>2. 紫薯蒸熟压成泥<br/>3. 银耳煮1小时至软糯<br/>4. 加紫薯泥和冰糖，撒枸杞</p>',278,'http://localhost:7245/recipe005/video.mp4',1,2,'2025-09-19 11:30:00',2,'口感丰富，营养价值高'),(6,'2025-09-19 11:15:00','鸡胸肉蔬菜卷','http://localhost:7245/4021745/0.jpg','http://localhost:7245/500405727/3.jpg,http://localhost:7245/931542465/15.jpg,http://localhost:7245/322609514/4.jpg','<p>高蛋白低卡路里的健身餐，口感丰富，制作简单。</p><p><strong>食材：</strong><br/>鸡胸肉 150g<br/>黄瓜 1根<br/>胡萝卜 1根<br/>紫菜片 2张<br/>黑胡椒 适量</p><p><strong>制作步骤：</strong><br/>1. 鸡胸肉煎至两面金黄<br/>2. 蔬菜切丝焯水<br/>3. 紫菜铺平，放鸡肉和蔬菜<br/>4. 卷紧切段，撒黑胡椒</p>',205,'http://localhost:7245/recipe006/video.mp4',1,2,'2025-09-19 11:45:00',2,'适合健身人群'),(7,'2025-09-19 11:30:00','山药排骨汤','http://localhost:7245/497402349/0.jpg','http://localhost:7245/837705811/1.jpg,http://localhost:7245/492312517/5.jpg,http://localhost:7245/907453233/2.jpg','<p>滋补养胃的经典汤品，营养丰富，适合全家享用。</p><p><strong>食材：</strong><br/>排骨 300g<br/>山药 200g<br/>胡萝卜 100g<br/>玉米 1根<br/>生姜 3片</p><p><strong>制作步骤：</strong><br/>1. 排骨焯水去血沫<br/>2. 山药去皮切段<br/>3. 所有食材放入砂锅<br/>4. 大火煮开转小火炖1.5小时</p>',331,'http://localhost:7245/recipe007/video.mp4',1,2,'2025-09-19 12:00:00',2,'汤品清香，营养滋补'),(8,'2025-09-19 11:45:00','藜麦蔬菜饭','http://localhost:7245/654433668/0.jpg','http://localhost:7245/29623850/1.jpg,http://localhost:7245/486295781/16.jpg,http://localhost:7245/758947705/7.jpg','<p>超级食物藜麦搭配时令蔬菜，营养密度极高的主食。</p><p><strong>食材：</strong><br/>藜麦 100g<br/>西兰花 100g<br/>玉米粒 50g<br/>豌豆 50g<br/>橄榄油 1勺</p><p><strong>制作步骤：</strong><br/>1. 藜麦淘洗干净煮15分钟<br/>2. 蔬菜分别焯水<br/>3. 热锅下橄榄油<br/>4. 倒入藜麦和蔬菜炒匀</p>',173,'http://localhost:7245/recipe008/video.mp4',1,2,'2025-09-19 12:15:00',2,'营养全面，口感丰富'),(9,'2025-09-19 12:00:00','蜂蜜柚子茶','http://localhost:7245/681062896/0.jpg','http://localhost:7245/886495544/1.jpg,http://localhost:7245/628836402/9.jpg,http://localhost:7245/215491834/11.jpg','<p>清香甘甜的养生茶饮，富含维生素C，具有润燥化痰的功效。</p><p><strong>食材：</strong></p><p>柚子 1个</p><p>蜂蜜 200g</p><p>冰糖 100g</p><p>盐 少许</p><p><strong>制作步骤：</strong></p><p>1. 柚子皮用盐搓洗干净</p><p>2. 柚子皮切丝，果肉剥出</p><p>3. 柚子皮煮10分钟去苦味</p><p>4. 加冰糖熬煮至浓稠，晾凉加蜂蜜</p>',293,'http://localhost:7245/761855498/20250202_143127.mp4',1,2,'2025-09-19 12:30:00',2,'制作精细，口感清香'),(10,'2025-09-19 12:15:00','牛油果吐司','http://localhost:7245/356731627/0.jpg','http://localhost:7245/409229195/1.jpg,http://localhost:7245/31277281/9.jpg,http://localhost:7245/890465082/7.jpg','<p>网红健康早餐，富含优质脂肪和蛋白质，颜值与营养并存。</p><p><strong>食材：</strong></p><p>全麦吐司&nbsp;2片</p><p>牛油果&nbsp;1个</p><p>鸡蛋&nbsp;1个</p><p>圣女果&nbsp;5个</p><p>黑胡椒&nbsp;适量</p><p><strong>制作步骤：</strong></p><p>1.&nbsp;吐司烤至微黄</p><p>2.&nbsp;牛油果压成泥，加黑胡椒</p><p>3.&nbsp;煎蛋至半熟</p><p>4.&nbsp;吐司涂牛油果泥，放煎蛋和圣女果</p>',263,'http://localhost:7245/861743283/8XwInJehoywb0de349738adebac72b84e62def78f1b6.mp4',1,2,'2025-09-19 12:45:00',2,'颜值很高，营养丰富'),(12,'2025-11-08 19:30:08','测试食谱','http://localhost:7245/125698900/AQaxNh0xRKQU4d16e703bd0fad657c4fdb09ad2a02fd.jpg','http://localhost:7245/940082247/XLnIyjUs8Yjfaf577c6d589618de282e2c204d4be0d5.jpg','<p>我的食谱</p>',11,'http://localhost:7245/135525272/SqhnNV70tm457197db2a2762c81817ce8a922a79701c.mp4',NULL,2,NULL,1,NULL);

/*Table structure for table `sport` */

DROP TABLE IF EXISTS `sport`;

CREATE TABLE `sport` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '运动参考主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '运动名称',
  `Cover` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  `Content` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '介绍',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='运动参考表';

/*Data for the table `sport` */

insert  into `sport`(`Id`,`CreationTime`,`Name`,`Cover`,`Content`) values (1,'2025-09-18 16:00:00','跑步','http://localhost:7245/982824809/跑步.png','有氧运动，能够有效提高心肺功能，燃烧脂肪，增强体质'),(2,'2025-09-18 16:01:00','游泳','http://localhost:7245/255021152/游泳圈.png','全身运动，对关节冲击小，能锻炼全身肌群，提高心肺功能'),(3,'2025-09-18 16:02:00','骑行','http://localhost:7245/272026626/骑行.png','低冲击有氧运动，能够锻炼下肢肌肉，提高心血管健康'),(4,'2025-09-18 16:03:00','健身房器械训练','http://localhost:7245/511657570/Weight Bench.png','力量训练，能够增加肌肉量，提高基础代谢率'),(5,'2025-09-18 16:04:00','瑜伽','http://localhost:7245/32025750/瑜伽.png','柔韧性训练，能够改善身体柔韧性，减压放松，增强身心平衡'),(6,'2025-09-18 16:05:00','篮球','http://localhost:7245/701479851/篮球.png','团体运动，能够锻炼协调性，提高心肺功能和反应能力'),(7,'2025-09-18 16:06:00','羽毛球','http://localhost:7245/299919856/羽毛球.png','球类运动，能够锻炼手眼协调，提高反应速度和敏捷性'),(8,'2025-09-18 16:07:00','乒乓球','http://localhost:7245/363257858/乒乓球.png','技巧性运动，能够锻炼专注力，提高手眼协调和反应能力'),(9,'2025-09-18 16:08:00','爬山','http://localhost:7245/251099705/爬山.png','户外有氧运动，能够锻炼下肢力量，提高心肺功能，享受自然'),(10,'2025-09-18 16:09:00','快走','http://localhost:7245/716647906/快走.png','低强度有氧运动，适合初学者，能够改善心血管健康'),(11,'2025-09-18 16:10:00','跳绳','http://localhost:7245/463585319/跳绳.png','高效燃脂运动，能够快速提高心率，锻炼协调性'),(12,'2025-09-18 16:11:00','太极拳','http://localhost:7245/194204675/太极拳.png','传统运动，动作缓慢优美，能够改善平衡力，适合中老年人'),(13,'2025-09-18 16:12:00','广场舞','http://localhost:7245/904546071/跳广场舞.png','群体运动，结合音乐和舞蹈，能够锻炼协调性，增进社交'),(14,'2025-09-18 16:13:00','仰卧起坐','http://localhost:7245/208716650/仰卧起坐.png','核心力量训练，主要锻炼腹部肌肉，改善核心稳定性'),(15,'2025-09-18 16:14:00','俯卧撑','http://localhost:7245/494045951/俯卧撑.png','上肢力量训练，主要锻炼胸肌、肩膀和三头肌');

/*Table structure for table `sportrecord` */

DROP TABLE IF EXISTS `sportrecord`;

CREATE TABLE `sportrecord` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '运动记录主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `SportId` int DEFAULT NULL COMMENT '运动',
  `SportUnitId` int DEFAULT NULL COMMENT '运动单位',
  `RecordUserId` int DEFAULT NULL COMMENT '记录人',
  `RecordTime` datetime DEFAULT NULL COMMENT '记录时间',
  `RecordValue` int DEFAULT NULL COMMENT '记录值',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `RecordUserId` (`RecordUserId`) USING BTREE,
  KEY `SportId` (`SportId`) USING BTREE,
  KEY `SportUnitId` (`SportUnitId`) USING BTREE,
  CONSTRAINT `sportrecord_ibfk_1` FOREIGN KEY (`RecordUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `sportrecord_ibfk_2` FOREIGN KEY (`SportId`) REFERENCES `sport` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `sportrecord_ibfk_3` FOREIGN KEY (`SportUnitId`) REFERENCES `sportunit` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='运动记录表';

/*Data for the table `sportrecord` */

insert  into `sportrecord`(`Id`,`CreationTime`,`SportId`,`SportUnitId`,`RecordUserId`,`RecordTime`,`RecordValue`) values (9,'2025-11-05 16:01:19',1,37,2,'2025-11-05 16:01:08',66),(10,'2025-11-05 16:17:29',3,24,2,'2025-11-05 16:17:26',15),(14,'2025-11-06 11:38:31',4,22,2,'2025-11-06 11:38:29',1),(17,'2025-11-09 15:12:32',1,2,2,'2025-11-09 15:12:26',10),(26,'2025-11-16 14:14:53',2,37,2,'2025-11-16 14:14:44',40),(27,'2025-11-16 14:15:08',4,36,2,'2025-11-16 14:14:58',25),(29,'2025-11-16 14:30:54',4,35,2,'2025-11-16 14:30:46',40),(30,'2025-11-17 11:57:46',15,36,2,'2025-11-17 11:57:39',30),(32,'2025-11-17 13:45:27',4,37,2,'2025-11-17 13:45:14',30),(34,'2025-11-18 14:36:41',6,18,2,'2025-11-18 14:36:38',1),(35,'2025-11-18 14:36:52',6,37,2,'2025-11-18 14:36:43',60),(36,'2025-11-18 14:52:43',12,28,2,'2025-11-18 14:52:36',40);

/*Table structure for table `sportunit` */

DROP TABLE IF EXISTS `sportunit`;

CREATE TABLE `sportunit` (
  `Id` int NOT NULL AUTO_INCREMENT COMMENT '运动单位主键',
  `CreationTime` datetime DEFAULT NULL COMMENT '创建时间',
  `SportId` int DEFAULT NULL COMMENT '运动',
  `UnitName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '单位名称',
  `UnitValue` double(20,8) DEFAULT NULL COMMENT '单位值',
  `Calories` double(20,8) DEFAULT NULL COMMENT '热量',
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `SportId` (`SportId`) USING BTREE,
  CONSTRAINT `sportunit_ibfk_1` FOREIGN KEY (`SportId`) REFERENCES `sport` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='运动单位表';

/*Data for the table `sportunit` */

insert  into `sportunit`(`Id`,`CreationTime`,`SportId`,`UnitName`,`UnitValue`,`Calories`) values (1,'2025-09-18 16:15:00',1,'分钟',1.00000000,10.50000000),(2,'2025-09-18 16:16:00',1,'公里',1.00000000,70.00000000),(3,'2025-09-18 16:17:00',1,'小时',1.00000000,630.00000000),(4,'2025-09-18 16:18:00',2,'分钟',1.00000000,12.00000000),(5,'2025-09-18 16:19:00',2,'圈',50.00000000,25.00000000),(6,'2025-09-18 16:20:00',2,'小时',1.00000000,720.00000000),(7,'2025-09-18 16:21:00',3,'分钟',1.00000000,8.50000000),(8,'2025-09-18 16:22:00',3,'公里',1.00000000,35.00000000),(9,'2025-09-18 16:23:00',3,'小时',1.00000000,510.00000000),(10,'2025-09-18 16:24:00',4,'分钟',1.00000000,6.00000000),(11,'2025-09-18 16:25:00',4,'组',1.00000000,15.00000000),(12,'2025-09-18 16:26:00',4,'小时',1.00000000,360.00000000),(13,'2025-09-18 16:27:00',5,'分钟',1.00000000,3.50000000),(14,'2025-09-18 16:28:00',5,'节课',60.00000000,210.00000000),(15,'2025-09-18 16:29:00',6,'分钟',1.00000000,9.00000000),(16,'2025-09-18 16:30:00',6,'场',48.00000000,432.00000000),(17,'2025-09-18 16:31:00',7,'分钟',1.00000000,7.50000000),(18,'2025-09-18 16:32:00',7,'场',30.00000000,225.00000000),(19,'2025-09-18 16:33:00',8,'分钟',1.00000000,5.50000000),(20,'2025-09-18 16:34:00',8,'场',30.00000000,165.00000000),(21,'2025-09-18 16:35:00',9,'分钟',1.00000000,11.00000000),(22,'2025-09-18 16:36:00',9,'小时',1.00000000,660.00000000),(23,'2025-09-18 16:37:00',10,'分钟',1.00000000,4.50000000),(24,'2025-09-18 16:38:00',10,'公里',1.00000000,45.00000000),(25,'2025-09-18 16:39:00',10,'步数',1000.00000000,35.00000000),(26,'2025-09-18 16:40:00',11,'分钟',1.00000000,12.50000000),(27,'2025-09-18 16:41:00',11,'次',100.00000000,15.00000000),(28,'2025-09-18 16:42:00',12,'分钟',1.00000000,3.00000000),(29,'2025-09-18 16:43:00',12,'套',20.00000000,60.00000000),(30,'2025-09-18 16:44:00',13,'分钟',1.00000000,4.00000000),(31,'2025-09-18 16:45:00',13,'支舞',5.00000000,20.00000000),(32,'2025-09-18 16:46:00',14,'个',1.00000000,0.50000000),(33,'2025-09-18 16:47:00',14,'组',20.00000000,10.00000000),(34,'2025-09-18 16:48:00',14,'分钟',1.00000000,5.00000000),(35,'2025-09-18 16:49:00',15,'个',1.00000000,0.60000000),(36,'2025-09-18 16:50:00',15,'组',15.00000000,9.00000000),(37,'2025-09-18 16:51:00',15,'分钟',1.00000000,6.00000000);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


