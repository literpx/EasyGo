package bean;

public class ShoppingTrolley {
	private int styId;
	private int cId;
	private int uId;
	private String cName;
	private String cPic; //Õº∆¨Œª÷√
	private float price;
	private int number;
	private int cartNumber;
	private Boolean isShow;
	
	public int getCartNumber() {
		return cartNumber;
	}
	public void setCartNumber(int cartNumber) {
		this.cartNumber = cartNumber;
	}
	public int getStyId() {
		return styId;
	}
	public void setStyId(int styId) {
		this.styId = styId;
	}
	public int getcId() {
		return cId;
	}
	public void setcId(int cId) {
		this.cId = cId;
	}
	public int getuId() {
		return uId;
	}
	public void setuId(int uId) {
		this.uId = uId;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public String getcPic() {
		return cPic;
	}
	public void setcPic(String cPic) {
		this.cPic = cPic;
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
	public Boolean getIsShow() {
		return isShow;
	}
	public void setIsShow(Boolean isShow) {
		this.isShow = isShow;
	}
	
}
