package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;

import com.Upload;

import bean.Commodity;
import bean.User;
import db.Data;

/**
 * Servlet implementation class GoodsUpload
 */
@WebServlet("/GoodsUpload")
public class GoodsUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoodsUpload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("6666666666");
		// TODO Auto-generated method stub
		response.setCharacterEncoding("utf-8");
		response.setHeader("content-type", "text/html;charset=utf-8"); 
		Data data=new Data();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//2������һ���ļ��ϴ�������
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<String> pList = new ArrayList<>();
		List<FileItem> list = null;
		String filename=null;
		
		try {
			list = upload.parseRequest(request);
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String cType="";      //��Ʒ����
		String cPic="";      //ͼƬ·��
		for(FileItem item : list){
            //���fileitem�з�װ������ͨ�����������
            if(item.isFormField()){
            	String value = item.getString("UTF-8");
            	//System.out.println(item.getFieldName());
            	if(item.getFieldName().equals("type")) {
            		cType+=value+"&";
            	}else {
            		pList.add(value);//�����ļ������������ŵ�һ��list�У��������˳���ȥȡ��
            	}
            	
            //	System.out.println("name-"+item.getFieldName()+",value-"+value);
            	continue;
            }else{//���fileitem�з�װ�����ϴ��ļ�
            	InputStream stream=item.getInputStream();//�ϴ��ļ���Ҫ���ļ�������
            	filename=item.getName();   //�ϴ��ļ���Ҫ�Ĳ���
                if(filename==null || filename.trim().equals("")){
                //�пմ���}
                continue;
                }
                String savepath="D:/javaUpload/";
                cPic+=Upload.uploadFile(stream, savepath,filename)+"&";   //���ù����෽��
            }
		}
		System.out.println(pList);
//		//��ʼ˳��ȡ���ļ�����
//		for(String i : pList) {
//			System.out.println(i);
//		}
		//System.out.println(pList.size());  //Ϊ5����ȷ
				if(cPic.length()>0) {
					cPic=cPic.substring(0, cPic.length()-1);
				}
				//System.out.println(cType); 
				String name=pList.get(0);
				String price=pList.get(1);
				String number=pList.get(2);
				String otherType=pList.get(3);
				String desc=pList.get(4);
				if(!StringUtils.isBlank(otherType)) {    //���һ���µ����͵����ͱ���
					try {
						data.insertCType(otherType);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(StringUtils.isBlank(cType)) {      //ֻ����������
					cType=otherType;
				}else if(!StringUtils.isBlank(otherType)){
					
					cType+=otherType;
				}else {
					cType=cType.substring(0, cType.length()-1);
				}
				Commodity commodity=new Commodity();
				User user=(User) request.getSession().getAttribute("user");
				int mId=user.getmId();
				commodity.setcName(name); 
				commodity.setcPic(cPic);
				commodity.setcType(cType);
				commodity.setmId(mId);
				commodity.setNumber(Integer.valueOf(number));
				commodity.setPrice(Float.valueOf(price));
				commodity.setContent(desc);
				int row=0;		
				if(pList.size()==5) {
					try {
						row=data.insertCommodity(commodity);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					if (row>0) {
						System.out.println("�����ɹ���");
						
						
						//request.getRequestDispatcher("/welcome.jsp").forward(request, response);
						response.getWriter().println("�����ɹ�");
					}else {
						String[] pic_array=cPic.split("&");
						for(String str:pic_array) {
							Upload.deleteFile("D:/"+str);  
						}
						response.getWriter().println("����ʧ��");
					}
				}else if(pList.size()>5){
					System.out.println(pList.get(5)+"----"+pList.get(6));     //pList.get(6)Ϊ1����1��ͼ��3���ĵ�2ͼ��5���õ�3ͼ
					commodity.setcId(Integer.valueOf(pList.get(5)));		// 4����1��2ͼ��6����1��3ͼ��8����2��3ͼ��9:��1��2��3ͼ
					String changedNum=pList.get(6);
					try {
						row=data.updateCommodity(commodity,changedNum,"D:/");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					if (row>0) {
						System.out.println("�޸ĳɹ���");
						//request.getRequestDispatcher("/welcome.jsp").forward(request, response);
						response.getWriter().println("�޸ĳɹ�");
					}else {
						String[] pic_array=cPic.split("&");
						for(String str:pic_array) {
							Upload.deleteFile("D:/"+str);
						}
						response.getWriter().println("�޸�ʧ��");
					}
				}
				
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
