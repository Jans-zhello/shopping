package com.shopping.TagLibrary;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
/**
 * �Զ���ʵ��jstl
 * @author Administrator
 *
 */
public class MyTagLibiary extends SimpleTagSupport {
     @Override
    public void doTag() throws JspException, IOException {
      this.getJspContext().getOut().write("hello world");
     }
}
