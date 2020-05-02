package com.shopping.dao.order;

import java.util.List;

public class OrderManager {
    OrderDAO oDao;
    private static OrderManager oManager;
    static{
    	if (oManager == null) {
			oManager = new OrderManager();
			oManager.setoDao(new OrderDAO());
		}
    	
    }
    private OrderManager(){
    	
    }
    public static OrderManager getInstance(){
    	return oManager;
    }
	public OrderDAO getoDao() {
		return oDao;
	}
	public void setoDao(OrderDAO oDao) {
		this.oDao = oDao;
	}
    public void saveOrder(Order order ){
    	oDao.saveOrder(order);
    }
    public int getOrderPageCount(List<Order> list,int PageNo,int PageSize){
    	
    	return oDao.getOrderPageCount(list,PageNo,PageSize);
    }
    public List<OrderItem> getOrderItems(int orderid){
    	return oDao.getOrderItems(orderid);
    }
    public void updateOrderStatus(int orderid,int status){
    	oDao.updateOrderStatus(orderid,status);
    }
}
