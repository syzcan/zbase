/*
Navicat MySQL Data Transfer

Source Server         : zong
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : zz

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2017-04-11 01:08:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for craw_rule
-- ----------------------------
DROP TABLE IF EXISTS `craw_rule`;
CREATE TABLE `craw_rule` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL COMMENT '名称',
  `craw_store` varchar(255) default NULL COMMENT '唯一编号，作为存储表名',
  `craw_url` varchar(255) default NULL COMMENT '爬取路径',
  `craw_item` varchar(255) default NULL COMMENT '列表条目规则',
  `craw_next` varchar(255) default NULL,
  `list_ext` text COMMENT '扩展规则，json数组存储多个',
  `content_ext` text,
  `type` varchar(255) default NULL COMMENT '1列表 2详情',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='jsoup爬虫解析规则';

-- ----------------------------
-- Records of craw_rule
-- ----------------------------
INSERT INTO `craw_rule` VALUES ('5', '蓝光文学', 'book3k', 'https://book3k.com', '#main article', '.nav-links a.next;attr;href', '[{\"rule_ext_name\":\"title\",\"rule_ext_css\":\".entry-title a\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"url\",\"rule_ext_css\":\".entry-title a\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', '[{\"rule_ext_name\":\"category\",\"rule_ext_css\":\"article .meta-category\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"date\",\"rule_ext_css\":\"article .meta-date time\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"time\",\"rule_ext_css\":\"article .meta-date>a\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"title\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"content\",\"rule_ext_css\":\"article .entry-content\",\"rule_ext_type\":\"html\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', '1');
INSERT INTO `craw_rule` VALUES ('7', '古诗文网', 'gushiwen', 'http://so.gushiwen.org/type.aspx', '.sons', '.pages a[style=\'width:60px;\'];attr;href', '[{\"rule_ext_name\":\"title\",\"rule_ext_css\":\".sons p:eq(0)\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"url\",\"rule_ext_css\":\".sons p:eq(0) a\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', '[{\"rule_ext_name\":\"title\",\"rule_ext_css\":\".shileft h1\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"danysty\",\"rule_ext_css\":\".shileft .son2 p:eq(0)\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"author\",\"rule_ext_css\":\".shileft .son2 p:eq(1) a\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"content\",\"rule_ext_css\":\"#cont\",\"rule_ext_type\":\"html\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', '1');
INSERT INTO `craw_rule` VALUES ('9', '海天文学', '750xs', 'http://www.750xs.com', '#content>div.list', 'a.nextpostslink;attr;href', '[{\"rule_ext_name\":\"title\",\"rule_ext_css\":\"font a\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"url\",\"rule_ext_css\":\"font a\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', '[{\"rule_ext_name\":\"title\",\"rule_ext_css\":\"#content td[align=\'left\']\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"category\",\"rule_ext_css\":\"#content td[align=\'right\']\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"content\",\"rule_ext_css\":\"#content>div.post:eq(1)\",\"rule_ext_type\":\"html\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', '1');
INSERT INTO `craw_rule` VALUES ('11', '941小说', '941novel', 'http://941novel.com/archives/category/【综合成人文学】/', '#archive-posts li', '#wp_page_numbers .active_page+li>a;attr;href', '[{\"rule_ext_name\":\"title\",\"rule_ext_css\":\"h3 a\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"url\",\"rule_ext_css\":\"h3 a\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', '[{\"rule_ext_name\":\"time\",\"rule_ext_css\":\".published\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"title\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"content\",\"rule_ext_css\":\".entry-content h4>strong\",\"rule_ext_type\":\"html\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', '1');
INSERT INTO `craw_rule` VALUES ('12', '起点修仙', 'qidian', 'http://a.qidian.com/?size=5&sign=-1&tag=-1&chanId=22&subCateId=44&orderId=&update=-1&page=1&month=-1&style=1&action=1&vip=-1', '.all-img-list>li', ';url[page=(\\d+)]', '[{\"rule_ext_name\":\"title\",\"rule_ext_css\":\"h4 a\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"url\",\"rule_ext_css\":\"h4 a\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"cover\",\"rule_ext_css\":\".book-img-box img\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"src\",\"rule_ext_mode\":\"string\"}]', '[{\"rule_ext_name\":\"intro\",\"rule_ext_css\":\".left-wrap .book-info p:eq(0)\",\"rule_ext_type\":\"html\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"author\",\"rule_ext_css\":\".book-information .book-info .writer\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"tags\",\"rule_ext_css\":\".book-information .book-info .tag a\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"array\"}]', null);
INSERT INTO `craw_rule` VALUES ('13', '洛天依专题', 'tianyi', 'http://www.bilibili.com/sppage/ad-new-738-1.html', '.vidbox>li', ';url[-(\\d+)\\.html]', '[{\"rule_ext_name\":\"title\",\"rule_ext_css\":\"a\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"title\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"url\",\"rule_ext_css\":\"a\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"},{\"rule_ext_name\":\"cover\",\"rule_ext_css\":\".preview>img\",\"rule_ext_type\":\"attr\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"src\",\"rule_ext_mode\":\"string\"}]', '[{\"rule_ext_name\":\"v_desc\",\"rule_ext_css\":\"#v_desc\",\"rule_ext_type\":\"text\",\"rule_ext_reg\":\"\",\"rule_ext_attr\":\"href\",\"rule_ext_mode\":\"string\"}]', null);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `name` varchar(255) NOT NULL COMMENT '菜单名称',
  `url` varchar(255) NOT NULL COMMENT '菜单地址',
  `pid` varchar(255) default NULL COMMENT '上级id，0为根节点，最多三级菜单',
  `sort` int(11) default NULL COMMENT '排序',
  `icon` varchar(255) default NULL COMMENT '菜单图标',
  `type` varchar(255) default NULL COMMENT '类别',
  `status` int(11) default NULL COMMENT '状态',
  `create_time` datetime default NULL COMMENT '创建时间',
  `update_time` datetime default NULL COMMENT '更新时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('039168b83c1141ad83cec110c2abacc4', '爬虫规则', 'crawler/rule/list', 'c2ca38f1fbe24b169c6568eb3d6928ea', '3', 'icon-bug', 'nav', '1', '2017-04-04 18:27:50', '2017-04-04 18:27:50');
INSERT INTO `sys_menu` VALUES ('111abcc26c944965b3f8d1b9f750b152', '文章管理', 'article/list', 'c2ca38f1fbe24b169c6568eb3d6928ea', '2', 'icon-file-text', 'nav', '1', '2016-04-24 15:41:33', '2017-03-20 21:01:01');
INSERT INTO `sys_menu` VALUES ('17aae5dc92d44cc4b799038c4d0e0564', '菜单管理', 'sysMenu/list', '6658194493a6417c8d747a1677715c0d', '4', 'icon-bars', 'nav', '1', '2017-03-20 20:47:17', '2017-03-21 22:30:53');
INSERT INTO `sys_menu` VALUES ('2f99f2a3d09e44fbb197da5d93a4225e', '视频管理', 'video/list', '36d16dab71ea4a198dbaaf918a187260', '3', 'icon-file-video-o', 'nav', '1', '2016-05-07 21:21:48', '2017-03-20 23:33:26');
INSERT INTO `sys_menu` VALUES ('360760121c734002b30b830dca938f81', '用户管理', 'sysUser/list', '6658194493a6417c8d747a1677715c0d', '2', 'icon-users', 'nav', '1', '2017-03-20 20:53:57', '2017-03-21 22:30:39');
INSERT INTO `sys_menu` VALUES ('36d16dab71ea4a198dbaaf918a187260', '媒体管理', '#', '0', '3', 'icon-film', 'nav', '1', '2017-03-20 21:02:26', '2017-03-20 21:02:26');
INSERT INTO `sys_menu` VALUES ('4f6d1083a1de4b5d8c45bd9433684c16', '角色管理', 'sysRole/list', '6658194493a6417c8d747a1677715c0d', '3', 'icon-smile-o', 'nav', '1', '2017-03-20 20:53:21', '2017-03-21 22:30:46');
INSERT INTO `sys_menu` VALUES ('5af3baef5fcb4fcea562475b0a7b45ae', '文章类别', 'category/list', 'c2ca38f1fbe24b169c6568eb3d6928ea', '1', 'icon-columns', 'nav', '1', '2016-04-24 16:10:09', '2017-03-20 21:00:52');
INSERT INTO `sys_menu` VALUES ('6658194493a6417c8d747a1677715c0d', '系统设置', '#', '0', '1', 'icon-cogs', 'nav', '1', '2017-03-20 20:10:38', '2017-03-20 20:39:29');
INSERT INTO `sys_menu` VALUES ('7afbf254f4ff4c34ac838edf0054e03d', '音乐管理', 'music/list', '36d16dab71ea4a198dbaaf918a187260', '2', 'icon-music', 'nav', '1', '2016-05-07 13:16:23', '2017-03-20 23:32:56');
INSERT INTO `sys_menu` VALUES ('8dcd5e9ac6494e6d9e5e8dbdd029efce', '优美散文', '#', 'd6634c0faf0848f8b1ca8e83b261088f', '1', 'icon-check-square-o', 'nav', '1', null, null);
INSERT INTO `sys_menu` VALUES ('b7e58d9934084113b23e98564beccd41', '消息管理', 'message/list', '36d16dab71ea4a198dbaaf918a187260', '4', 'icon-bullhorn', 'nav', '1', '2016-04-24 17:32:12', '2017-03-20 21:49:36');
INSERT INTO `sys_menu` VALUES ('c2ca38f1fbe24b169c6568eb3d6928ea', '博客管理', '#', '0', '2', 'icon-wordpress', 'nav', '1', '2017-03-20 21:00:22', '2017-03-20 21:00:22');
INSERT INTO `sys_menu` VALUES ('d065c67c5adb4badacba64ad78e97721', '推荐啊', 'recommend', '111abcc26c944965b3f8d1b9f750b152', '2', 'icon-thumbs-o-up', 'nav', '1', '2016-04-27 02:04:05', '2016-04-27 02:04:05');
INSERT INTO `sys_menu` VALUES ('d6634c0faf0848f8b1ca8e83b261088f', '评论', 'comment/list', '111abcc26c944965b3f8d1b9f750b152', '1', 'icon-comments-o', 'nav', '1', '2016-04-27 01:45:24', '2016-04-27 01:45:24');
INSERT INTO `sys_menu` VALUES ('de29c98fc6614e498fac12b3fe31c37f', '系统参数', 'sysParameter/list', '6658194493a6417c8d747a1677715c0d', '1', 'icon-cog', 'nav', '1', '2017-03-20 20:48:51', '2017-03-20 20:57:50');
INSERT INTO `sys_menu` VALUES ('e32496508ef04f34a1bf7e7bb76add00', '爬虫文章', 'crawler/store/list', 'c2ca38f1fbe24b169c6568eb3d6928ea', '4', 'icon-download', 'nav', '1', '2017-04-04 18:30:22', '2017-04-04 18:30:22');
INSERT INTO `sys_menu` VALUES ('fef5df3292924d65833807da0cf3097c', '图片管理', 'photo/list', '36d16dab71ea4a198dbaaf918a187260', '1', 'icon-file-photo-o', 'nav', '1', '2016-12-08 00:23:21', '2017-03-20 23:32:46');

-- ----------------------------
-- Table structure for sys_parameter
-- ----------------------------
DROP TABLE IF EXISTS `sys_parameter`;
CREATE TABLE `sys_parameter` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `name` varchar(255) NOT NULL COMMENT '参数名称',
  `param_key` varchar(255) NOT NULL COMMENT '英文键，唯一',
  `param_value` varchar(255) default NULL COMMENT '参数值',
  `remark` text COMMENT '备注',
  `create_time` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_param_key` (`param_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统参数表';

-- ----------------------------
-- Records of sys_parameter
-- ----------------------------
INSERT INTO `sys_parameter` VALUES ('151fd03f842b42b086fdcb346e35183e', '签名', 'SIGN', '悟空', '我要这铁棒有何用，\r\n\r\n我有这变化又如何，\r\n\r\n还是不安，还是氐惆\r\n\r\n金箍当头，欲说还休', '2017-03-26 15:42:56');
INSERT INTO `sys_parameter` VALUES ('1813430e2733463ba5c0147cc6dc60ad', '网址', 'WEB_URL', 'http://www.zong.me', '', '2016-04-30 01:18:20');
INSERT INTO `sys_parameter` VALUES ('67789e1992394f5d8b0f7141cbc79b82', '介绍', 'WEB_DESC', '彼岸花 - 洛天依', '微风轻拂雨飘洒 昨夜花开满枝桠 \r\n\r\n隐隐山前一缕霞 小桃闲补两三花 \r\n\r\n红袖添香染古刹 琴瑟相和洗铅华 \r\n\r\n谁人月光下作画 谁赋诗来以情答 \r\n\r\n任岁月匆匆如流沙 任四季飘荡荡的天涯\r\n\r\n奈何桥向往的彼岸花 茫茫人海孤独泪落下\r\n\r\n谁在意生命的真与假 谁念起他曾经说过的话\r\n\r\n一天一天衰老粉黛脸颊 只留下对世间的牵挂', '2017-03-26 13:50:21');
INSERT INTO `sys_parameter` VALUES ('b15dede16e87477f9a16a38c7d40818f', '网站名称', 'WEB_NAME', 'zbase修仙', '专业修仙30年', '2016-04-30 01:17:22');
INSERT INTO `sys_parameter` VALUES ('f6b6078b62eb4c58935ef79db53dc5d6', '标志', 'LOGO', '', '', '2016-04-30 01:20:01');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `remark` varchar(255) default NULL,
  `create_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1563da63c0944b48ab789b513934d3de', '炼气', '炼气级别用户', '2016-04-30 22:21:31');
INSERT INTO `sys_role` VALUES ('280d46496003479e80980a42241b3cb6', '筑基', '嘿嘿嘿', '2017-03-21 22:23:45');
INSERT INTO `sys_role` VALUES ('5063d21c2709480e9f92ab3e8b62caf4', '金丹', '', '2017-03-21 22:28:28');
INSERT INTO `sys_role` VALUES ('774e569cbe454b68be1924cdef5a1735', '元婴', '', '2017-03-24 21:01:26');
INSERT INTO `sys_role` VALUES ('7de82480ff894429a9864e76410f03f6', '化神', '', '2017-03-24 21:01:38');
INSERT INTO `sys_role` VALUES ('b82ecffc49b8405e9e7121f1967d35bc', '大乘', '', '2017-03-24 21:01:10');
INSERT INTO `sys_role` VALUES ('f2a6c498887c499e93b716494389415c', '飞升', '系统管理员', '2016-04-30 22:19:04');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` varchar(255) NOT NULL default '' COMMENT '主键',
  `role_id` varchar(255) NOT NULL COMMENT '角色id',
  `menu_id` varchar(255) NOT NULL COMMENT '菜单Id',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色关联菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('051bb7b168a1492dac047143abdbcc79', '1563da63c0944b48ab789b513934d3de', '36d16dab71ea4a198dbaaf918a187260');
INSERT INTO `sys_role_menu` VALUES ('05f2259ea7fb483eba3829a66ebcbf88', '280d46496003479e80980a42241b3cb6', '36d16dab71ea4a198dbaaf918a187260');
INSERT INTO `sys_role_menu` VALUES ('112e53abc78a4d5cb309b2e3ea159493', 'f2a6c498887c499e93b716494389415c', '4f6d1083a1de4b5d8c45bd9433684c16');
INSERT INTO `sys_role_menu` VALUES ('1aca3ec8df1d4c56bc53712fe4bcc5b9', '280d46496003479e80980a42241b3cb6', 'c2ca38f1fbe24b169c6568eb3d6928ea');
INSERT INTO `sys_role_menu` VALUES ('1beaaaeba9494adbaa23c507c5dc0756', 'f2a6c498887c499e93b716494389415c', 'fef5df3292924d65833807da0cf3097c');
INSERT INTO `sys_role_menu` VALUES ('24267fc5a24c4491b83dbb71965b1d35', '5063d21c2709480e9f92ab3e8b62caf4', '36d16dab71ea4a198dbaaf918a187260');
INSERT INTO `sys_role_menu` VALUES ('250fc720f8f44d8b8ac7f470e9d09fd0', 'f2a6c498887c499e93b716494389415c', 'b7e58d9934084113b23e98564beccd41');
INSERT INTO `sys_role_menu` VALUES ('338aeddc71cb41d4b3fa970715d1e667', 'f2a6c498887c499e93b716494389415c', 'de29c98fc6614e498fac12b3fe31c37f');
INSERT INTO `sys_role_menu` VALUES ('35d0c1f5f3e74c6aa6d3f54941c55f3f', 'f2a6c498887c499e93b716494389415c', '111abcc26c944965b3f8d1b9f750b152');
INSERT INTO `sys_role_menu` VALUES ('41177775692f4be1bad89855131fd4ac', 'f2a6c498887c499e93b716494389415c', '6658194493a6417c8d747a1677715c0d');
INSERT INTO `sys_role_menu` VALUES ('43690d1bad804419b0b3bb9cb1371d82', 'f2a6c498887c499e93b716494389415c', '2f99f2a3d09e44fbb197da5d93a4225e');
INSERT INTO `sys_role_menu` VALUES ('4d16b25dbb9e49ed8850ddbf0d3296db', '280d46496003479e80980a42241b3cb6', 'b7e58d9934084113b23e98564beccd41');
INSERT INTO `sys_role_menu` VALUES ('555315ccc3b4495d9bb3949e355a3e5c', '5063d21c2709480e9f92ab3e8b62caf4', '2f99f2a3d09e44fbb197da5d93a4225e');
INSERT INTO `sys_role_menu` VALUES ('6781e70b7fc546f5a6340b0b12b43a29', '774e569cbe454b68be1924cdef5a1735', 'de29c98fc6614e498fac12b3fe31c37f');
INSERT INTO `sys_role_menu` VALUES ('72a3a8e679034782b8be443ea3725ac1', '774e569cbe454b68be1924cdef5a1735', '6658194493a6417c8d747a1677715c0d');
INSERT INTO `sys_role_menu` VALUES ('7f58108d22754d02a56b5251be9489e1', '5063d21c2709480e9f92ab3e8b62caf4', 'b7e58d9934084113b23e98564beccd41');
INSERT INTO `sys_role_menu` VALUES ('9d1501ddf9e64fa99d8f3e12fc4ff6f1', 'f2a6c498887c499e93b716494389415c', '36d16dab71ea4a198dbaaf918a187260');
INSERT INTO `sys_role_menu` VALUES ('a01f3cbd476e49419f9ca478057f34dd', '1563da63c0944b48ab789b513934d3de', 'b7e58d9934084113b23e98564beccd41');
INSERT INTO `sys_role_menu` VALUES ('a4f9a07bf6e542aca7732cb99f59d731', 'f2a6c498887c499e93b716494389415c', 'e32496508ef04f34a1bf7e7bb76add00');
INSERT INTO `sys_role_menu` VALUES ('ced4b940bdcd4e579b1d08128d0a5525', 'f2a6c498887c499e93b716494389415c', '17aae5dc92d44cc4b799038c4d0e0564');
INSERT INTO `sys_role_menu` VALUES ('d846dc5774f5454498b10faea4683d95', 'f2a6c498887c499e93b716494389415c', '5af3baef5fcb4fcea562475b0a7b45ae');
INSERT INTO `sys_role_menu` VALUES ('db7a4a0046a8450bba6e251225aabe02', 'f2a6c498887c499e93b716494389415c', '7afbf254f4ff4c34ac838edf0054e03d');
INSERT INTO `sys_role_menu` VALUES ('de32779481dd4170965d6934dc726ad8', 'f2a6c498887c499e93b716494389415c', '039168b83c1141ad83cec110c2abacc4');
INSERT INTO `sys_role_menu` VALUES ('ec0fbb59f76343f897e93f2789702267', 'f2a6c498887c499e93b716494389415c', 'c2ca38f1fbe24b169c6568eb3d6928ea');
INSERT INTO `sys_role_menu` VALUES ('f10e9953a00c47acb1b0202014195df9', 'f2a6c498887c499e93b716494389415c', '360760121c734002b30b830dca938f81');
INSERT INTO `sys_role_menu` VALUES ('f5f57ec52b4648ab8695bcc41c3f3455', '280d46496003479e80980a42241b3cb6', '111abcc26c944965b3f8d1b9f750b152');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(255) default NULL COMMENT '昵称',
  `gender` varchar(255) default NULL COMMENT '性别：1男 2女',
  `birthday` datetime default NULL COMMENT '生日',
  `avatar` varchar(255) default NULL COMMENT '头像',
  `remark` text COMMENT '备注',
  `status` int(11) default NULL COMMENT '状态',
  `last_login` datetime default NULL COMMENT '上次登录时间',
  `ip` varchar(255) default NULL COMMENT '登录ip',
  `auth_key` varchar(255) default NULL COMMENT '简单的浏览器自动登录cookie密钥，唯一',
  `create_time` datetime default NULL,
  `update_time` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_username` USING BTREE (`username`),
  KEY `index_auth_key` USING BTREE (`auth_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('0e1a65cd5166407e8c807b9dc6cec765', 'ye154430', 'e10adc3949ba59abbe56e057f20f883e', '大侠洛天依', '女', '2016-05-07 00:00:00', 'upload/20160429/d1a4461ef500473781beeddfaf5f9445.png', '<p>哈哈哈哈</p>', '1', '2017-03-26 13:15:46', '0:0:0:0:0:0:0:1', '8d2a2d0d-d1c3-4df0-a84a-f70e3d698674', '2016-04-24 00:28:54', '2017-03-25 00:19:25');
INSERT INTO `sys_user` VALUES ('41155f3a0e904d8294735331de175a23', 'kp019287', 'e10adc3949ba59abbe56e057f20f883e', '鲍三娘', '女', '2016-03-27 00:00:00', 'upload/picture/20170323/1490200369015.png', '', '1', null, null, null, '2016-04-24 16:29:45', '2017-03-23 01:17:47');
INSERT INTO `sys_user` VALUES ('439b6c9b949048e99c4ea8efdda4ab2e', 'cy542290', 'e10adc3949ba59abbe56e057f20f883e', '龙傲天', '男', '1985-04-29 00:00:00', 'upload/picture/20170323/1490200685730.png', '', '1', null, null, null, '2016-03-14 23:57:36', '2017-03-23 00:38:01');
INSERT INTO `sys_user` VALUES ('680d9db60d26434b801107cddcbf0ac0', 'ps205466', 'e10adc3949ba59abbe56e057f20f883e', '小乔妹妹', '女', '2016-04-11 00:00:00', 'upload/picture/20170319/1489921503324.png', '', '1', '2017-03-19 19:05:42', '0:0:0:0:0:0:0:1', null, '2016-04-24 18:46:55', '2017-03-19 19:05:01');
INSERT INTO `sys_user` VALUES ('705aada5-9da9-4579-b6d9-a8300c63dc20', 'vf904615', 'e10adc3949ba59abbe56e057f20f883e', '王元姬', '女', null, 'upload/picture/20170323/1490200776716.png', '', '1', null, null, null, '2016-02-19 16:00:28', '2017-03-23 00:39:40');
INSERT INTO `sys_user` VALUES ('70ae6aedc1864dfd9a045617bc3e0779', 'ns433653', 'e10adc3949ba59abbe56e057f20f883e', '练师', '女', '2016-04-01 00:00:00', 'upload/picture/20170323/1490200425440.png', '', '1', null, null, null, '2016-03-12 14:22:03', '2017-03-23 00:35:55');
INSERT INTO `sys_user` VALUES ('71189304cc604a3c8834bf0235b2e0c9', 'mj344347', 'e10adc3949ba59abbe56e057f20f883e', '吕玲绮', '女', null, 'upload/picture/20170323/1490203095100.png', '', '1', null, null, null, '2017-03-23 01:16:42', '2017-03-23 01:18:16');
INSERT INTO `sys_user` VALUES ('77a5462d3c144273811570ba138cd1b4', 'gr117577', 'e10adc3949ba59abbe56e057f20f883e', '貂蝉', '女', '2016-04-20 00:00:00', 'upload/picture/20170322/1490184509865.png', '', '1', null, null, null, '2016-03-12 14:22:32', '2017-03-22 20:11:48');
INSERT INTO `sys_user` VALUES ('95764b66-297b-4a92-9526-474ae904019a', 'zv738872', 'e10adc3949ba59abbe56e057f20f883e', '月英', '女', null, 'upload/picture/20170323/1490200610994.png', '', '1', null, null, null, '2016-03-08 17:51:47', '2017-03-23 00:37:00');
INSERT INTO `sys_user` VALUES ('99311c408e664416b7efed3a54fe771f', 'ra485007', 'e10adc3949ba59abbe56e057f20f883e', '孙尚香', '女', '2017-03-01 00:00:00', 'upload/picture/20170319/1489920651693.png', '<p>呵呵呵</p>', '1', null, null, null, '2017-03-19 18:50:56', '2017-03-20 23:12:14');
INSERT INTO `sys_user` VALUES ('9d2a1b1d335a4e1b921b4d75a9fb761a', 'mw926523', 'e10adc3949ba59abbe56e057f20f883e', '子龙大侠', '女', '2016-03-27 00:00:00', 'upload/picture/20170323/1490200404177.png', '', '1', '2016-05-01 23:50:47', '127.0.0.1', null, '2016-04-24 18:47:33', '2017-03-23 00:33:24');
INSERT INTO `sys_user` VALUES ('9ec2f30db5014bb0b8202a3bc4a84f19', 'jp072045', 'e10adc3949ba59abbe56e057f20f883e', '张春华', '女', null, 'upload/picture/20170323/1490203122098.png', '', '1', null, null, null, '2017-03-23 01:18:43', '2017-03-26 13:43:13');
INSERT INTO `sys_user` VALUES ('b7d74a19b7c1464e88b7943ea51e3319', 'nt166438', 'e10adc3949ba59abbe56e057f20f883e', '星彩', '女', '2016-03-27 00:00:00', 'upload/picture/20170323/1490200577575.png', '', '1', null, null, null, '2016-03-12 13:49:30', '2017-03-23 00:36:28');
INSERT INTO `sys_user` VALUES ('bd9ab8c554a34c95969e2899f1767d99', 'qu652447', 'e10adc3949ba59abbe56e057f20f883e', '关银屏', '', null, 'upload/picture/20170323/1490203036468.png', '', '1', null, null, null, '2017-03-23 01:17:14', '2017-03-23 01:17:14');
INSERT INTO `sys_user` VALUES ('d3e3275db54c4997baffa728bbe9a4e8', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '老司机', '女', '2016-04-13 00:00:00', 'upload/picture/20170320/1490024530082.png', '<p>嘿嘿嘿</p>', '1', '2017-04-11 00:33:26', '0:0:0:0:0:0:0:1', '23b6e7ef-8d64-4bbf-bdb4-c7daba619805', '2016-04-23 23:49:55', '2017-03-25 00:02:46');
INSERT INTO `sys_user` VALUES ('eaf8243a43d8479392ca2cdc7982aa81', 'rc505556', 'e10adc3949ba59abbe56e057f20f883e', '王异', '女', null, 'upload/picture/20170323/1490202867226.png', '', '1', null, null, null, '2017-03-23 01:14:25', '2017-03-23 01:14:25');
INSERT INTO `sys_user` VALUES ('f824a8e6-606e-461f-a225-9122357d5260', 'pv506140', 'auth123456', '甄宓', '女', null, 'upload/picture/20170323/1490200319471.png', '', '1', null, null, null, '2016-03-13 15:00:15', '2017-03-23 00:32:31');
INSERT INTO `sys_user` VALUES ('f8757186af4c4b18805f4c67c10efca7', 'ms682529', 'e10adc3949ba59abbe56e057f20f883e', '祝融', '', null, 'upload/picture/20170323/1490200829129.png', '', '1', null, null, null, '2017-03-23 00:40:28', '2017-03-23 00:40:28');
INSERT INTO `sys_user` VALUES ('fa646600fce14c14813544aa08b14427', 'jw382283', 'e10adc3949ba59abbe56e057f20f883e', '蔡文姬', '女', '2017-03-08 00:00:00', 'upload/picture/20170322/1490115128242.png', '<p>666</p>', '2', null, null, null, '2017-03-22 00:49:47', '2017-03-23 00:30:15');
INSERT INTO `sys_user` VALUES ('fb52ab5b-a2c6-413a-8668-b1e3060dfc3a', 'tm193626', 'e10adc3949ba59abbe56e057f20f883e', '大乔', '女', null, 'upload/picture/20170323/1490200731996.png', '', '1', null, null, null, '2016-01-29 17:41:31', '2017-03-23 00:38:57');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` varchar(255) NOT NULL default '',
  `user_id` varchar(255) NOT NULL COMMENT '用户Id',
  `role_id` varchar(255) NOT NULL COMMENT '角色id',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户关联角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('068e9b1d86f448d59f3afb7fc5335493', '0e1a65cd5166407e8c807b9dc6cec765', '774e569cbe454b68be1924cdef5a1735');
INSERT INTO `sys_user_role` VALUES ('0b791853146849378ef064e56f55546e', 'fa646600fce14c14813544aa08b14427', '280d46496003479e80980a42241b3cb6');
INSERT INTO `sys_user_role` VALUES ('b050497721b7414d897c2cb7fb287d11', 'd3e3275db54c4997baffa728bbe9a4e8', 'f2a6c498887c499e93b716494389415c');
INSERT INTO `sys_user_role` VALUES ('b38735b9997d408a8fbf87544d31c8fe', '77a5462d3c144273811570ba138cd1b4', '1563da63c0944b48ab789b513934d3de');
INSERT INTO `sys_user_role` VALUES ('b7d8973c28d84214814f3d7b91844f7c', '439b6c9b949048e99c4ea8efdda4ab2e', '1563da63c0944b48ab789b513934d3de');
INSERT INTO `sys_user_role` VALUES ('c12f494e792d4e61912ee108407cca54', '0e1a65cd5166407e8c807b9dc6cec765', '5063d21c2709480e9f92ab3e8b62caf4');
INSERT INTO `sys_user_role` VALUES ('e3d7aca79e1e49d398dd8fa356692d1b', '41155f3a0e904d8294735331de175a23', '280d46496003479e80980a42241b3cb6');
INSERT INTO `sys_user_role` VALUES ('f9120e9eb1194c84a14f54d81e88022e', 'fa646600fce14c14813544aa08b14427', '5063d21c2709480e9f92ab3e8b62caf4');
