package com.shopping.Utils;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

public class ServerConfig {
	private static Properties p = new Properties();
	static{
	   try {
		p.load(new FileInputStream("../webapps/shopping/WEB-INF/classes/chartPath.properties"));
	} catch (Exception e) {
	    e.printStackTrace();
	    System.out.println("���������������ļ�����");
	}
  }
	
	public static String getValue(String key){
           return p.getProperty(key);		
	}
}
	
	
	