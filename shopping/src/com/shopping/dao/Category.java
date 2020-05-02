package com.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shopping.Utils.DB;

public class Category {
	private int id;
	private String name;
	private String descr;
	private int pid;
	private boolean leaf;
	private int grade;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public boolean isLeaf() {
		return leaf;
	}

	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	/**
	 * 以下全是CategoryDAO层的东西
	 */

	/**
	 * 添加根节点到数据库
	 */
	public static void save(Category c) {
		Connection conn = null;
		PreparedStatement pStatement = null;
		try {
			conn = DB.getConnection();
			String sql = "";
			if (c.getId() == -1) {
				sql = "insert into category values (null,?,?,?,?,?)";
			} else {
				sql = "insert into category values (" + c.getId()
						+ ",?,?,?,?,?)";
			}
			pStatement = DB.preparedStatement(conn, sql);
			pStatement.setString(1, c.getName());
			pStatement.setString(2, c.getDescr());
			pStatement.setInt(3, c.getPid());
			pStatement.setInt(4, c.isLeaf() ? 0 : 1);
			pStatement.setInt(5, c.getGrade());
			pStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeStatement(pStatement);
		}
	}

	/**
	 * 以下两个方法实现递归所有目录
	 * 
	 * @return
	 */
	public static List<Category> getCategories() {
		List<Category> list = new ArrayList<Category>();
		getCategories(list, 0);
		return list;
	}

	public static void getCategories(List<Category> list, int id) {
		Connection conn = null;
		try {
			conn = DB.getConnection();
			getCategories(conn, list, id);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private static void getCategories(Connection conn, List<Category> list,
			int id) {
		ResultSet resultSet = null;
		String sql = "select * from category where pid='" + id + "'";
		try {
			resultSet = DB.executeQuery(conn, sql);
			while (resultSet.next()) {
				Category category = new Category();
				category.setId(resultSet.getInt("id"));
				category.setName(resultSet.getString("name"));
				category.setDescr(resultSet.getString("descr"));
				category.setPid(resultSet.getInt("pid"));
				category.setLeaf(resultSet.getInt("isleaf") == 0 ? true : false);
				category.setGrade(resultSet.getInt("grade"));
				list.add(category);
				if (!category.isLeaf()) {
					getCategories(list, category.getId());
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
		}

	}

	/**
	 * 添加新的子节点到数据库，并更新父节点
	 * 
	 * @param pid
	 * @param name
	 * @param descr
	 */
	public static void saveChild(int pid, String name, String descr) {
		Connection conn = null;
		PreparedStatement pStatement = null;
		ResultSet rs = null;
		String sql = "";
		try {
			conn = DB.getConnection();
			conn.setAutoCommit(false);
			// 添加新的子节点
			sql = "select * from category where id='" + pid + "'";
			rs = DB.executeQuery(conn, sql);
			rs.next();
			int parentGrade = rs.getInt("grade");
			sql = "insert into category values (null,?,?,?,?,?)";
			pStatement = DB.preparedStatement(conn, sql);
			pStatement.setString(1, name);
			pStatement.setString(2, descr);
			pStatement.setInt(3, pid);
			pStatement.setInt(4, 0);
			pStatement.setInt(5, parentGrade + 1);
			pStatement.executeUpdate();
			// 更新父节点
			sql = "update category set isleaf = 1 where id = '" + pid + "'";
			pStatement = DB.preparedStatement(conn, sql);
			pStatement.executeUpdate();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeStatement(pStatement);
		}
	}

	/**
	 * 根据id获取category的name
	 * 
	 * @param categoryid
	 * @return
	 */
	public static String getCategoryById(int categoryid) {
		Connection conn = null;
		ResultSet rs = null;
		String returnString = "";
		try {
			conn = DB.getConnection();
			String sql = "select * from category where id='" + categoryid + "'";
			rs = DB.executeQuery(conn, sql);
			rs.next();
			returnString = rs.getString("name");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeResultSet(rs);
		}
		return returnString;
	}
    /**
     * 获取某个id根目录下的子目录List
     */
	public static List<Category> getCategories(int id) {
		Connection conn = null;
		ResultSet resultSet = null;
		List<Category> list = new ArrayList<Category>();
		String sql = "select * from category where pid='" + id + "'";
		try {
			conn = DB.getConnection();
			resultSet = DB.executeQuery(conn, sql);
			while (resultSet.next()) {
				Category category = new Category();
				category.setId(resultSet.getInt("id"));
				category.setName(resultSet.getString("name"));
				category.setDescr(resultSet.getString("descr"));
				category.setPid(resultSet.getInt("pid"));
				category.setLeaf(resultSet.getInt("isleaf") == 0 ? true : false);
				category.setGrade(resultSet.getInt("grade"));
				list.add(category);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
		}
		return list;

	}
}
