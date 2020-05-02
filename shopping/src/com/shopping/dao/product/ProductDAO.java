package com.shopping.dao.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.shopping.Utils.DB;

public class ProductDAO {
	public List<Product> getProducts() {
		List<Product> products = new ArrayList<Product>();
		Connection conn = null;
		ResultSet resultSet = null;
		String sql = "select * from product";
		try {
			conn = DB.getConnection();
			resultSet = DB.executeQuery(conn, sql);
			while (resultSet.next()) {
				Product product = new Product();
				product.setId(resultSet.getInt("id"));
				product.setName(resultSet.getString("name"));
				product.setDescr(resultSet.getString("descr"));
				product.setNormalprice(resultSet.getDouble("normalprice"));
				product.setMemberprice(resultSet.getDouble("memberprice"));
				product.setPdate(resultSet.getTimestamp("pdate"));
				product.setCategoryid(resultSet.getInt("categoryid"));
				products.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
			DB.closeConn(conn);
		}

		return products;
	}

	public List<Product> getProducts(int pageNo, int pageSize) {
		List<Product> products = new ArrayList<Product>();
		Connection conn = null;
		ResultSet resultSet = null;
		String sql = "select * from product limit " + (pageNo - 1) * pageSize
				+ "," + pageSize;
		try {
			conn = DB.getConnection();
			resultSet = DB.executeQuery(conn, sql);
			while (resultSet.next()) {
				Product product = new Product();
				product.setId(resultSet.getInt("id"));
				product.setName(resultSet.getString("name"));
				product.setDescr(resultSet.getString("descr"));
				product.setNormalprice(resultSet.getDouble("normalprice"));
				product.setMemberprice(resultSet.getDouble("memberprice"));
				product.setPdate(resultSet.getTimestamp("pdate"));
				product.setCategoryid(resultSet.getInt("categoryid"));
				products.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
			DB.closeConn(conn);
		}

		return products;
	}

	public int getProductPageCount(List<Product> list, int pageNo, int pageSize) {
		Connection conn = null;
		ResultSet resultSet = null;
		ResultSet resultSetCount = null;
		int pageCount = 0;
		try {
			conn = DB.getConnection();
			/**
			 * 获取分页总数
			 */
			resultSetCount = DB.executeQuery(conn,
					"select count(*) from product");
			resultSetCount.next();
			pageCount = (resultSetCount.getInt(1) + pageSize - 1) / pageSize;
			/**
			 * 赋值product的list
			 */
			resultSet = DB.executeQuery(conn, "select * from product limit "
					+ (pageNo - 1) * pageSize + "," + pageSize);
			while (resultSet.next()) {
				Product product = new Product();
				product.setId(resultSet.getInt("id"));
				product.setName(resultSet.getString("name"));
				product.setDescr(resultSet.getString("descr"));
				product.setNormalprice(resultSet.getDouble("normalprice"));
				product.setMemberprice(resultSet.getDouble("memberprice"));
				product.setPdate(resultSet.getTimestamp("pdate"));
				product.setCategoryid(resultSet.getInt("categoryid"));
				list.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
			DB.closeConn(conn);
		}
		return pageCount;
	}

	public int searchProducts(List<Product>products, int[] categoryId, String keyword,
			double lowNormalPrice, double highNormalPrice,
			double lowMemberPrice, double highMemberPrice, Timestamp startDate,
			Timestamp endDate, int pageNo, int pageSize) {
		Connection conn = null;
		ResultSet resultSet = null;
		ResultSet resultSetCount = null;
		int pageCount = 0;
		String sqlCount = "";
		try {
			conn = DB.getConnection();
			String sql = "select * from product where 1=1";
			/**
			 * 动态增加categoryid的sql语句
			 */
			if (categoryId != null && categoryId.length>0) {
				String strId = "(";
				for (int i = 0; i < categoryId.length; i++) {
					if (i<categoryId.length-1) {
						strId += categoryId[i]+",";
					}else {
						strId += categoryId[i];
					}
				}
				strId += ")";
				sql += " and categoryid in "+strId;
			}
			/**
			 * 动态增加keyword的语句
			 */
			if (keyword != null && !keyword.trim().equals("")) {
				sql += " and concat(name,descr) like '%"+keyword+"%'";
			}
			/**
			 * 动态增加lownormalprice|highnormalprice|lowmemberprice|highmemberprice
			 */
			if (lowNormalPrice >=0) {
				sql += " and normalprice >"+lowNormalPrice;
			}
			if (highNormalPrice >0) {
				sql += " and normalprice <"+highNormalPrice;
			}
			if (lowMemberPrice >=0) {
				sql += " and memberprice >"+lowMemberPrice;
			}
			if (highMemberPrice >0) {
				sql += " and memberprice <"+highMemberPrice;
			}
			/**
			 *增加检查日期的sql语句处理
			 */
			if (startDate != null) {
				sql += " and pdate >= '"+new SimpleDateFormat("yyyy-MM-dd").format(startDate)+"'";
			}
			if (endDate != null) {
				sql += " and pdate <= '"+new SimpleDateFormat("yyyy-MM-dd").format(endDate)+"'";
			}
			
			sqlCount = sql.replaceFirst("select \\*","select count(*)");
			
			//添加分页sql语句处理
			sql += " limit "+ (pageNo - 1) * pageSize + "," + pageSize;
			//获取分页总数
			resultSetCount = DB.executeQuery(conn, sqlCount);
			resultSetCount.next();
			pageCount = (resultSetCount.getInt(1)+pageSize-1)/pageSize;
			//查询搜索条件的结果集 并赋值list
			System.out.println(sql);
			resultSet = DB.executeQuery(conn, sql);
			while (resultSet.next()) {
				Product product = new Product();
				product.setId(resultSet.getInt("id"));
				product.setName(resultSet.getString("name"));
				product.setDescr(resultSet.getString("descr"));
				product.setNormalprice(resultSet.getDouble("normalprice"));
				product.setMemberprice(resultSet.getDouble("memberprice"));
				product.setPdate(resultSet.getTimestamp("pdate"));
				product.setCategoryid(resultSet.getInt("categoryid"));
				products.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
			DB.closeConn(conn);
		}

		return pageCount;

	}

	public boolean deleteProductByCategoryId(int categoryId) {
		return false;
	}

	public boolean deleteProductById(int[] idArray) {
		return false;
	}

	public boolean updateProduct(Product p) {
		Connection conn = null;
		Statement statement = null;
		try {
			String sql = "update product set name='" + p.getName() + "',descr='"
					+ p.getDescr() + "',normalprice='" + p.getNormalprice() + "',memberprice='"+p.getMemberprice()+"',categoryid='"+p.getCategoryid()+"' where id='" + p.getId() + "'";
			conn = DB.getConnection();
			statement = DB.createStatement(conn);
			statement.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally {
			DB.closeConn(conn);
			DB.closeStatement(statement);
		}
		return true;
	}

	public boolean addProduct(Product p) {
		Connection conn = null;
		PreparedStatement pStatement = null;
		try {
			conn = DB.getConnection();
			String sql = "";
			if (p.getId() == -1) {
				sql = "insert into product values (null,?,?,?,?,?,?)";
			} else {
				sql = "insert into product values (" + p.getId()
						+ ",?,?,?,?,?,?)";
			}
			pStatement = DB.preparedStatement(conn, sql);
			pStatement.setString(1, p.getName());
			pStatement.setString(2, p.getDescr());
			pStatement.setDouble(3, p.getNormalprice());
			pStatement.setDouble(4, p.getMemberprice());
			pStatement.setTimestamp(5, p.getPdate());
			pStatement.setInt(6, p.getCategoryid());
			pStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.closeConn(conn);
			DB.closeStatement(pStatement);
		}
		return true;
	}

	public Product getProductById(int id) {
		Product product = null;
		Connection conn = null;
		ResultSet resultSet = null;
		String sql = "select * from product where id = '"+id+"'";
		try {
			conn = DB.getConnection();
			resultSet = DB.executeQuery(conn, sql);
			if (resultSet.next()) {
				product = new Product();
				product.setId(resultSet.getInt("id"));
				product.setName(resultSet.getString("name"));
				product.setDescr(resultSet.getString("descr"));
				product.setNormalprice(resultSet.getDouble("normalprice"));
				product.setMemberprice(resultSet.getDouble("memberprice"));
				product.setPdate(resultSet.getTimestamp("pdate"));
				product.setCategoryid(resultSet.getInt("categoryid"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
			DB.closeConn(conn);
		}

		return product;
	}
}
