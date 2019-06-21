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
		//2、创建一个文件上传解析器
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
		
		String cType="";      //商品类型
		String cPic="";      //图片路径
		for(FileItem item : list){
            //如果fileitem中封装的是普通输入项的数据
            if(item.isFormField()){
            	String value = item.getString("UTF-8");
            	//System.out.println(item.getFieldName());
            	if(item.getFieldName().equals("type")) {
            		cType+=value+"&";
            	}else {
            		pList.add(value);//将非文件的其他参数放到一个list中，后面可以顺序的去取到
            	}
            	
            //	System.out.println("name-"+item.getFieldName()+",value-"+value);
            	continue;
            }else{//如果fileitem中封装的是上传文件
            	InputStream stream=item.getInputStream();//上传文件需要的文件流参数
            	filename=item.getName();   //上传文件需要的参数
                if(filename==null || filename.trim().equals("")){
                //判空处理}
                continue;
                }
                String savepath="D:/javaUpload/";
                cPic+=Upload.uploadFile(stream, savepath,filename)+"&";   //调用工具类方法
            }
		}
		System.out.println(pList);
//		//开始顺序取非文件参数
//		for(String i : pList) {
//			System.out.println(i);
//		}
		//System.out.println(pList.size());  //为5就正确
				if(cPic.length()>0) {
					cPic=cPic.substring(0, cPic.length()-1);
				}
				//System.out.println(cType); 
				String name=pList.get(0);
				String price=pList.get(1);
				String number=pList.get(2);
				String otherType=pList.get(3);
				String desc=pList.get(4);
				if(!StringUtils.isBlank(otherType)) {    //添加一个新的类型到类型表中
					try {
						data.insertCType(otherType);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(StringUtils.isBlank(cType)) {      //只填其他类型
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
						System.out.println("发布成功！");
						
						
						//request.getRequestDispatcher("/welcome.jsp").forward(request, response);
						response.getWriter().println("发布成功");
					}else {
						String[] pic_array=cPic.split("&");
						for(String str:pic_array) {
							Upload.deleteFile("D:/"+str);  
						}
						response.getWriter().println("发布失败");
					}
				}else if(pList.size()>5){
					System.out.println(pList.get(5)+"----"+pList.get(6));     //pList.get(6)为1：改1第图，3：改第2图，5：该第3图
					commodity.setcId(Integer.valueOf(pList.get(5)));		// 4：改1，2图，6：改1，3图，8：改2，3图，9:改1，2，3图
					String changedNum=pList.get(6);
					try {
						row=data.updateCommodity(commodity,changedNum,"D:/");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					if (row>0) {
						System.out.println("修改成功！");
						//request.getRequestDispatcher("/welcome.jsp").forward(request, response);
						response.getWriter().println("修改成功");
					}else {
						String[] pic_array=cPic.split("&");
						for(String str:pic_array) {
							Upload.deleteFile("D:/"+str);
						}
						response.getWriter().println("修改失败");
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
