package bean;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
//这里对应的数据库集合名为Comment，如果不填，默认为小写Comment
//@Document(collection="Comment")
public class Comment {
   private String _id;
   private int cid;
   private int uid;
   private String uHead;
   private String uName;
   private String content;  //内容
   private HashSet<Integer> pick;    //点赞数
   private HashSet<Integer> unpick;  //踩数
   private ArrayList<Comment> childrenComment;
   private String time;
   
   public Comment() {
   }

 



public String get_id() {
	return _id;
}





public void set_id(String _id) {
	this._id = _id;
}





public String getuHead() {
	return uHead;
}



public void setuHead(String uHead) {
	this.uHead = uHead;
}



public String getuName() {
	return uName;
}



public void setuName(String uName) {
	this.uName = uName;
}


public int getCid() {
	return cid;
}



public void setCid(int cid) {
	this.cid = cid;
}



public int getUid() {
	return uid;
}



public void setUid(int uid) {
	this.uid = uid;
}



public String getTime() {
	return time;
}

public void setTime(String time) {
	this.time = time;
}
public String getContent() {
	return content;
}

public void setContent(String content) {
	this.content = content;
}


public HashSet<Integer> getPick() {
	return pick;
}



public void setPick(HashSet<Integer> pick) {
	this.pick = pick;
}



public HashSet<Integer> getUnpick() {
	return unpick;
}



public void setUnpick(HashSet<Integer> unpick) {
	this.unpick = unpick;
}






public ArrayList<Comment> getChildrenComment() {
	return childrenComment;
}





public void setChildrenComment(ArrayList<Comment> childrenComment) {
	this.childrenComment = childrenComment;
}





@Override
public String toString() {
	return "Comment [cid=" + cid + ", uid=" + uid + ", uHead=" + uHead + ", uName=" + uName + ", content=" + content
			+ ", pick=" + pick + ", unpick=" + unpick + ", childrenComment=" + childrenComment + ", time=" + time + "]";
}




}