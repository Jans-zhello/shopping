create database shopping;

use shopping;
#用户表
create table ruser
(
 id int primary key auto_increment,
 username varchar(40),
 password varchar(16),
 phone varchar(40),
 addr varchar(255),
 rdate datetime
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#(产品种类)树状结构表
create table category
(
 id int primary key auto_increment,
 name varchar(255),
 descr varchar(255),
 pid int,#父亲id
 isleaf int, #0表示leaf 1表示非leaf
 grade int #树状结构的级别
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#产品表
create table product
(
 id int primary key auto_increment,
 name varchar(255),
 descr varchar(255),
 normalprice double,#市场价
 memberprice double,#会员价
 pdate datetime,
 categoryid int references category(id)#外键
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#订单表
create table salesorder
(
 id int primary key auto_increment,
 userid int,
 addr varchar(255),
 odate datetime,
 status int
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#订单详情表
create table salesitem
(
 id int primary key auto_increment,
 productid int,
 unitprice double,#单价
 pcount int,#数量
 orderid int
)ENGINE=InnoDB DEFAULT CHARSET=utf8;