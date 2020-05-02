package com.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.shopping.Utils.DB;
import com.shopping.Utils.PasswordNotCorrectException;
import com.shopping.Utils.UserNotFoundException;

public class User {
	private int id;// 一般情况下与数据库字段名一致
	private String username;
	private String password;
	private String phone;
	private String addr;
	private Date rdate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public java.util.Date getRdate() {
		return rdate;
	}

	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}

	/**
	 * UserDAO层
	 */
	public void save() {
		Connection conn = null;
		PreparedStatement pStatement = null;
		try {
			conn = DB.getConnection();
			String sql = "insert into ruser values (null,?,?,?,?,?)";
			pStatement = DB.preparedStatement(conn, sql);
			pStatement.setString(1, username);
			pStatement.setString(2, password);
			pStatement.setString(3, phone);
			pStatement.setString(4, addr);
			pStatement.setTimestamp(5, new Timestamp(rdate.getTime()));
			pStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeStatement(pStatement);
		}

	}

	public static List<User> getUsers() {
		List<User> userlists = new ArrayList<User>();
		Connection conn = null;
		ResultSet resultSet = null;
		String sql = "select * from ruser";
		try {
			conn = DB.getConnection();
			resultSet = DB.executeQuery(conn, sql);
			while (resultSet.next()) {
				User user = new User();
				user.setId(resultSet.getInt("id"));
				user.setUsername(resultSet.getString("username"));
				user.setPassword(resultSet.getString("password"));
				user.setPhone(resultSet.getString("phone"));
				user.setAddr(resultSet.getString("addr"));
				user.setRdate(resultSet.getTimestamp("rdate"));
				userlists.add(user);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeResultSet(resultSet);
			DB.closeConn(conn);
		}

		return userlists;
	}

	public static void deleteUser(int id) {
		Connection conn = null;
		Statement statement = null;
		try {
			conn = DB.getConnection();
			statement = DB.createStatement(conn);
			statement.executeUpdate("delete from ruser where id=" + id);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeStatement(statement);
		}

	}
	public static boolean validateUsernameOfAjax(String username)
			throws UserNotFoundException, PasswordNotCorrectException {
		Connection conn = null;
		ResultSet rs = null;
		User u = null;
		try {
			conn = DB.getConnection();
			String sql = "select * from ruser where username='" + username
					+ "'";
			rs = DB.executeQuery(conn, sql);
			if (rs.next()) {
				return true;
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeResultSet(rs);
		}
		return false;
	}
	
	public static User validate(String username, String password)
			throws UserNotFoundException, PasswordNotCorrectException {
		Connection conn = null;
		ResultSet rs = null;
		User u = null;
		try {
			conn = DB.getConnection();
			String sql = "select * from ruser where username='" + username
					+ "'";
			rs = DB.executeQuery(conn, sql);
			if (!rs.next()) {
				throw new UserNotFoundException();
			} else if (!rs.getString("password").equals(password)) {
				throw new PasswordNotCorrectException();
			} else {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeResultSet(rs);
		}
		return u;
	}

	public void update() {
		Connection conn = null;
		Statement statement = null;
		try {
			String sql = "update ruser set username='" + username + "',phone='"
					+ phone + "',addr='" + addr + "' where id='" + id + "'";
			conn = DB.getConnection();
			statement = DB.createStatement(conn);
			statement.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
			DB.closeStatement(statement);
		}
	}
}
