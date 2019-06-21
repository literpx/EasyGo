package servlet;

import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import bean.Comment;
import bean.Commodity;
import bean.Indent;
import bean.ShoppingTrolley;
import bean.User;
import db.CommentFacade;
import db.Data;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Data data=new Data();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		CommentFacade commentFacade=new CommentFacade();
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setHeader("content-type", "text/html;charset=utf-8");  
		HttpSession session = request.getSession();
		String reqtype=request.getParameter("reqtype");
		String datas="";
		if(reqtype!=null)
		switch(reqtype) {
		case "checkUserName":{
			String username=request.getParameter("username");
			try {
				datas=data.searchUserName(username);
				response.getWriter().println(datas);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		}
		case "reg":{
			String reqCode=request.getParameter("regCode");
			String randStr = (String)session.getAttribute("randStr");
			if(reqCode.toUpperCase().equals(randStr.toUpperCase())) {     //��֤��������ȷ
				String username=request.getParameter("username");
				String password=request.getParameter("password");
				int res = 0;
				try {
					res = data.regUser(username, password);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(res>0) {
					response.getWriter().println("ע��ɹ�");
				}
			}else {
				response.getWriter().println("��֤�����");
			}
			break;
		}
		case "login":{
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			User user = null;
			try {
				user = data.getUser(-1,username, password);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(user!=null) {
				session.setAttribute("user", user);
				ArrayList<ShoppingTrolley> userCart=null;      //��ȡ�û����ﳵ
				try {
					userCart=data.getCartByUid(user.getuId());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				session.setAttribute("userCart", userCart);
				response.getWriter().println("��¼�ɹ�");
			}else {
				response.getWriter().println("��¼ʧ��");
			}
			break;
		}
		case "regMerchant":{
			User user=(User)session.getAttribute("user");
			int row=data.regMerchant(user.getuId());
			if(row>0) {
				try {
					user=data.getUser(user.getuId(),null, null);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				response.getWriter().println("ע��ɹ�");
				session.setAttribute("user", user);
			}else {
				response.getWriter().println("ע��ʧ��");
			}
			break;
		}
		case "updateMName":{
			String mName=request.getParameter("mName");
			User user=(User)session.getAttribute("user");
			int uid=user.getuId();
			int row=0;
			try {
				row = data.updateMName(uid,mName);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(row>0) {
				user.setmName(mName);
				response.getWriter().println("�޸ĳɹ�");
				session.setAttribute("user", user);
			}else {
				response.getWriter().println("ע��ʧ�ܣ����ܵ������Ѵ���");
			}
			break;
		}
		case "updatePhone":{
			String phone=request.getParameter("phone");
			User user=(User)session.getAttribute("user");
			int uid=user.getuId();
			int row=0;
			try {
				row = data.updatePhone(uid,phone);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(row>0) {
				user.setPhone(phone);
				response.getWriter().println("�޸ĳɹ�");
				session.setAttribute("user", user);
			}else {
				response.getWriter().println("ע��ʧ�ܣ������ֻ����Ѵ���");
			}
			break;
		}
		case "pushDownCom":{ //�¼���Ʒ
			int cId=Integer.valueOf(request.getParameter("cId"));
			int row=data.pushOrDowmCom(cId, 0);
			if(row>0) {
				response.getWriter().println("���¼�");
			}
			break;
		}
		case "pushCom":{ //�¼���Ʒ
			int cId=Integer.valueOf(request.getParameter("cId"));
			int row=data.pushOrDowmCom(cId, 1);
			if(row>0) {
				response.getWriter().println("���ϼ�");
			}
			break;
		}
		case "getToCart":{            //���빺�ﳵ
			int cId=Integer.valueOf(request.getParameter("cId"));
			int uId=Integer.valueOf(request.getParameter("uId"));
			int row=0;
			try {
				row=data.getToCart(cId, uId);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			if(row>0) {
				ArrayList<ShoppingTrolley> userCart=null;
				try {
					userCart=data.getCartByUid(uId);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				session.setAttribute("userCart", userCart);
				response.getWriter().println("�ɹ�");
			}else {
				response.getWriter().println("���빺�ﳵʧ��");
			}
			break;
		}
		case "payRequset":{              //֧������
			String cIds=request.getParameter("cIds");
			String cNums=request.getParameter("cNums");
			String addr=request.getParameter("addr");
			String phone=request.getParameter("phone");
			float sumMoney=Float.valueOf(request.getParameter("sumMoney"));
			int uId=Integer.valueOf(request.getParameter("uid"));
			String[] arraycIds=cIds.split("&");
			String[] arraycNums=cNums.split("&");
			int row=0;
			Map<String, Serializable> res=new HashMap();
			Set uids=new HashSet();
			try {
				if(data.subUserMoney(uId,sumMoney)>0) {
					for(int i=0;i<arraycIds.length;i++) {
						int cid=Integer.valueOf(arraycIds[i]);
						int cNumber=Integer.valueOf(arraycNums[i]);
						HashMap ids=data.getMidAndUidByCid(Integer.valueOf(arraycIds[i]));
						Integer mid=(Integer) ids.get("mId");
						uids.add(ids.get("uId"));
						if(data.insertIndent(uId,cid,mid,cNumber,addr,phone)>0) {
							data.deleteCartByCidUid(cid,uId);     //ɾ�����ﳵ
							row=1;
						}else {
							row=0;
							data.subUserMoney(uId,-sumMoney);
							break;
						}
					}
					if(row==1) {
						//ˢ��session���û���Ϣ�͹��ﳵ��Ϣ
						User user=(User)session.getAttribute("user");
						user.setMoney(data.getUserMoney(user.getuId()));
						ArrayList<ShoppingTrolley> userCart=null;
						try {
							userCart=data.getCartByUid(user.getuId());
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						session.setAttribute("user", user);
						session.setAttribute("userCart", userCart);
						
						res.put("state", "֧���ɹ�");
						res.put("uids",(Serializable) uids);
						
					}else {
						res.put("state", "֧��ʧ��");
					}
				}else{
					res.put("state", "����");
					response.getWriter().println("");
				}
				JSONObject mapObject=JSONObject.fromObject(res);
				response.getWriter().println(mapObject);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		}
		case "startFaHuo":{                        //��ʼ��������
			int cId=Integer.valueOf(request.getParameter("cId"));
			int iId=Integer.valueOf(request.getParameter("iId"));
			int number=Integer.valueOf(request.getParameter("number"));
			String companyName=request.getParameter("companyName");
			Map<String, String> res=new HashMap();
			User user=(User)session.getAttribute("user");
			if(data.subComsNumber(cId,number)>0) {    //��湻
				//�޸Ķ���״̬�������ӿ�ݹ�˾����
				if(data.updateIndent(iId,companyName,new String("�ͻ���"),2)>0) {
					res.put("state", "�����ɹ�");
					res.put("msg", companyName);
					
					ArrayList<Indent> merchantIndent=null;       //ˢ���̼Ҷ���
					merchantIndent=data.getIndentByMidOrUid(user.getmId(),-1);
					session.setAttribute("merchantIndent", merchantIndent);
				}
			}else {
				res.put("state", "��治��");
			}
			response.getWriter().println(JSONObject.fromObject(res));
			break;
		}
		case "reqConfirm":{   //�û�ȷ���ջ�����
			int cId=Integer.valueOf(request.getParameter("cId"));
			int iId=Integer.valueOf(request.getParameter("iId"));
			int number=Integer.valueOf(request.getParameter("number"));
			Map<String, String> res=new HashMap();
			if(data.addMerchantMoney(cId,number)>0&&data.updateIndent(iId, null, new String("������"),3)>0) {        //�����̼ҵ��û����
				ArrayList<Indent> userIndent=null;       //�����û�����
				User user=(User) session.getAttribute("user");
				userIndent=data.getIndentByMidOrUid(-1,user.getuId());
				session.setAttribute("userIndent", userIndent);
				res.put("state", "�ջ��ɹ�");
			}else {
				res.put("state", "�ջ�ʧ��");
			}
			response.getWriter().println(JSONObject.fromObject(res));
			break;
		}
		case "createComment":{                //����
			User user=(User)session.getAttribute("user");
			int uId=user.getuId();
			int cid=Integer.valueOf(request.getParameter("cId"));
			int iId=Integer.valueOf(request.getParameter("iId"));
			String  content=request.getParameter("content");
			Map<String, String> res=new HashMap();
			Date time=new Date();
			Comment comment=new Comment();
			comment.setCid(cid);
			comment.setUid(uId);
			comment.setContent(content);
			comment.setTime(time.toLocaleString());
			if(commentFacade.create(comment)>0&&data.updateIndent(iId, null, new String("�����"),4)>0) {
				ArrayList<Indent> userIndent=null;       //�����û�����
				userIndent=data.getIndentByMidOrUid(-1,user.getuId());
				session.setAttribute("userIndent", userIndent);
				res.put("state", "���۳ɹ�");
			}else {
				res.put("state", "����ʧ��");
			}
			response.getWriter().println(JSONObject.fromObject(res));
			break;
		}
		case "sendChildrenComment":{      //������
			int uId=Integer.valueOf(request.getParameter("uId"));
			String rId=request.getParameter("rId");
			String  content=request.getParameter("content");
			Date time=new Date();
			Comment comment=new Comment();
			comment.setUid(uId);
			comment.setContent(content);
			comment.setTime(time.toLocaleString());
			commentFacade.insertComentChildren(rId,comment);
			Map<String, String> res=new HashMap<String, String>();
			res.put("state", "���۳ɹ�");
			response.getWriter().println(JSONObject.fromObject(res));
			break;
		}
		case "reqSearch":{        //����
			String conetent=request.getParameter("conetent");
			List<Commodity> searchCom=null;
			try {
				searchCom=data.findCom(conetent);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.setAttribute("searchCom", searchCom);
			break;
		}
		/************************************************����*************************************************/
		case "doUnPick":{
			String rId=request.getParameter("rId");
			String isPick=request.getParameter("isPick");
			int uId=Integer.valueOf(request.getParameter("uId"));
			if(isPick!=null) {
				commentFacade.updateComentPickOrNot(rId,uId,"$pull",new String("pick"));
			}
			commentFacade.updateComentPickOrNot(rId,uId,"$push",new String("unpick"));
			break;
		}
		case "doCancelUnPick":{
			String rId=request.getParameter("rId");
			int uId=Integer.valueOf(request.getParameter("uId"));
			commentFacade.updateComentPickOrNot(rId,uId,"$pull",new String("unpick"));
			break;
		}
		case "doPick":{
			String rId=request.getParameter("rId");
			int uId=Integer.valueOf(request.getParameter("uId"));
			String isUnPick=request.getParameter("isUnPick");
			if(isUnPick!=null) {
				commentFacade.updateComentPickOrNot(rId,uId,"$pull",new String("unpick"));
			}
			commentFacade.updateComentPickOrNot(rId,uId,"$push",new String("pick"));
			break;
		}
		case "doCancelPick":{
			String rId=request.getParameter("rId");
			int uId=Integer.valueOf(request.getParameter("uId"));
			commentFacade.updateComentPickOrNot(rId,uId,"$pull",new String("pick"));
			break;
		}
		case "updateChildrenComment":{
			String rId=request.getParameter("rId");
			int uId=Integer.valueOf(request.getParameter("uId"));
			int uuId=Integer.valueOf(request.getParameter("uuId"));
			String handle=request.getParameter("handle");
			String pick=request.getParameter("pick");
			String isPick=request.getParameter("isPick");        //�ж����޻���෴���Ǹ���ť�Ƿ��ѵ��ss
			if(!StringUtils.isBlank(isPick)) {
				commentFacade.updateChildrenComentPickOrNot(rId,uId,uuId,"$pull",isPick);
			}
			commentFacade.updateComentChildren(rId, uId, uuId, handle,pick);
			Map<String, String> res=new HashMap<String, String>();
			res.put("state", "���۳ɹ�");
			response.getWriter().println(JSONObject.fromObject(res));
			break;
		}
		/************************************����*************************************************/
		case "getuIdBymId":{
			int mId=Integer.valueOf(request.getParameter("mId"));
			int uId=data.getuIdBymId(mId);
			Map<String, String> res=new HashMap<String, String>();
			if(uId>0) {
				res.put("state", "�ɹ�");
				res.put("uId", uId+"");
			}else {
				res.put("state", "�����ӳ٣����Ժ����²���");
			}
			response.getWriter().println(JSONObject.fromObject(res));
			break;
		}
		case "test":{
			String id=request.getParameter("content");
			int id2=Integer.valueOf(id);
			
			//commentFacade.insertChildrenContent(id2);
			
			//����insert������
//			Date time=new Date();
//			Comment comment=new Comment();
//			comment.setuId(3);
//			comment.setContent("4444444");
//			comment.setTime(time.toLocaleString());
//			commentFacade.insertComentChildren(46,comment);  //����cid,����
			
			//����update������
			//commentFacade.updateComentChildren(46,3,id2,new String("pick"));
			break;
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
