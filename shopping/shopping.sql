create database shopping;

use shopping;
#�û���
create table ruser
(
 id int primary key auto_increment,
 username varchar(40),
 password varchar(16),
 phone varchar(40),
 addr varchar(255),
 rdate datetime
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#(��Ʒ����)��״�ṹ��
create table category
(
 id int primary key auto_increment,
 name varchar(255),
 descr varchar(255),
 pid int,#����id
 isleaf int, #0��ʾleaf 1��ʾ��leaf
 grade int #��״�ṹ�ļ���
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#��Ʒ��
create table product
(
 id int primary key auto_increment,
 name varchar(255),
 descr varchar(255),
 normalprice double,#�г���
 memberprice double,#��Ա��
 pdate datetime,
 categoryid int references category(id)#���
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#������
create table salesorder
(
 id int primary key auto_increment,
 userid int,
 addr varchar(255),
 odate datetime,
 status int
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#���������
create table salesitem
(
 id int primary key auto_increment,
 productid int,
 unitprice double,#����
 pcount int,#����
 orderid int
)ENGINE=InnoDB DEFAULT CHARSET=utf8;