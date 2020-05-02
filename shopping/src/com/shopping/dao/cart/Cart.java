package com.shopping.dao.cart;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	List<CartItem> caItems = new ArrayList<CartItem>();

	public List<CartItem> getCaItems() {
		return caItems;
	}

	public void setCaItems(List<CartItem> caItems) {
		this.caItems = caItems;
	}

	public void addItem(CartItem item) {
		//���list���������Ƿ�����ͬID�Ĳ�Ʒ�����У������������+1;û��ֱ����ӵ�list����
		for (int i = 0; i < caItems.size(); i++) {
			CartItem ci = caItems.get(i);
			if (ci.getProductId() == item.getProductId()) {
				ci.setCount(ci.getCount()+1);
				return;
			}
		}
		caItems.add(item);
	}
   public double TotalPrice(){
	   double totalprice = 0;
		for (int i = 0; i < caItems.size(); i++) {
			CartItem ci = caItems.get(i);
			totalprice += ci.getPrice()*ci.getCount();
		}
		return totalprice;
	} 
}
