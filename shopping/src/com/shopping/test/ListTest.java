package com.shopping.test;

import java.util.ArrayList;
import java.util.List;

public class ListTest {
	
   
	public static void main(String[] args) {
		/**
		 * ���ֱ�ӽ�һ��List��ֵ����һ��List����ᵼ�¸�����List��ָ��ͬһ����ַ
		 */
		List<Integer> list;
		List<Integer> list2 = new ArrayList<Integer>();
		list2.add(1);
		list2.add(2);
		list = list2;
		list2.remove(1);
		System.out.println(list.size());
	}

}
