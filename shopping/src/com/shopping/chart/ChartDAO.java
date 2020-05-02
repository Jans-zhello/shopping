package com.shopping.chart;

import java.sql.Connection;
import java.sql.ResultSet;

import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

import com.shopping.Utils.DB;

public class ChartDAO {
	public void getDataSet(DefaultCategoryDataset dataset,DefaultPieDataset dataset2) {
		Connection conn = null;
		ResultSet rs = null;
		String sql = "";
		try {
			conn = DB.getConnection();
			sql = "select product.name,sum(salesitem.pcount) as pcount from product left join salesitem on (product.id = salesitem.productid) group by product.id";
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
               dataset.addValue(rs.getInt("pcount"), "", rs.getString("name"));
               dataset2.setValue(rs.getString("name"), rs.getInt("pcount"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DB.closeConn(conn);
			DB.closeResultSet(rs);
		}
	}
}
