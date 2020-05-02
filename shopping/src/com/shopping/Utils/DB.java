package com.shopping.Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 数据库操作类
 * 
 * @zzz Administrator
 * 
 */
public class DB {
	// 加载数据库驱动
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 获取连接
	public static Connection getConnection() {

		try {
			return DriverManager
					.getConnection("jdbc:mysql://localhost:3306/shopping?user=root&password=648042475");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// 关闭连接
	public static void closeConn(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			conn = null;
		}
	}

	// 获取statement
	public static Statement createStatement(Connection conn) {
		try {
			return conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
   //获取prepareStatement
	public static PreparedStatement preparedStatement(Connection conn,
			String sql) {
		try {
			return conn.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
   //获取prepareStatement并获取自动生成的key
	public static PreparedStatement preparedStatement(Connection conn,
			String sql,boolean generatedkey) {
		try {
			if (generatedkey) {
				return conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	//关闭statement
	public static void closeStatement(Statement statement){
		if (statement != null) {
			try {
				statement.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			statement = null;
		}
	}
	//获取查询Sql的ResultSet(例)
    public static ResultSet executeQuery(Statement statement,String sql ){
          try {
			return statement.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
    }
	//获取查询Sql的ResultSet(例)
    public static ResultSet executeQuery(Connection conn,String sql ){
          try {
			return conn.createStatement().executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
    }
    //关闭ResultSet
    public static void closeResultSet(ResultSet rs){
    	try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    
    
	/**
	 * java测试是否连接上数据库
	 */
	public static void main(String[] args) throws Exception {
		System.out.println(getConnection());
	}
}
