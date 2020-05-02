package com.shopping.upload;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileUpload extends HttpServlet {
	
	private File uploadPath = null;// 存放上传的文件的目录
	
	
	@Override
	public void init(ServletConfig config) throws ServletException {
       uploadPath = new File(config.getInitParameter("uploadPath"));
       if (!uploadPath.isDirectory())
			uploadPath.mkdir();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("请求内容的长度为：" + request.getContentLength());
		out.println("请求内容的类型为：" + request.getContentType());

		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(uploadPath);
		factory.setSizeThreshold(4096);

		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(1100000);
		List<?> fileitems = null;
		try {
			fileitems = upload.parseRequest(request);
			Iterator<?> iterator = fileitems.iterator();
			String regex = ".+\\\\(.+)$";
			String[] errortype = { ".exe", ".com", ".cgi", ".jsp" };
			Pattern p = Pattern.compile(regex);
			int productid = 0;
			while (iterator.hasNext()) {
				FileItem item = (FileItem) iterator.next();
				//获取表单字段内容写法
				if (item.isFormField()) {
					if (item.getFieldName().equals("id")) {
						productid = Integer.parseInt(item.getString());
					}
				}
				//获取表单非字段内容写法
				if (!item.isFormField()) {
					String name = item.getName();
					long size = item.getSize();
					if (name == null || name.equals("") && size == 0)
						continue;
					Matcher m = p.matcher(name);
					if (m.find()) {
						for (int temp = 0; temp < errortype.length; temp++) {
							if (m.group(1).endsWith(errortype[temp]))
								throw new IOException(name + ":wrong type");
						}
						try {
							item.write(new File(uploadPath,productid+".jpg"));
							out.println(name + " " + size + "<br/>");
							out.println("上传成功");
						} catch (Exception e) {
							out.println("333" + e);
						}
					} else {
						throw new IOException("fail to upload");
					}

				}
			}
		} catch (IOException e) {
			out.println("222" + e);
		} catch (FileUploadException e1) {
			e1.printStackTrace();
			out.println("111" + e1);
		}
	}
	public void destroy() {
		super.destroy();
	}

}
