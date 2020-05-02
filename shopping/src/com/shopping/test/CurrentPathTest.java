package com.shopping.test;

import java.io.File;

public class CurrentPathTest {
   public static void main(String[] args) {
    System.out.println(new File("src/chartPath.properties").getAbsolutePath());	
 }
}
