/*
 Navicat Premium Data Transfer

 Source Server         : mysql-jhz
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : topology

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 28/06/2023 23:46:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for node
-- ----------------------------
DROP TABLE IF EXISTS `node`;
CREATE TABLE `node` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '节点id',
  `name` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `type` int DEFAULT NULL COMMENT '0-router; 1-switch; 2-computer',
  `command` varchar(255) DEFAULT NULL,
  `topology_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of node
-- ----------------------------
BEGIN;
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `command`, `topology_id`) VALUES (1, 'RouterA', '192.168.12.1', 80, 0, NULL, 1);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `command`, `topology_id`) VALUES (2, 'SwitchB', '192.168.12.2', 79, 1, NULL, 1);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `command`, `topology_id`) VALUES (3, 'ComputerC', '192.168.12.3', 77, 2, NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `name` varchar(255) DEFAULT NULL COMMENT '任务名\n',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '任务描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of task
-- ----------------------------
BEGIN;
INSERT INTO `task` (`id`, `name`, `description`) VALUES (1, 'static拓扑配置', '连接静态拓扑');
INSERT INTO `task` (`id`, `name`, `description`) VALUES (2, 'rip', 'rip');
COMMIT;

-- ----------------------------
-- Table structure for topology
-- ----------------------------
DROP TABLE IF EXISTS `topology`;
CREATE TABLE `topology` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '拓扑id',
  `type` int DEFAULT NULL COMMENT '0-Static; 1-RIP; 2-OSPF',
  `configuration` varchar(255) DEFAULT NULL COMMENT '配置信息',
  `user_id` int DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of topology
-- ----------------------------
BEGIN;
INSERT INTO `topology` (`id`, `type`, `configuration`, `user_id`, `task_id`, `score`) VALUES (1, 2, '#配置信息', 1, 1, 88);
INSERT INTO `topology` (`id`, `type`, `configuration`, `user_id`, `task_id`, `score`) VALUES (2, 1, 'config', 1, 1, 77);
INSERT INTO `topology` (`id`, `type`, `configuration`, `user_id`, `task_id`, `score`) VALUES (3, 0, 'config', 2, 1, 66);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `student_id` int DEFAULT NULL COMMENT '学工号',
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` int DEFAULT NULL COMMENT '0-管理员；1-用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (1, 52202201, '张三', '123456', 0);
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (2, 52202202, '李四', '123123', 1);
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (7, 52202203, 'Bret', '321321', 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
