/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : shirojwt

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2020-02-28 15:07:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sysLog
-- ----------------------------
DROP TABLE IF EXISTS `sysLog`;
CREATE TABLE `sysLog` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `operation` varchar(255) DEFAULT NULL,
  `operation_module` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `respParam` varchar(255) DEFAULT NULL,
  `errorLogFlag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1233275830382120962 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysLog
-- ----------------------------

-- ----------------------------
-- Table structure for sysPermission
-- ----------------------------
DROP TABLE IF EXISTS `sysPermission`;
CREATE TABLE `sysPermission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(128) DEFAULT NULL COMMENT '资源名称',
  `per_code` varchar(128) NOT NULL COMMENT '权限代码字符串',
  PRIMARY KEY (`id`),
  UNIQUE KEY `per_code` (`per_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of sysPermission
-- ----------------------------
INSERT INTO `sysPermission` VALUES ('1', '查看用户', 'mybatisUser:view');
INSERT INTO `sysPermission` VALUES ('2', '操作用户', 'mybatisUser:edit');

-- ----------------------------
-- Table structure for sysRole
-- ----------------------------
DROP TABLE IF EXISTS `sysRole`;
CREATE TABLE `sysRole` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(128) NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sysRole
-- ----------------------------
INSERT INTO `sysRole` VALUES ('1', 'admin');
INSERT INTO `sysRole` VALUES ('2', 'customer');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `permission_id` int(11) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sysRole` (`id`),
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `sysPermission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色资源表';

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('1', '1', '1');
INSERT INTO `role_permission` VALUES ('2', '1', '2');
INSERT INTO `role_permission` VALUES ('3', '2', '1');

-- ----------------------------
-- Table structure for mybatisUser
-- ----------------------------
DROP TABLE IF EXISTS `mybatisUser`;
CREATE TABLE `mybatisUser` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `password` varchar(80) NOT NULL COMMENT '密码',
  `username` varchar(20) NOT NULL COMMENT '昵称',
  `reg_time` datetime NOT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of mybatisUser
-- ----------------------------
INSERT INTO `mybatisUser` VALUES ('1', 'admin', 'admin', '2020-02-24 10:04:08');
INSERT INTO `mybatisUser` VALUES ('2', 'lxg', 'lxg', '2020-02-24 10:04:08');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `mybatisUser` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sysRole` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1', '1');
INSERT INTO `user_role` VALUES ('2', '2', '2');
