package com.shopping.dao.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.shopping.Utils.DB;
import com.shopping.dao.User;
import com.shopping.dao.cart.Cart;
import com.shopping.dao.cart.CartItem;
import com.shopping.dao.product.Product;

public class OrderDAO {

	public void saveOrder(Order order) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rSet = null;
		String sql = "";
		try {
			conn = DB.getConnection();
			conn.setAutoCommit(false);
			sql = "insert into salesorder values (null,?,?,?,?,?)";
			ps = DB.preparedStatement(conn, sql, true);
			ps.setInt(1, order.getUser().getId());
			ps.setString(2, order.getAddr());
			ps.setTimestamp(3, order.getOdate());
			ps.setDouble(4, order.getMoney());
			ps.setInt(5, order.getStatus());
			ps.executeUpdate();
			rSet = ps.getGeneratedKeys();
			rSet.next();
			int key = rSet.getInt(1);// 获取刚刚插入的id
			sql = "insert into salesitem values (null,?,?,?,?)";
			ps = DB.preparedStatement(conn, sql);
			Cart cart = order.getC();
			List<CartItem> list = cart.getCaItems();
			for (int i = 0; i < list.size(); i++) {
				CartItem cartItem = list.get(i);
				ps.setInt(1, cartItem.getProductId());
				ps.setDouble(2, cartItem.getPrice());
				ps.setInt(3, cartItem.getCount());
				ps.setInt(4, key);
				ps.addBatch();
			}
			ps.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			DB.closeConn(conn);
			DB.closeResultSet(rSet);
			DB.closeStatement(ps);
		}
	}

	public int getOrderPageCount(List<Order> list, int pageNo, int pageSize) {
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
					"select count(*) from salesorder");
			resultSetCount.next();
			pageCount = (resultSetCount.getInt(1) + pageSize - 1) / pageSize;
			/**
			 * 赋值product的list
			 */
			resultSet = DB.executeQuery(conn, "select salesorder.id,salesorder.addr,salesorder.odate,salesorder.money,salesorder.status,ruser.username from salesorder join ruser on (salesorder.userid = ruser.id) limit "
					+ (pageNo - 1) * pageSize + "," + pageSize);
			while (resultSet.next()) {
				User user = new User();
				user.setUsername(resultSet.getString("username"));
				Order order = new Order();
				order.setId(resultSet.getInt("id"));
				order.setMoney(resultSet.getDouble("money"));
				order.setOdate(resultSet.getTimestamp("odate"));
				order.setAddr(resultSet.getString("addr"));
				order.setUser(user);
				order.setStatus(resultSet.getInt("status"));
				list.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
			DB.closeConn(conn);
		}
		return pageCount;
	}

	public List<OrderItem> getOrderItems(int orderid) {
		Connection conn = null;
		ResultSet rSet = null;
		String sql = "";
		List<OrderItem> list = new ArrayList<OrderItem>();
		try {
			conn = DB.getConnection();
			sql = "select salesitem.unitprice,salesitem.pcount,product.name from salesitem join product on (salesitem.productid = product.id) join salesorder on(salesitem.orderid = salesorder.id) where salesitem.orderid = "+orderid;
			rSet = DB.executeQuery(conn, sql);
			while (rSet.next()) {
				Product p = new Product();
				p.setName(rSet.getString("name"));
				OrderItem orItem = new OrderItem();
			    orItem.setPcount(rSet.getInt("pcount"));
			    orItem.setProduct(p);
			    orItem.setUnitprice(rSet.getDouble("unitprice"));
			    list.add(orItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.closeConn(conn);
			DB.closeResultSet(rSet);
		}
		
		return list;
	}

	public void updateOrderStatus(int orderid, int status) {
		Connection conn = null;
		Statement statement = null;
		try {
			String sql = "update salesorder set status=" +status+ " where id=" + orderid ;
			conn = DB.getConnection();
			statement = DB.createStatement(conn);
			statement.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeStatement(statement);
		}
	  }
}
