package com.shopping.dao.product;

import java.sql.Timestamp;
import java.util.List;

public class ProductManager {
	// 成员变量
	ProductDAO dao;
	/**
	 * 单例模式
	 */
	private static ProductManager pManager = null;
	static {
		if (pManager == null) {
			pManager = new ProductManager();
			pManager.setDao(new ProductDAO());
		}

	}

	private ProductManager() {

	}

	public static ProductManager getInstance() {
		return pManager;
	}

	public void setDao(ProductDAO dao) {
		this.dao = dao;
	}

	public List<Product> getProducts() {
		return dao.getProducts();
	}

	public List<Product> getProducts(int pageNo, int pageSize) {
		return dao.getProducts(pageNo, pageSize);
	}

	public int searchProducts(List<Product> list,int[] categoryId, String keyword,
			double lowNormalPrice, double highNormalPrice,
			double lowMemberPrice, double highMemberPrice, Timestamp startDate,
			Timestamp endDate, int pageNo, int pageSize) {
		return dao.searchProducts(list,categoryId, keyword, lowNormalPrice,highNormalPrice
				,lowMemberPrice,highMemberPrice,startDate, endDate, pageNo, pageSize);
	}

	/**
	 * 为前台获取pageCount
	 * 
	 * @param list
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public int getProductPageCount(List<Product> list, int pageNo, int pageSize) {
		return dao.getProductPageCount(list, pageNo, pageSize);
	}

	public boolean deleteProductByCategoryId(int categoryId) {
		return false;
	}

	public boolean deleteProductById(int[] idArray) {
		return false;
	}

	public boolean updateProduct(Product p) {
		return dao.updateProduct(p);
	}

	public boolean addProduct(Product p) {
		return dao.addProduct(p);
	}
	public Product getProductById(int id){
		return dao.getProductById(id);
	}
}
