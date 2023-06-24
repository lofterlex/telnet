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

 Date: 24/06/2023 12:20:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for connections
-- ----------------------------
DROP TABLE IF EXISTS `connections`;
CREATE TABLE `connections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `topology_id` int DEFAULT NULL,
  `node1_id` int DEFAULT NULL,
  `node2_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定义拓扑中节点的连接关系';

-- ----------------------------
-- Records of connections
-- ----------------------------
BEGIN;
INSERT INTO `connections` (`id`, `topology_id`, `node1_id`, `node2_id`) VALUES (1, 1, 1, 2);
INSERT INTO `connections` (`id`, `topology_id`, `node1_id`, `node2_id`) VALUES (2, 1, 1, 3);
INSERT INTO `connections` (`id`, `topology_id`, `node1_id`, `node2_id`) VALUES (3, 1, 2, 3);
COMMIT;

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
  `user_id` int DEFAULT NULL,
  `topology_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '任务名\n',
  `desc` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `score` int DEFAULT NULL COMMENT '成绩',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of task
-- ----------------------------
BEGIN;
INSERT INTO `task` (`id`, `user_id`, `topology_id`, `name`, `desc`, `score`) VALUES (1, 2, 1, 'static拓扑配置', '连接静态拓扑', 88);
COMMIT;

-- ----------------------------
-- Table structure for topology
-- ----------------------------
DROP TABLE IF EXISTS `topology`;
CREATE TABLE `topology` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '拓扑id',
  `type` int DEFAULT NULL COMMENT '0-Static; 1-RIP; 2-OSPF',
  `configuration` varchar(255) DEFAULT NULL COMMENT '配置信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of topology
-- ----------------------------
BEGIN;
INSERT INTO `topology` (`id`, `type`, `configuration`) VALUES (1, 0, '#配置信息');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (1, 52202201, '张三', '123456', 0);
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (2, 52202202, '李四', '123123', 1);
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (3, 52202203, 'Bret', '321321', 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
