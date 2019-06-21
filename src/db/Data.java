package db;

import java.io.UnsupportedEncodingException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.tomcat.util.codec.binary.Base64;

import com.Upload;
import com.mysql.jdbc.Statement;

import bean.Commodity;
import bean.Indent;
import bean.ShoppingTrolley;
import bean.User;


public class Data {

    private Conn con = new Conn();
    private Statement stmt;
    private ResultSet rs;
    private PreparedStatement ps = null;
	
    public List<Commodity> findCom(String filter) throws SQLException{  //��ѯ��Ʒ
    	String sql=null;
    	Commodity commodity;
    	Set<Commodity> set=new HashSet<Commodity>();
    	List<Commodity> list = null;
    	if(filter==null||filter.equals("")) {  //ȫ���ѯ
    		list=new ArrayList<Commodity>();
    		sql="select c.c_id,c.sales,c.c_name,c.c_pic,c.c_type,c.m_id,c.number,c.price,m.m_name"
    				+ " from tb_commodity c join tb_merchant m on c.m_id=m.m_id where is_show=1 order by sales,c_id desc";
    		System.out.println(sql);
    		rs=con.getRs(sql);
    		while(rs.next()) {
    			commodity=new Commodity();
    			commodity.setcId(rs.getInt("c_id"));
    			commodity.setcName(rs.getString("c_name"));
    			commodity.setcPic(rs.getString("c_pic"));
    			commodity.setcType(rs.getString("c_type"));
    			commodity.setmId(rs.getInt("m_id"));
    			commodity.setNumber(rs.getInt("number"));
    			commodity.setPrice(rs.getFloat("price"));
    			commodity.setmName(rs.getString("m_name"));
    			commodity.setSales(rs.getInt("sales"));
    			list.add(commodity);
    		}
    		return list;	
    	}else {                  //����ģ��������Ʒ���ơ���Ʒ���͡��̼�����
    		sql="select c.c_id,c.sales,c.c_name,c.c_pic,c.c_type,c.m_id,c.number,c.price,m.m_name"
    				+ " from tb_commodity c join tb_merchant m on c.m_id=m.m_id "
    				+ "where c.c_name like '%"+filter+"%' or c.c_type like '%"+filter+"%' or m.m_name like '%"+filter+"%' and  "
    						+ " is_show=1 order by sales,c_id desc";  
    		System.out.println(sql);
    		rs=con.getRs(sql);
    		while(rs.next()) {
    			commodity=new Commodity();
    			commodity.setcId(rs.getInt("c_id"));
    			commodity.setcName(rs.getString("c_name"));
    			commodity.setcPic(rs.getString("c_pic"));
    			commodity.setcType(rs.getString("c_type"));
    			commodity.setmId(rs.getInt("m_id"));
    			commodity.setNumber(rs.getInt("number"));
    			commodity.setPrice(rs.getFloat("price"));
    			commodity.setmName(rs.getString("m_name"));
    			commodity.setSales(rs.getInt("sales"));
    			set.add(commodity);
    		}
    		list=new ArrayList<Commodity>(set);
    		System.out.println(list);
    		return list;
    	}
			
    }
    public List<Commodity> findMyCom(int mId) throws SQLException{  //��ѯ�ҵ���Ʒ
    	String sql=null;
    	Commodity commodity;
    	Set<Commodity> set=new HashSet<Commodity>();
    	List<Commodity> list = null;
    		list=new ArrayList<Commodity>();
    		sql="select c.c_id,c.sales,c.c_name,c.c_pic,c.c_type,c.m_id,c.number,c.price,m.m_name,c.is_show,c.content"
    				+ " from tb_commodity c join tb_merchant m on c.m_id=m.m_id where m.m_id="+mId +" order by c_id desc";
    		System.out.println(sql);
    		rs=con.getRs(sql);
    		while(rs.next()) {
    			commodity=new Commodity();
    			commodity.setcId(rs.getInt("c_id"));
    			commodity.setcName(rs.getString("c_name"));
    			commodity.setcPic(rs.getString("c_pic"));
    			commodity.setcType(rs.getString("c_type"));
    			commodity.setmId(rs.getInt("m_id"));
    			commodity.setNumber(rs.getInt("number"));
    			commodity.setPrice(rs.getFloat("price"));
    			commodity.setmName(rs.getString("m_name"));
    			commodity.setIsShow(rs.getBoolean("is_show"));
    			commodity.setContent(rs.getString("content"));
    			commodity.setSales(rs.getInt("sales"));
    			list.add(commodity);
    		}
    		return list;	
			
    }
    public ArrayList<String> getAllType() throws SQLException{
    	ArrayList<String> arry=new ArrayList<String>();
    	String sql="select type_name from tb_ctype";
    	rs=con.getRs(sql);
    	while(rs.next()) {
    		arry.add(rs.getString("type_name"));
    	}
		return arry;
    }
    public ArrayList<String> allCompany() throws SQLException{
    	ArrayList<String> arry=new ArrayList<String>();
    	String sql="select com_name from tb_company";
    	rs=con.getRs(sql);
    	while(rs.next()) {
    		arry.add(rs.getString("com_name"));
    	}
		return arry;
    }
    public String searchUserName(String username) throws SQLException {
    	String sql="select u_id from tb_user where u_name=?";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, username);
    	String res="";
    	System.out.println(sql);
    	rs=con.getPs(sql,params);
    	if(rs.next()) {
    		res= "�û����Ѵ��ڣ�";
    	}else {
    		res="";
    	}
    	return res;
    }
    public int regUser(String username,String password) throws SQLException {
    	String sql="insert into tb_user(u_name,password,is_merchants) values(?,?,?)";
    	System.out.println(sql);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, username);
    	params.put(2, password);
    	params.put(3, 0);
    	int row=con.getUpdatePs(sql,params);
    	return row;
    }
    public HashMap<String,String> getUserNameAndHead(int uid) throws SQLException {
    	HashMap<String,String> res=new HashMap<String,String>();
    	String sql="select head,u_name from tb_user where u_id=?";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, uid);
    	rs=con.getPs(sql,params);
    	if(rs.next()) {
    		res.put("head", rs.getString("head"));
    		res.put("uName", rs.getString("u_name"));
    	}
    	return res;
    }
	public User getUser(int uid,String username,String password) throws SQLException {
    	User user=null;
    	String sql=null;
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	if(uid!=-1) {
    		sql="select * from tb_user where u_id=?";
    		params.put(1, uid);
    	}else {
    		//sql="select * from tb_user where u_name='"+username+"' and password='"+password+"'";
    		sql="select * from tb_user where u_name=? and password=?";
    		params.put(1, username);
    		params.put(2, password);
    	}
    	System.out.println(sql);
    	rs=con.getPs(sql,params);
    	if(rs.next()) {
    		user=new User();
    		user.setuId(rs.getInt("u_id"));
    		user.setuName(rs.getString("u_name"));
    		user.setPhone(rs.getString("phone"));
    		user.setAddr(rs.getString("addr"));
    		user.setHead(rs.getString("head"));
    		user.setMoney(rs.getFloat("money"));
    		user.setIsMerchants(rs.getBoolean("is_merchants"));
    		if(rs.getBoolean("is_merchants")) {
    			String sql2="select m.m_name,m.m_id from tb_user u join tb_merchant m on u.u_id=m.u_id where u.u_id="+rs.getInt("u_id");
    			System.out.println(sql2);
    			rs=con.getRs(sql2);
    			if(rs.next()) {
    				user.setmId(rs.getInt("m_id"));
    				user.setmName(rs.getString("m_name"));
    			}
    		}
    	}
    	return user;
    }
    
    public int updateUserHead(int uid,String filePath) {           //�����û�ͷ��
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	String sql="update tb_user set head=? where u_id=?";
    	params.put(1, filePath);
		params.put(2, uid);
    	System.out.println(sql);
    	int row=con.getUpdatePs(sql,params);
    	if(row>=0) {
    		row=1;
    	}
    	return row;
    }
    public int subUserMoney(int uid,float money) throws SQLException {           //�����û����
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	float usermoney=getUserMoney(uid);
    	if(usermoney>=0) {
    		float money2=usermoney-money;
    		String sql2="update tb_user set money=? where u_id=?";
    		params.put(1, money2);
    		params.put(2, uid);
        	System.out.println(sql2);
        	return con.getUpdatePs(sql2,params);
    	}
		return 0;
    }
    public int addMerchantMoney(int cid,int number) {
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	int res=0;
    	String sql1="select c.price,m.u_id from tb_commodity c join tb_merchant m on c.m_id=m.m_id where c_id=?";
    	System.out.println(sql1);
    	params.put(1, cid);
    	rs=con.getPs(sql1,params);
    	try {
			if(rs.next()) {
				res= subUserMoney(rs.getInt("u_id"),(-(rs.getFloat("price")*number)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return res;
    }
    public float getUserMoney(int uid) throws SQLException {           //��ȡ�û����
    	String sql1="select money from tb_user where u_id=?";
    	System.out.println(sql1);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, uid);
    	rs=con.getPs(sql1,params);
    	if(rs.next()) {
    		System.out.println(rs.getFloat("money"));
    		return rs.getFloat("money");
    	}
		return -1;
    }
    public int regMerchant(int u_id) {			//ע���̼�
    	String sql="update tb_user set is_merchants=? where u_id=?";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, 1);
    	params.put(2, u_id);
    	System.out.println(sql);
    	if(con.getUpdatePs(sql,params)>0) {
    		String sql2="insert into tb_merchant(m_name,u_id) values(?,?)";
    		HashMap<Integer,Object> params2=new HashMap<Integer,Object>();
    		params2.put(1, new String("xxx����"));
    		params2.put(2, u_id);
    		return con.getUpdatePs(sql2,params2);
    	}
    	return -1;
    }
    public int updateMName(int uId,String mName) throws SQLException {      //�޸ĵ�����
    	String sql1="select u_id from tb_merchant where m_name=?";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, mName);
    	System.out.println(sql1);
    	rs=con.getPs(sql1,params);
    	if(rs.next()) {
    		if(rs.getInt("u_id")!=uId)
    		return 0;
    	}
    	String sql="update tb_merchant set m_name=? where u_id=?";
    	HashMap<Integer,Object> params2=new HashMap<Integer,Object>();
    	params2.put(1, mName);
    	params2.put(2, uId);
    	System.out.println(sql);
    	return con.getUpdatePs(sql,params2);
    }
    public int updatePhone(int uId,String phone) throws SQLException {				//�޸��ֻ���
    	String sql1="select u_id from tb_user where phone=?";
    	System.out.println(sql1);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, phone);
    	rs=con.getPs(sql1,params);
    	if(rs.next()) {
    		if(rs.getInt("u_id")!=uId)
    		return 0;
    	}
    	String sql="update tb_user set phone=? where u_id=?";
    	System.out.println(sql);
    	System.out.println(sql1);
    	HashMap<Integer,Object> params2=new HashMap<Integer,Object>();
    	params2.put(1, phone);
    	params2.put(2, uId);
    	return con.getUpdatePs(sql,params2);
    }
    public int insertCType(String type) throws SQLException {				//���type
    	String sql1="select type_id from tb_ctype where type_name=?";
    	System.out.println(sql1);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, type);
    	rs=con.getPs(sql1,params);
    	if(rs.next()) {
    		return 1;
    	}
    	String sql="insert into tb_ctype(type_name) values(?)";
    	params.replace(1, type);
    	System.out.println(sql);
    	return con.getUpdatePs(sql,params);
    }
    public int insertCommodity(Commodity commodity) throws SQLException {				//�����Ʒ
    	String sql="insert into tb_commodity(m_id,c_name,c_type,number,price,c_pic,content,is_show,sales)  values(?,?,?,?,?,?,?,?,?)";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	System.out.println(sql);
    	params.put(1, commodity.getmId());
    	params.put(2, commodity.getcName());
    	params.put(3, commodity.getcType());
    	params.put(4, commodity.getNumber());
    	params.put(5, commodity.getPrice());
    	params.put(6, commodity.getcPic());
    	params.put(7, commodity.getContent());
    	params.put(8, 1);
    	params.put(9, 0);
    	return con.getUpdatePs(sql,params);
    }
    public int updateCommodity(Commodity commodity,String changedNum,String path) throws SQLException {				//�޸���Ʒ
    	String cPic=""; //���ݿ�����ƷͼƬ·��
    	String insertPic="";//��Ҫ�޸ĵ����ݿ��ͼƬ·��
    	String sql1="select c_pic from tb_commodity where c_id=?";
    	System.out.println(sql1);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, commodity.getcId());
    	rs=con.getPs(sql1,params);
    	if(rs.next()) {
    		cPic=rs.getString("c_pic");
    	}
    	String[] pic_array2=cPic.split("&");     
    	for(int i=1;i<=pic_array2.length;i++) {
    		if(changedNum.indexOf(i+"")!=-1) {  //����
    			//ɾ��ԭ��·���е�ͼƬ
    			Upload.deleteFile(path+pic_array2[i-1]);
    		}else {
    			insertPic+=pic_array2[i-1]+"&";
    		}
    	}
    	insertPic+=commodity.getcPic();
    	if(insertPic.lastIndexOf("&")==(insertPic.length()-1)) {
    		insertPic=insertPic.substring(0, insertPic.length()-1);
    	}
    	System.out.println("insertPic---"+insertPic);
    	String sql="update tb_commodity set c_name=?,c_type=?,number=?,price=?,c_pic=?,content=? where c_id=?";
    	params.replace(1, commodity.getcName());
    	params.put(2, commodity.getcType());
    	params.put(3, commodity.getNumber());
    	params.put(4, commodity.getPrice());
    	params.put(5, insertPic);
    	params.put(6, commodity.getContent());
    	params.put(7, commodity.getcId());
    	System.out.println(sql);
    	return con.getUpdatePs(sql,params);
    }
    public int pushOrDowmCom(int c_id,int num){             
    	String sql="update tb_commodity set is_show=? where c_id=?";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, num);
    	params.put(2, c_id);
    	System.out.println(sql);
    	return con.getUpdatePs(sql,params);
    }
    public int getToCart(int cId,int uId) throws SQLException{          //���빺�ﳵ      
    	String sql="select t_number,sty_id from tb_shopping_trolley  where u_id=? and c_id=?";
    	System.out.println(sql);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, uId);
    	params.put(2, cId);
    	String sql2=null;
    	rs=con.getPs(sql,params);
    	if(rs.next()) {
    		int num=rs.getInt("t_number");
    		int tid=rs.getInt("sty_id");
    		num++;
    		sql2="update tb_shopping_trolley set t_number=? where sty_id=?";
    		params.replace(1, num);
    		params.replace(2, tid);
    	}else {
    		Date date=new Date();
        	String time=date.toLocaleString();
        	sql2="insert into tb_shopping_trolley(u_id,c_id,date,t_number) values(?,?,?,?)";
        	params.replace(1, uId);
    		params.replace(2, cId);
    		params.put(3, time);
        	params.put(4, 1);
    	}
    	System.out.println(sql2);
    	return con.getUpdatePs(sql2,params);
    }
    public int deleteCartByCidUid(int cId,int uId) throws SQLException{          //ɾ�����ﳵ   cid��uid�Ѿ�Ψһ��ʶһ�����ﳵ����     
    	String sql="delete from tb_shopping_trolley where c_id=? and u_id=?"; 
    	System.out.println(sql);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, cId);
    	params.put(2, uId);
    	return con.getUpdatePs(sql,params);
    }
    public ArrayList<ShoppingTrolley> getCartByUid(int uId) throws SQLException{          //��ȡ���ﳵ     
    	ArrayList<ShoppingTrolley> list=new ArrayList<ShoppingTrolley>();
    	String sql="select s.t_number,s.sty_id,s.u_id,c.c_id,c.c_name,c.price,c.number,c.c_pic,c.is_show from tb_shopping_trolley s join tb_commodity c "
    			+ "on s.c_id=c.c_id where s.u_id=? order by s.sty_id desc";
    	System.out.println(sql);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, uId);
    	rs=con.getPs(sql,params);
    	while(rs.next()) {
    		ShoppingTrolley shoppingTrolley=new ShoppingTrolley();
    		shoppingTrolley.setStyId(rs.getInt("sty_id"));
    		shoppingTrolley.setcId(rs.getInt("c_id"));
    		shoppingTrolley.setuId(rs.getInt("u_id"));
    		shoppingTrolley.setcName(rs.getString("c_name"));
    		shoppingTrolley.setNumber(rs.getInt("number"));
    		shoppingTrolley.setcPic(rs.getString("c_pic"));
    		shoppingTrolley.setPrice(rs.getFloat("price"));
    		shoppingTrolley.setIsShow(rs.getBoolean("is_show"));
    		shoppingTrolley.setCartNumber(rs.getInt("t_number"));
    		list.add(shoppingTrolley);
    	}
    	return list;
    }
    public int insertIndent(int uId,int cId,int mId,int number,String addr,String phone){          //�½�����      state_numΪ״̬��־��
    	Date date=new Date();
        String time=date.toLocaleString();
        String sql="insert into tb_indent(u_id,c_id,m_id,number,date,state,addr,phone,state_num)"
        		+ " values(?,?,?,?,?,?,?,?,?)";
    	System.out.println(sql);
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, uId);
    	params.put(2, cId);
    	params.put(3, mId);
    	params.put(4, number);
    	params.put(5, time);
    	params.put(6, new String("������"));
    	params.put(7, addr);
    	params.put(8, phone);
    	params.put(9, 1);
    	return con.getUpdatePs(sql,params);
    }
    public ArrayList<Indent> getIndentByMidOrUid(int mId,int uId){          //��ѯ����  
    	
    	ArrayList<Indent> res=new ArrayList<Indent>();
    	 String sql=null;
    	 HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	if(mId!=-1) {
    			sql="select c.c_name,c.c_pic,i.indent_id,i.u_id,i.c_id,i.m_id,i.number,i.state,i.phone,i.addr,i.date,i.com_name,i.state_num"
    	        		+ " from tb_indent i join tb_commodity c on i.c_id=c.c_id where i.m_id=? order by state_num,date";
    			params.put(1, mId);
    	}else if(uId!=-1) {
    		sql="select c.c_name,c.c_pic,i.indent_id,i.u_id,i.c_id,i.m_id,i.number,i.state,i.phone,i.addr,i.date,i.com_name,i.state_num"
	        		+ " from tb_indent i join tb_commodity c on i.c_id=c.c_id where i.u_id=? order by i.indent_id";
    			params.put(1,uId);
    	}
    	System.out.println(sql);
    	rs=con.getPs(sql,params);
    	try {
			while(rs.next()) {
				Indent indent=new Indent();
				indent.setiId(rs.getInt("indent_id"));
				indent.setuId(rs.getInt("u_id"));
				indent.setcId(rs.getInt("c_id"));
				indent.setmId(rs.getInt("m_id"));
				indent.setNumber(rs.getInt("number"));
				indent.setState(rs.getString("state"));
				indent.setPhone(rs.getString("phone"));
				indent.setAddr(rs.getString("addr"));
				indent.setTime(rs.getString("date"));
				
				indent.setComName(rs.getString("com_name"));
				indent.setcName(rs.getString("c_name"));
				indent.setcPic(rs.getString("c_pic"));
				indent.setStateNum(rs.getInt("state_num"));
				res.add(indent);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return res;
    }
    public int subComsNumber(int cId,int number){          //�޸ģ����٣���Ʒ����  ,����������    
    	String sql1="select number,sales from tb_commodity where c_id=?";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, cId);
    	rs=con.getPs(sql1,params);
    	try {
			if(rs.next()) {
				int number2=rs.getInt("number")-number;
				int sales=rs.getInt("sales")+number;
				String sql2="update tb_commodity set number=?,sales=? where c_id=?";
				System.out.println(sql2);
				params.replace(1, number2);
				params.put(2, sales);
				params.put(3, cId);
				return con.getUpdatePs(sql2,params);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
    }
    public int updateIndent(int iId,String comName,String state,int stateNum){          //�޸Ķ��� ����id���˻���˾���ƣ�����״̬   
    	int res=0;
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	HashMap<Integer,Object> params2=new HashMap<Integer,Object>();
    	if(comName!=null) {
    		String sql="update tb_indent set com_name=? where indent_id=?";
    		System.out.println(sql);
    		params.put(1, comName);
    		params.put(2, iId);
        	con.getUpdatePs(sql,params);
        	res=1;
    	}
    	if(state!=null) {
    		String sql2="update tb_indent set state=?,state_num=? where indent_id=?";
    		System.out.println(sql2);
    		params2.put(1, state);
    		params2.put(2, stateNum);
    		params2.put(3, iId);
        	con.getUpdatePs(sql2,params2);
        	res=1;
    	}
    	return res;
    }
 
    public HashMap<String, Integer> getMidAndUidByCid(int cid){          //��ȡ�̼Ҷ���
    	HashMap<String,Integer> ids=new HashMap<String, Integer>();
    	String sql="select m.m_id,m.u_id from tb_commodity c join tb_merchant m on c.m_id=m.m_id  where c_id=?";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, cid);
    	System.out.println(sql);
    	rs=con.getPs(sql,params);
    	try {
			if(rs.next()) {
				ids.put("mId", rs.getInt("m_id"));
				ids.put("uId", rs.getInt("u_id"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return ids;
    }
    public int getuIdBymId(int mId) {
    	int uId=-1;
    	String sql="select u_id from tb_merchant  where m_id=?";
    	HashMap<Integer,Object> params=new HashMap<Integer,Object>();
    	params.put(1, mId);
    	rs=con.getPs(sql,params);
    	try {
			if(rs.next()) {
				uId=rs.getInt("u_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return uId;
    }
}