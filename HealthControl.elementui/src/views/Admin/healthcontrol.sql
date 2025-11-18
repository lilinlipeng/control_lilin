CREATE DATABASE IF NOT EXISTS HealthControl;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `AppUser`;
CREATE TABLE IF NOT EXISTS `AppUser`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '用户主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `UserName` VARCHAR(20) NULL COMMENT '账号' ,
        `Email` VARCHAR(128) NULL COMMENT '邮箱' ,
        `Name` VARCHAR(128) NULL COMMENT '名称' ,
        `Birth` DATETIME NULL COMMENT '出生年月' ,
        `PhoneNumber` VARCHAR(20) NULL COMMENT '手机号码' ,
        `RoleType` INT NULL COMMENT '角色' ,
        `ImageUrls` VARCHAR(128) NULL COMMENT '头像' ,
        `Password` VARCHAR(60) NULL COMMENT '密码' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='用户表';

DROP TABLE IF EXISTS `CollectRecord`;
CREATE TABLE IF NOT EXISTS `CollectRecord`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '收藏记录主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `CollectUserId` INT NULL COMMENT '收藏人' ,
        `CollectType` VARCHAR(128) NULL COMMENT '收藏类型' ,
        `RelativeId` INT NULL COMMENT '关联资源Id' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='收藏记录表';

DROP TABLE IF EXISTS `DietRecord`;
CREATE TABLE IF NOT EXISTS `DietRecord`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '饮食记录主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `FoodId` INT NULL COMMENT '记录食物' ,
        `RecordUserId` INT NULL COMMENT '记录人' ,
        `FoodUnitId` INT NULL COMMENT '食物单位' ,
        `RecordTime` DATETIME NULL COMMENT '记录时间' ,
        `RecordValue` INT NULL COMMENT '记录值' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='饮食记录表';

DROP TABLE IF EXISTS `Food`;
CREATE TABLE IF NOT EXISTS `Food`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '食物主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `Name` VARCHAR(128) NULL COMMENT '食物名称' ,
        `Cover` VARCHAR(128) NULL COMMENT '封面' ,
        `FoodTypeId` INT NULL COMMENT '食物类型' ,
        `Calories` DOUBLE(20,8) NULL COMMENT '热量' ,
        `Protein` DOUBLE(20,8) NULL COMMENT '蛋白质' ,
        `Carbohydrates` DOUBLE(20,8) NULL COMMENT '糖水化合物' ,
        `Fat` DOUBLE(20,8) NULL COMMENT '脂肪' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='食物表';

DROP TABLE IF EXISTS `FoodType`;
CREATE TABLE IF NOT EXISTS `FoodType`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '食物类型主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `Name` VARCHAR(128) NULL COMMENT '分类名称' ,
        `Sort` INT NULL COMMENT '显示顺序' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='食物类型表';

DROP TABLE IF EXISTS `FoodUnit`;
CREATE TABLE IF NOT EXISTS `FoodUnit`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '食物单位主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `FoodId` INT NULL COMMENT '食物' ,
        `UnitName` VARCHAR(128) NULL COMMENT '单位名称' ,
        `UnitValue` INT NULL COMMENT '单位值' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='食物单位表';

DROP TABLE IF EXISTS `HealthArticle`;
CREATE TABLE IF NOT EXISTS `HealthArticle`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '健康知识主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `Title` VARCHAR(128) NULL COMMENT '标题' ,
        `HealthArticleTypeId` INT NULL COMMENT '分类' ,
        `Cover` VARCHAR(128) NULL COMMENT '封面' ,
        `PublishUserId` INT NULL COMMENT '发布人' ,
        `Content` LONGTEXT  NULL COMMENT '内容' ,
        `ViewCount` INT NULL COMMENT '浏览量' ,
        `AuditStatus` INT NULL COMMENT '审核状态枚举(1:待审核,2:审核通过,3:审核失败)' ,
        `AuditTime` DATETIME NULL COMMENT '审核时间' ,
        `AuditUserId` INT NULL COMMENT '审核人' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='健康知识表';

DROP TABLE IF EXISTS `HealthArticleType`;
CREATE TABLE IF NOT EXISTS `HealthArticleType`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '健康知识分类主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `Name` VARCHAR(128) NULL COMMENT '分类名称' ,
        `Sort` INT NULL COMMENT '显示顺序' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='健康知识分类表';

DROP TABLE IF EXISTS `HealthIndicator`;
CREATE TABLE IF NOT EXISTS `HealthIndicator`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '健康指标主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `Name` VARCHAR(128) NULL COMMENT '指标名称' ,
        `BelongUserId` INT NULL COMMENT '所属人' ,
        `Content` LONGTEXT  NULL COMMENT '描述内容' ,
        `Cover` VARCHAR(128) NULL COMMENT '封面' ,
        `IsComm` TINYINT(1) NULL COMMENT '是否公用' ,
        `Threshold` VARCHAR(128) NULL COMMENT '阈值' ,
        `HealthIndicatorTypeId` INT NULL COMMENT '指标归类' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='健康指标表';

DROP TABLE IF EXISTS `HealthIndicatorRecord`;
CREATE TABLE IF NOT EXISTS `HealthIndicatorRecord`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '健康指标记录主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `HealthIndicatorTypeId` INT NULL COMMENT '指标分类' ,
        `HealthIndicatorId` INT NULL COMMENT '健康指标' ,
        `RecordUserId` INT NULL COMMENT '记录人' ,
        `RecordTime` DATETIME NULL COMMENT '记录时间' ,
        `RecordValue` DOUBLE(20,8) NULL COMMENT '记录值' ,
        `IsAbnormity` VARCHAR(128) NULL COMMENT '是否异常' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='健康指标记录表';

DROP TABLE IF EXISTS `HealthIndicatorType`;
CREATE TABLE IF NOT EXISTS `HealthIndicatorType`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '健康指标分类主键',
        `CreationTime` DATETIME NULL COMMENT '创建时间',
        `Name` VARCHAR(128) NULL COMMENT '分类名称' ,
        `BelongUserId` INT NULL COMMENT '所属人' ,
        `IsComm` TINYINT(1) NULL COMMENT '是否公用' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='健康指标分类表';


-- ----------------------------
INSERT INTO `healthindicatortype` VALUES (1, '2025-09-17 14:06:19', '血糖', 1, 1);
INSERT INTO `healthindicatortype` VALUES (2, '2025-09-17 14:06:40', '基础指标', 1, 1);
INSERT INTO `healthindicatortype` VALUES (3, '2025-09-17 14:14:12', '血压', 1, 0);
INSERT INTO `healthindicatortype` VALUES (4, '2025-09-17 14:14:16', '血脂', 1, 0);
INSERT INTO `healthindicatortype` VALUES (5, '2025-09-17 14:15:00', '心率', 1, 1);
INSERT INTO `healthindicatortype` VALUES (6, '2025-09-17 14:15:01', '肝功能', 1, 1);
INSERT INTO `healthindicatortype` VALUES (7, '2025-09-17 14:15:02', '肾功能', 1, 1);
INSERT INTO `healthindicatortype` VALUES (8, '2025-09-17 14:15:03', '血常规', 1, 1);
INSERT INTO `healthindicatortype` VALUES (9, '2025-09-17 14:15:04', '呼吸系统', 1, 1);
INSERT INTO `healthindicatortype` VALUES (10, '2025-09-17 14:15:05', '内分泌', 1, 1);

-- 追加分类（用于完善未配指标的分类）
INSERT INTO `healthindicatortype` VALUES (11, '2025-09-17 14:16:50', '电解质', 1, 1);
INSERT INTO `healthindicatortype` VALUES (12, '2025-09-17 14:16:51', '尿常规', 1, 1);
INSERT INTO `healthindicatortype` VALUES (13, '2025-09-17 14:16:52', '免疫功能', 1, 1);
INSERT INTO `healthindicatortype` VALUES (14, '2025-09-17 14:16:53', '骨代谢', 1, 1);
INSERT INTO `healthindicatortype` VALUES (15, '2025-09-17 14:16:54', '肿瘤标志物', 1, 1);
INSERT INTO `healthindicatortype` VALUES (16, '2025-09-17 14:16:55', '营养维生素', 1, 1);
INSERT INTO `healthindicatortype` VALUES (17, '2025-09-17 14:16:56', '体成分', 1, 1);
INSERT INTO `healthindicatortype` VALUES (18, '2025-09-17 14:16:57', '生殖健康', 1, 1);

-- ----------------------------
-- Records of healthindicator
-- ----------------------------
-- 血糖指标
INSERT INTO `healthindicator` VALUES (1, '2025-09-17 14:15:10', '空腹血糖', 1, '测量空腹状态下的血糖浓度，正常范围为3.9-6.1mmol/L', NULL, 1, '3.9-6.1', 1);
INSERT INTO `healthindicator` VALUES (2, '2025-09-17 14:15:11', '餐后2小时血糖', 1, '餐后2小时血糖浓度，正常应小于7.8mmol/L', NULL, 1, '<7.8', 1);
INSERT INTO `healthindicator` VALUES (3, '2025-09-17 14:15:12', '糖化血红蛋白', 1, '反映近2-3个月平均血糖水平，正常范围4.0-6.0%', NULL, 1, '4.0-6.0', 1);

-- 基础指标
INSERT INTO `healthindicator` VALUES (10, '2025-09-17 14:15:20', '身高', 1, '身体的高度，单位厘米', NULL, 1, '>0', 2);
INSERT INTO `healthindicator` VALUES (11, '2025-09-17 14:15:21', '体重', 1, '身体的重量，单位千克', NULL, 1, '>0', 2);
INSERT INTO `healthindicator` VALUES (12, '2025-09-17 14:15:22', '体温', 1, '正常体温范围36.0-37.2℃', NULL, 1, '36.0-37.2', 2);
INSERT INTO `healthindicator` VALUES (13, '2025-09-17 14:15:23', 'BMI指数', 1, '身体质量指数，正常范围18.5-23.9', NULL, 1, '18.5-23.9', 2);

-- 血压指标
INSERT INTO `healthindicator` VALUES (20, '2025-09-17 14:15:30', '收缩压', 1, '心脏收缩时的血压，正常范围90-140mmHg', NULL, 1, '90-140', 3);
INSERT INTO `healthindicator` VALUES (21, '2025-09-17 14:15:31', '舒张压', 1, '心脏舒张时的血压，正常范围60-90mmHg', NULL, 1, '60-90', 3);

-- 血脂指标
INSERT INTO `healthindicator` VALUES (30, '2025-09-17 14:15:40', '总胆固醇', 1, '血液中胆固醇总量，正常范围3.1-5.2mmol/L', NULL, 1, '3.1-5.2', 4);
INSERT INTO `healthindicator` VALUES (31, '2025-09-17 14:15:41', '甘油三酯', 1, '血液中甘油三酯含量，正常范围0.45-1.69mmol/L', NULL, 1, '0.45-1.69', 4);
INSERT INTO `healthindicator` VALUES (32, '2025-09-17 14:15:42', '低密度脂蛋白', 1, '坏胆固醇，正常范围<3.4mmol/L', NULL, 1, '<3.4', 4);
INSERT INTO `healthindicator` VALUES (33, '2025-09-17 14:15:43', '高密度脂蛋白', 1, '好胆固醇，正常范围>1.04mmol/L', NULL, 1, '>1.04', 4);

-- 心率指标
INSERT INTO `healthindicator` VALUES (40, '2025-09-17 14:15:50', '静息心率', 1, '安静状态下的心率，正常范围60-100次/分', NULL, 1, '60-100', 5);
INSERT INTO `healthindicator` VALUES (41, '2025-09-17 14:15:51', '运动心率', 1, '运动时的心率，一般不超过220-年龄', NULL, 1, '根据年龄', 5);

-- 肝功能指标
INSERT INTO `healthindicator` VALUES (50, '2025-09-17 14:16:00', '谷丙转氨酶', 1, 'ALT，正常范围7-40U/L', NULL, 1, '7-40', 6);
INSERT INTO `healthindicator` VALUES (51, '2025-09-17 14:16:01', '谷草转氨酶', 1, 'AST，正常范围13-35U/L', NULL, 1, '13-35', 6);
INSERT INTO `healthindicator` VALUES (52, '2025-09-17 14:16:02', '总胆红素', 1, '正常范围3.4-17.1μmol/L', NULL, 1, '3.4-17.1', 6);

-- 肾功能指标
INSERT INTO `healthindicator` VALUES (60, '2025-09-17 14:16:10', '血肌酐', 1, '正常范围男性53-106μmol/L，女性44-97μmol/L', NULL, 1, '44-106', 7);
INSERT INTO `healthindicator` VALUES (61, '2025-09-17 14:16:11', '血尿素氮', 1, '正常范围2.9-8.2mmol/L', NULL, 1, '2.9-8.2', 7);
INSERT INTO `healthindicator` VALUES (62, '2025-09-17 14:16:12', '尿酸', 1, '正常范围男性150-416μmol/L，女性89-357μmol/L', NULL, 1, '89-416', 7);

-- 血常规指标
INSERT INTO `healthindicator` VALUES (70, '2025-09-17 14:16:20', '白细胞计数', 1, '正常范围3.5-9.5×10^9/L', NULL, 1, '3.5-9.5', 8);
INSERT INTO `healthindicator` VALUES (71, '2025-09-17 14:16:21', '红细胞计数', 1, '正常范围男性4.3-5.8×10^12/L，女性3.8-5.1×10^12/L', NULL, 1, '3.8-5.8', 8);
INSERT INTO `healthindicator` VALUES (72, '2025-09-17 14:16:22', '血红蛋白', 1, '正常范围男性130-175g/L，女性115-150g/L', NULL, 1, '115-175', 8);
INSERT INTO `healthindicator` VALUES (73, '2025-09-17 14:16:23', '血小板计数', 1, '正常范围125-350×10^9/L', NULL, 1, '125-350', 8);

-- 呼吸系统指标
INSERT INTO `healthindicator` VALUES (80, '2025-09-17 14:16:30', '肺活量', 1, '正常范围因年龄性别而异，一般2500-4000ml', NULL, 1, '2500-4000', 9);
INSERT INTO `healthindicator` VALUES (81, '2025-09-17 14:16:31', '血氧饱和度', 1, '正常范围95-100%', NULL, 1, '95-100', 9);

-- 内分泌指标
INSERT INTO `healthindicator` VALUES (90, '2025-09-17 14:16:40', '促甲状腺激素', 1, 'TSH，正常范围0.27-4.2mIU/L', NULL, 1, '0.27-4.2', 10);
INSERT INTO `healthindicator` VALUES (91, '2025-09-17 14:16:41', '游离甲状腺素', 1, 'FT4，正常范围12-22pmol/L', NULL, 1, '12-22', 10);
INSERT INTO `healthindicator` VALUES (92, '2025-09-17 14:16:42', '游离三碘甲状腺原氨酸', 1, 'FT3，正常范围3.1-6.8pmol/L', NULL, 1, '3.1-6.8', 10);

-- 电解质指标
INSERT INTO `healthindicator` VALUES (93, '2025-09-17 14:17:00', '钠离子', 1, '血清钠，正常范围135-145mmol/L', NULL, 1, '135-145', 11);
INSERT INTO `healthindicator` VALUES (94, '2025-09-17 14:17:01', '钾离子', 1, '血清钾，正常范围3.5-5.5mmol/L', NULL, 1, '3.5-5.5', 11);
INSERT INTO `healthindicator` VALUES (95, '2025-09-17 14:17:02', '氯离子', 1, '血清氯，正常范围98-106mmol/L', NULL, 1, '98-106', 11);
INSERT INTO `healthindicator` VALUES (96, '2025-09-17 14:17:03', '二氧化碳结合力', 1, '反映碳酸氢根水平，正常范围22-29mmol/L', NULL, 1, '22-29', 11);

-- 尿常规指标
INSERT INTO `healthindicator` VALUES (97, '2025-09-17 14:17:10', '尿蛋白', 1, '定性应为阴性（−）', NULL, 1, '阴性', 12);
INSERT INTO `healthindicator` VALUES (98, '2025-09-17 14:17:11', '尿糖', 1, '定性应为阴性（−）', NULL, 1, '阴性', 12);
INSERT INTO `healthindicator` VALUES (99, '2025-09-17 14:17:12', '尿潜血', 1, '定性应为阴性（−）', NULL, 1, '阴性', 12);
INSERT INTO `healthindicator` VALUES (100, '2025-09-17 14:17:13', '尿比重', 1, '正常范围1.015-1.025', NULL, 1, '1.015-1.025', 12);

-- 免疫功能指标
INSERT INTO `healthindicator` VALUES (101, '2025-09-17 14:17:20', '免疫球蛋白G', 1, 'IgG，正常范围7.0-16.0g/L', NULL, 1, '7.0-16.0', 13);
INSERT INTO `healthindicator` VALUES (102, '2025-09-17 14:17:21', '免疫球蛋白A', 1, 'IgA，正常范围0.7-4.0g/L', NULL, 1, '0.7-4.0', 13);
INSERT INTO `healthindicator` VALUES (103, '2025-09-17 14:17:22', '免疫球蛋白M', 1, 'IgM，正常范围0.4-2.3g/L', NULL, 1, '0.4-2.3', 13);
INSERT INTO `healthindicator` VALUES (104, '2025-09-17 14:17:23', 'C反应蛋白', 1, 'CRP，正常<5mg/L', NULL, 1, '<5', 13);

-- 骨代谢指标
INSERT INTO `healthindicator` VALUES (105, '2025-09-17 14:17:30', '血清钙', 1, '总钙，正常范围2.1-2.6mmol/L', NULL, 1, '2.1-2.6', 14);
INSERT INTO `healthindicator` VALUES (106, '2025-09-17 14:17:31', '血清磷', 1, '无机磷，正常范围0.81-1.45mmol/L', NULL, 1, '0.81-1.45', 14);
INSERT INTO `healthindicator` VALUES (107, '2025-09-17 14:17:32', '碱性磷酸酶', 1, 'ALP，成人正常范围40-150U/L', NULL, 1, '40-150', 14);

-- 肿瘤标志物（参考值因实验室而异，仅供筛查）
INSERT INTO `healthindicator` VALUES (108, '2025-09-17 14:17:40', '甲胎蛋白', 1, 'AFP，常见参考<20ng/mL', NULL, 1, '<20', 15);
INSERT INTO `healthindicator` VALUES (109, '2025-09-17 14:17:41', '癌胚抗原', 1, 'CEA，常见参考<5ng/mL', NULL, 1, '<5', 15);
INSERT INTO `healthindicator` VALUES (110, '2025-09-17 14:17:42', '糖类抗原CA125', 1, 'CA125，常见参考<35U/mL', NULL, 1, '<35', 15);
INSERT INTO `healthindicator` VALUES (111, '2025-09-17 14:17:43', '糖类抗原CA199', 1, 'CA19-9，常见参考<37U/mL', NULL, 1, '<37', 15);

-- 营养维生素
INSERT INTO `healthindicator` VALUES (112, '2025-09-17 14:17:50', '维生素D(25-OH-D)', 1, '25(OH)D，总体适宜20-50ng/mL', NULL, 1, '20-50', 16);
INSERT INTO `healthindicator` VALUES (113, '2025-09-17 14:17:51', '维生素B12', 1, '常见参考145-569pmol/L', NULL, 1, '145-569', 16);
INSERT INTO `healthindicator` VALUES (114, '2025-09-17 14:17:52', '叶酸', 1, '常见参考>3ng/mL', NULL, 1, '>3', 16);

-- 体成分
INSERT INTO `healthindicator` VALUES (115, '2025-09-17 14:18:00', '体脂率', 1, '体脂百分比，成年男性10-20%，女性18-28%为宜', NULL, 1, '男10-20%/女18-28%', 17);
INSERT INTO `healthindicator` VALUES (116, '2025-09-17 14:18:01', '基础代谢量', 1, 'BMR，单位kcal/d，个体相关无固定阈值', NULL, 1, '个体相关', 17);
INSERT INTO `healthindicator` VALUES (117, '2025-09-17 14:18:02', '内脏脂肪等级', 1, '常用等级1-10为正常', NULL, 1, '1-10', 17);

-- 生殖健康
INSERT INTO `healthindicator` VALUES (118, '2025-09-17 14:18:10', '促黄体生成素', 1, 'LH，成人男性1.7-8.6IU/L；女性卵泡期2.4-12.6IU/L', NULL, 1, '参考分性别与周期', 18);
INSERT INTO `healthindicator` VALUES (119, '2025-09-17 14:18:11', '促卵泡刺激素', 1, 'FSH，成人男性1.5-12.4IU/L；女性卵泡期3.5-12.5IU/L', NULL, 1, '参考分性别与周期', 18);
INSERT INTO `healthindicator` VALUES (120, '2025-09-17 14:18:12', '雌二醇', 1, 'E2，成年男性11-44pg/mL；女性随周期波动', NULL, 1, '参考分性别与周期', 18);


DROP TABLE IF EXISTS `HealthNotice`;
CREATE TABLE IF NOT EXISTS `HealthNotice`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '健康提醒主键',
        `CreationTime` datetime NULL COMMENT '创建时间',
        `PublishUserId` INT NULL COMMENT '提醒人' ,
        `Content` VARCHAR(128) NULL COMMENT '提醒内容' ,
        `Title` VARCHAR(128) NULL COMMENT '提醒标题' ,
        `Num` INT NULL COMMENT '提醒次数' ,
        `RemindTime` datetime NULL COMMENT '提醒时间' ,
        `RemindType` VARCHAR(128) NULL COMMENT '提醒方式' ,
        `IsRemind` TINYINT(1) NULL COMMENT '是否提醒' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='健康提醒表';

DROP TABLE IF EXISTS `LikeRecord`;
CREATE TABLE IF NOT EXISTS `LikeRecord`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '点赞记录主键',
        `CreationTime` datetime NULL COMMENT '创建时间',
        `LikeUserId` INT NULL COMMENT '点赞人' ,
        `LikeType` VARCHAR(128) NULL COMMENT '点赞类型' ,
        `RelativeId` VARCHAR(128) NULL COMMENT '关联Id' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='点赞记录表';

DROP TABLE IF EXISTS `MessageNotice`;
CREATE TABLE IF NOT EXISTS `MessageNotice`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '消息通知主键',
        `CreationTime` datetime NULL COMMENT '创建时间',
        `RelationNo` VARCHAR(128) NULL COMMENT '关联单号' ,
        `UserId` INT NULL COMMENT '接受人' ,
        `ActualSendTime` datetime NULL COMMENT '实际发送时间' ,
        `Type` VARCHAR(128) NULL COMMENT '类型' ,
        `TargetKey` VARCHAR(128) NULL COMMENT '目标' ,
        `Content` VARCHAR(1024) NULL COMMENT '通知内容' ,
        `IsSuccess` TINYINT(1) NULL COMMENT '是否成功' ,
        `IsSend` TINYINT(1) NULL COMMENT '是否发送' ,
        `Title` VARCHAR(128) NULL COMMENT '通知标题' ,
        `PlanSendTime` datetime NULL COMMENT '计划发送时间' ,
        `ResultMsg` VARCHAR(128) NULL COMMENT '发送结果' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='消息通知表';

DROP TABLE IF EXISTS `Recipe`;
CREATE TABLE IF NOT EXISTS `Recipe`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '食谱主键',
        `CreationTime` datetime NULL COMMENT '创建时间',
        `Title` VARCHAR(128) NULL COMMENT '标题' ,
        `Cover` VARCHAR(128) NULL COMMENT '封面' ,
        `ImageUrls` VARCHAR(128) NULL COMMENT '详细图' ,
        `Content` longtext  NULL COMMENT '内容' ,
        `ViewCount` INT NULL COMMENT '浏览量' ,
        `VideoUrl` VARCHAR(128) NULL COMMENT '视频路径' ,
        `AuditUserId` INT NULL COMMENT '审核人' ,
        `PublishUserId` INT NULL COMMENT '发布人' ,
        `AuditTime` datetime NULL COMMENT '审核时间' ,
        `AuditStatus` INT NULL COMMENT '审核状态枚举(1:待审核,2:审核通过,3:审核失败)' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='食谱表';

DROP TABLE IF EXISTS `Sport`;
CREATE TABLE IF NOT EXISTS `Sport`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '运动参考主键',
        `CreationTime` datetime NULL COMMENT '创建时间',
        `Name` VARCHAR(128) NULL COMMENT '运动名称' ,
        `Cover` VARCHAR(128) NULL COMMENT '封面' ,
        `Content` VARCHAR(128) NULL COMMENT '介绍' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='运动参考表';

DROP TABLE IF EXISTS `SportRecord`;
CREATE TABLE IF NOT EXISTS `SportRecord`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '运动记录主键',
        `CreationTime` datetime NULL COMMENT '创建时间',
        `SportId` INT NULL COMMENT '运动' ,
        `SportUnitId` INT NULL COMMENT '运动单位' ,
        `RecordUserId` INT NULL COMMENT '记录人' ,
        `RecordTime` INT NULL COMMENT '记录时间' ,
        `RecordValue` INT NULL COMMENT '记录值' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='运动记录表';

DROP TABLE IF EXISTS `SportUnit`;
CREATE TABLE IF NOT EXISTS `SportUnit`(
        `Id` INT AUTO_INCREMENT NOT NULL COMMENT '运动单位主键',
        `CreationTime` datetime NULL COMMENT '创建时间',
        `SportId` INT NULL COMMENT '运动' ,
        `UnitName` VARCHAR(128) NULL COMMENT '单位名称' ,
        `UnitValue` DOUBLE(20,8) NULL COMMENT '单位值' ,
        `Calories` DOUBLE(20,8) NULL COMMENT '热量' ,
 		 PRIMARY KEY (`Id`) USING BTREE
  
)ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT='运动单位表';





  ALTER TABLE `CollectRecord` ADD FOREIGN KEY (`CollectUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `DietRecord` ADD FOREIGN KEY (`RecordUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `DietRecord` ADD FOREIGN KEY (`FoodId`) REFERENCES `Food`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `DietRecord` ADD FOREIGN KEY (`FoodUnitId`) REFERENCES `FoodUnit`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `Food` ADD FOREIGN KEY (`FoodTypeId`) REFERENCES `FoodType`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `FoodUnit` ADD FOREIGN KEY (`FoodId`) REFERENCES `Food`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthArticle` ADD FOREIGN KEY (`PublishUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthArticle` ADD FOREIGN KEY (`AuditUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthArticle` ADD FOREIGN KEY (`HealthArticleTypeId`) REFERENCES `HealthArticleType`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthIndicator` ADD FOREIGN KEY (`HealthIndicatorTypeId`) REFERENCES `HealthIndicatorType`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthIndicator` ADD FOREIGN KEY (`BelongUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthIndicatorRecord` ADD FOREIGN KEY (`HealthIndicatorId`) REFERENCES `HealthIndicator`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthIndicatorRecord` ADD FOREIGN KEY (`RecordUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthIndicatorRecord` ADD FOREIGN KEY (`HealthIndicatorTypeId`) REFERENCES `HealthIndicatorType`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthIndicatorType` ADD FOREIGN KEY (`BelongUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `HealthNotice` ADD FOREIGN KEY (`PublishUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `LikeRecord` ADD FOREIGN KEY (`LikeUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `MessageNotice` ADD FOREIGN KEY (`UserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `Recipe` ADD FOREIGN KEY (`PublishUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `Recipe` ADD FOREIGN KEY (`AuditUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `SportRecord` ADD FOREIGN KEY (`RecordUserId`) REFERENCES `AppUser`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `SportRecord` ADD FOREIGN KEY (`SportId`) REFERENCES `Sport`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `SportRecord` ADD FOREIGN KEY (`SportUnitId`) REFERENCES `SportUnit`(`Id`) ON DELETE SET NULL;
  ALTER TABLE `SportUnit` ADD FOREIGN KEY (`SportId`) REFERENCES `Sport`(`Id`) ON DELETE SET NULL;

  INSERT INTO appuser
  (CreationTime, UserName,Password, RoleType, Name)
  VALUES(CURRENT_TIMESTAMP, 'admin','MD521232f297a57a5a743894a0e4a801fc3',1,'管理员');



