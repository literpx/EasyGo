package servlet;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import bean.User;
import db.Data;

/**
 * Servlet implementation class FileUpload
 */
@WebServlet("/FileUpload")
public class FileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int SAVEAS_VIRTUAL = 0;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUpload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Data data=new Data();
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setHeader("content-type", "text/html;charset=utf-8");  
		HttpSession session=request.getSession();
		String pathss=request.getSession().getServletContext().getRealPath("/")+"upload";
		System.out.println(pathss);
		User user=(User) session.getAttribute("user");
		int uid=user.getuId();

		
		// 创建SmartUpload对象
		 SmartUpload su = new SmartUpload();
		// 初始化对象
		su.initialize(getServletConfig(), request, response);
		 // 设置上传文件大小
		su.setTotalMaxFileSize(1024 * 1024 * 5);
		// 设置上传文件类型
		su.setAllowedFilesList("jpg,png");
		// 创建提示变量
		String result = "上传失败";
		int count=0;
		try {
			// 设置禁止上传类型
			su.setDeniedFilesList("rar,jsp,js");
		   su.upload();
		   // 返回上传文件数量
		} catch (Exception e) {
		 result = "上传失败";
		 e.printStackTrace();
		}
		System.out.println(su.getFiles().getCount());
		for (int i = 0; i < su.getFiles().getCount(); i++) {
			 com.jspsmart.upload.File file = su.getFiles().getFile(i);
			 if(file.isMissing())continue;
			 String filePath =  "javaUpload/head/";
			 
			 filePath=filePath+uid+"."+file.getFileExt();
			 System.out.println(filePath);
			 try {
				file.saveAs("D:/"+filePath,SmartUpload.SAVE_PHYSICAL);
				//相对路径存数据库
				int row=data.updateUserHead(uid, filePath);
				if(row>0) {
					count++;
					 result = "上传成功";
					 user.setHead(filePath);
					 session.setAttribute("user", user);
				}
				 
			} catch (SmartUploadException e) {
				 result = "上传失败";
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			 
		}
		System.out.println("上传成功" + count + "个文件！");
		
		response.getWriter().println(result);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
