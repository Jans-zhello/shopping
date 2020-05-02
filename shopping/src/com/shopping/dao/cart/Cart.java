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
		//检查list数组里面是否有相同ID的产品，若有，则将相关数量加+1;没有直接添加到list里面
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
