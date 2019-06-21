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

		
		// ����SmartUpload����
		 SmartUpload su = new SmartUpload();
		// ��ʼ������
		su.initialize(getServletConfig(), request, response);
		 // �����ϴ��ļ���С
		su.setTotalMaxFileSize(1024 * 1024 * 5);
		// �����ϴ��ļ�����
		su.setAllowedFilesList("jpg,png");
		// ������ʾ����
		String result = "�ϴ�ʧ��";
		int count=0;
		try {
			// ���ý�ֹ�ϴ�����
			su.setDeniedFilesList("rar,jsp,js");
		   su.upload();
		   // �����ϴ��ļ�����
		} catch (Exception e) {
		 result = "�ϴ�ʧ��";
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
				//���·�������ݿ�
				int row=data.updateUserHead(uid, filePath);
				if(row>0) {
					count++;
					 result = "�ϴ��ɹ�";
					 user.setHead(filePath);
					 session.setAttribute("user", user);
				}
				 
			} catch (SmartUploadException e) {
				 result = "�ϴ�ʧ��";
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			 
		}
		System.out.println("�ϴ��ɹ�" + count + "���ļ���");
		
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
