package com.shopping.dao.order;

import java.sql.Timestamp;

import com.shopping.dao.User;
import com.shopping.dao.cart.Cart;

public class Order {
	private int id;
	private User user;
	private String addr;
	Timestamp odate;
	int status;
	double money;
	Cart c;

    
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public Timestamp getOdate() {
		return odate;
	}

	public void setOdate(Timestamp odate) {
		this.odate = odate;
	}

	public Cart getC() {
		return c;
	}

	public void setC(Cart c) {
		this.c = c;
	}

}
