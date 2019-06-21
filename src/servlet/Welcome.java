package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Comment;
import bean.Commodity;
import bean.Indent;
import bean.User;
import db.CommentFacade;
import db.Data;

/**
 * Servlet implementation class Welcome
 */
@WebServlet("/navTab")
public class Welcome extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Welcome() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Data data=new Data();
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("user");
		String nav=request.getParameter("nav");
		switch(nav) {
			case "index":{
				List<Commodity> allCom=null;          //初始化所有商品
				try {
					allCom=data.findCom(null);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				//request.setAttribute("allCom", allCom);
				ServletContext application=this.getServletContext();  
				application.setAttribute("allCom", allCom);
				
				
				List<String> allType=null;          //初始化所有是商品类型
				try {
					allType=data.getAllType();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				application.setAttribute("allType", allType);
				
				List<String> allCompany=null;          //初始化所有快递公司列表
				try {
					allCompany=data.allCompany();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println(allCompany);
				application.setAttribute("allCompany", allCompany);
				
				break;
			}
			case "MyCommodity":{
				System.out.println("MyCommodity");
				
				int mId=user.getmId();
				List<Commodity> comList=null;
				try {
					comList=data.findMyCom(mId);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				session.setAttribute("myCom", comList);
				
				if(user.getIsMerchants()) {        //如果是商家，获取商家订单信息
					ArrayList<Indent> merchantIndent=null;       //获取用户订单
					merchantIndent=data.getIndentByMidOrUid(mId,-1);
					session.setAttribute("merchantIndent", merchantIndent);
				}
				break;
			}
			case "getMe":{
				System.out.println("getMe");
				ArrayList<Indent> userIndent=null;       //获取用户订单
				userIndent=data.getIndentByMidOrUid(-1,user.getuId());
				session.setAttribute("userIndent", userIndent);
				response.getWriter().print("ok");
				break;
			}
			case "reqComment":{
				int cId=Integer.valueOf(request.getParameter("cId"));   //由商品id获取商品评论
				
				CommentFacade commentFacade=new CommentFacade();
				ArrayList<Comment> cComment=commentFacade.find(cId); 
				//由得到的uid获取评论的用户信息	
				for(Comment comment:cComment) {
					System.out.println(comment.getUid());
					HashMap<String, String> userInfo = null;
					try {
						userInfo = data.getUserNameAndHead(comment.getUid());
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					comment.setuHead(userInfo.get("head"));
					comment.setuName(userInfo.get("uName"));
					for(Comment commentChildren:comment.getChildrenComment()) {
						HashMap<String, String> userInfoChildren = null;
						try {
							userInfoChildren = data.getUserNameAndHead(commentChildren.getUid());
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						commentChildren.setuHead(userInfoChildren.get("head"));
						commentChildren.setuName(userInfoChildren.get("uName"));
					}
				}
				session.setAttribute("cComment", cComment);
				response.getWriter().print("ok");
				break;
			}
		}
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
