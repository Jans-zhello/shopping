package com.shopping.TagLibrary;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
/**
 * 自定义实现jstl
 * @author Administrator
 *
 */
public class MyTagLibiary extends SimpleTagSupport {
     @Override
    public void doTag() throws JspException, IOException {
      this.getJspContext().getOut().write("hello world");
     }
}
