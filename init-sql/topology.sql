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

 Date: 29/06/2023 21:09:59
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
  `topology_id` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`,`topology_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of node
-- ----------------------------
BEGIN;
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `topology_id`) VALUES (1, 'router1', '123', 123, 0, -1);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `topology_id`) VALUES (1, 'RouterA', '192.168.12.1', 80, 0, 1);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `topology_id`) VALUES (1, '123', '123', 123, 123, 2);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `topology_id`) VALUES (2, 'SwitchB', '192.168.12.2', 79, 1, 1);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `topology_id`) VALUES (2, '123', '123', 123, 123, 2);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `topology_id`) VALUES (3, 'ComputerC', '192.168.12.3', 77, 2, 1);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `topology_id`) VALUES (4, 'test', 'test', 1, 1, 1);
INSERT INTO `node` (`id`, `name`, `ip`, `port`, `type`, `topology_id`) VALUES (5, 'test', 'test', 1, 1, -1);
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
INSERT INTO `task` (`id`, `name`, `description`) VALUES (1, 'ospf', 'OSPF任务描述');
INSERT INTO `task` (`id`, `name`, `description`) VALUES (2, 'static', 'static任务描述');
COMMIT;

-- ----------------------------
-- Table structure for topology
-- ----------------------------
DROP TABLE IF EXISTS `topology`;
CREATE TABLE `topology` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '拓扑id',
  `type` int DEFAULT NULL COMMENT '0-Static; 1-RIP; 2-OSPF',
  `configuration` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '配置信息',
  `user_id` int DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `score` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of topology
-- ----------------------------
BEGIN;
INSERT INTO `topology` (`id`, `type`, `configuration`, `user_id`, `task_id`, `score`) VALUES (1, 2, '{ \"class\": \"GraphLinksModel\",\n  \"nodeDataArray\": [ \n{\"key\":\"router1\", \"category\":\"router\", \"text\":\"Router 1\", \"loc\":\"0 0\"},\n{\"key\":\"switch1\", \"category\":\"switch\", \"text\":\"Switch 1\", \"loc\":\"150 0\"},\n{\"key\":\"host1\", \"category\":\"host\", \"text\":\"Host 1\", \"loc\":\"300 0\"},\n{\"key\":\"host2\", \"category\":\"host\", \"text\":\"Host 2\", \"loc\":\"300 100\"}\n ],\n  \"linkDataArray\": [ \n{\"from\":\"router1\", \"to\":\"switch1\"},\n{\"from\":\"switch1\", \"to\":\"host1\"},\n{\"from\":\"switch1\", \"to\":\"host2\"}\n ]}', 1, 1, 99);
INSERT INTO `topology` (`id`, `type`, `configuration`, `user_id`, `task_id`, `score`) VALUES (2, 1, 'config', 1, 1, 77);
INSERT INTO `topology` (`id`, `type`, `configuration`, `user_id`, `task_id`, `score`) VALUES (3, 0, 'config', 2, 1, 66);
INSERT INTO `topology` (`id`, `type`, `configuration`, `user_id`, `task_id`, `score`) VALUES (4, 1, '123', 2, 1, 93);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (1, 52202201, '张三', '123456', 0);
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (2, 52202202, '哈哈', '123123', 1);
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (7, 52202203, 'Bret', '321321', 0);
INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `type`) VALUES (9, 52202205, 'jhz222', '123123', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
