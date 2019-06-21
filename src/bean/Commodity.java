package bean;

public class Commodity {
private int cId;
private String cName;
private float price;
private int number;
private int mId; //商家id
private String cType;
private String cPic; //图片位置
private Boolean isShow;
private String mName;  //商家名
private String content;
private int sales;     //销量

public int getSales() {
	return sales;
}
public void setSales(int sales) {
	this.sales = sales;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public Boolean getIsShow() {
	return isShow;
}
public void setIsShow(Boolean isShow) {
	this.isShow = isShow;
}
public String getmName() {
	return mName;
}
public void setmName(String mName) {
	this.mName = mName;
}
public int getcId() {
	return cId;
}
public void setcId(int cId) {
	this.cId = cId;
}
public String getcName() {
	return cName;
}
public void setcName(String cName) {
	this.cName = cName;
}
public float getPrice() {
	return price;
}
public void setPrice(float price) {
	this.price = price;
}
public int getNumber() {
	return number;
}
public void setNumber(int number) {
	this.number = number;
}
public int getmId() {
	return mId;
}
public void setmId(int mId) {
	this.mId = mId;
}
public String getcType() {
	return cType;
}
public void setcType(String cType) {
	this.cType = cType;
}
public String getcPic() {
	return cPic;
}
public void setcPic(String cPic) {
	this.cPic = cPic;
}

}
