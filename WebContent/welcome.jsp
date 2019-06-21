<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<link href="css/all.css" rel="stylesheet" type="text/css">
<link href="css/sign.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
<meta charset="UTF-8">
<style type="text/css">
.bdivaa{
	width:560px;
	height:600px;
	position:fixed;
	border:2px solid red;
	z-index:30;
	right:700px;
	top:95px;
	display: none
}
</style>
<title>EasyGo</title>
</head>
<body >
<div id="bg"  style="display:none;height:100%;width:100%;background-color:#ccc;opacity: 0.5;
position: fixed;z-index:12" data-navTab="${requestScope.navTab}" data-msg="${requestScope.msg }" data-uid="${sessionScope.user.uId}"></div>


<div class="updateUser" id="updateUser" style="display: none;">
      <div class="signclose">
          <img src="images/signclose.png" width="35px" height="35px" onclick="signclose1()" data-isUpdate="no" id="signclose1">
      </div>
      <div class="updateUseritem">
      	<div class="updateUserLeft">
      		
      		<c:if test="${sessionScope.user.head==null }">
      			<img id="headSrc" src="images/defaultHead.jpg" title="更改头像" 	onclick="document.getElementById('headfile').click();">
      		</c:if>
      		<c:if test="${sessionScope.user.head!=null }">
      			<img  id="headSrc" src="${sessionScope.user.head}" title="更改头像"  onclick="document.getElementById('headfile').click();">
      		</c:if>
      		
      		<form method="POST" enctype="multipart/form-data" id="formhead">
			<input type="file" name="headfile" id="headfile" onchange="readHead(this)" style="display: none"  accept = "image/*"/>
			<br><input type="button" value="更改头像" class="uploadHead" onclick="uploadPic();">
			</form>
      		
      	</div>
      	<div class="updateUserRight">
      		<div class="updateInput">手机:  &nbsp;&nbsp;
	      		<c:if test="${sessionScope.user.phone!=null }">
	      		<input id="phoneText" type="text" value=<c:out value="*******${fn:substring(sessionScope.user.phone, 7, 11)}" ></c:out>>
	      		</c:if>
	      		<c:if test="${sessionScope.user.phone==null }">
	      		<input id="phoneText"  type="text">
	      		</c:if>
	      	&nbsp;&nbsp;<button onclick="updatePhone()">更改</button>
      		</div>
      		<div class="updateInput">密码:&nbsp;&nbsp;
      			<input type="password" placeholder="修改密码" >
      		&nbsp;&nbsp;<button>更改</button>
      		</div>
      		<div class="updateInput">店铺:&nbsp;&nbsp;
      		<c:if test="${sessionScope.user.mName!=null }">
	      		<input id="mNameeText" type="text" value="${sessionScope.user.mName} ">
	      		</c:if>
	      		<c:if test="${sessionScope.user.mName==null }">
	      		<input id="mNameeText" type="text" value="xx店铺">
	      		</c:if>
      			&nbsp;&nbsp;<button onclick="updateMName()">更改</button>
      		</div>
      	</div>
      </div>
      <br>
 </div>

<div class="signform" id="signform" style="display: none">
      <div class="signclose">
          <img src="images/signclose.png" width="35px" height="35px" onclick="signclose()">
      </div>
      <div class="userdiv">
      <input id="user" class="signinput" type="text" placeholder="用户名" name="user" onkeyup="loading(this)">
       <p class="star"></p>
      </div>
      <div class="pwddiv">
      <input id="pwd" class="signinput" type="password" placeholder="密码" name="pwd" onkeyup="loading(this)">
       <p class="star"></p>
      </div>
      <div class="postdiv">
      <button  onclick="loginRequest()">登录</button>
      </div>
      <br>
      <div class="change" style="color: #4d4d4d">
         <p>还没有账号?赶快<a href="#" style="text-decoration: none;color: #43A047" id="gotoReg">注册</a>一个吧</p>
     </div>
 </div>
 <div class="signform" id="registerform" style="display: none">
         <div class="signclose">
             <img src="images/signclose.png" width="35px" height="35px" onclick="signclose()">
         </div>
         <div class="userdiv">
             <input  id="registeruser" class="signinput" type="text" placeholder="用户名"  name="user" onkeyup="checkUserName(this)" autocomplete="off">
             <p class="star"></p>
         </div>
         <!-- 提示信息 -->
  
         <div class="pwddiv">
             <input  id="registerpwd" class="signinput" type="password" placeholder="密码" name="pwd" onkeyup="checkPwd1(this)">
             <p class="star"></p>
         </div>
         <div class="pwddiv">
             <input  id="registerrepwd" class="signinput" type="password" placeholder="再次输入密码" name="pwd" onkeyup="checkPwd2(this)">
             <p class="star"></p>
         </div>
         <div class="codediv">
             <input  id="registercode" class="signinputCode" onkeyup="loading(this)" type="text" placeholder="验证码" name="code">
             <img border=0 src="views/code.jsp" width=60 height=35 onclick="refreshCode(this)" style="margin-left:5px;" id="imgCode2">
             <p class="star"></p>
         </div>
         <div class="postdiv">
             <button onclick="regetRequest()">注册</button>
         </div>
         <br>
         <div class="change" style="color: #4d4d4d">
             <p>已有账号?立刻去<a href="#" style="text-decoration: none;color: #43A047" id="gotoLogin">登录</a>吧</p>
         </div>
 </div>

	<div class="index-head">
		<div class="head-username">
		
			<c:if test="${sessionScope.user==null }">
				<img src="images/2.jpg"/><p>你好，请先&nbsp;&nbsp;<a href="javascript:login()" style="text-decoration:none;">登录</a></p>
			</c:if>
			<c:if test="${sessionScope.user!=null }">
				<c:if test="${sessionScope.user.head!=null }">
					<img src="${sessionScope.user.head}"/>
				</c:if>
				<c:if test="${sessionScope.user.head==null }">
					<img src="images/defaultHead.jpg"/>
				</c:if>
				<p>你好，${sessionScope.user.uName }&nbsp;&nbsp;<a href="views/logOut.jsp" style="text-decoration:none;">注销</a></p>
			</c:if>
			
		</div>
		<div class="search-item" id="searchdiv">
		<div><input id="search" placeholder="名称/类型/商铺"></div>
		<input type="image" src="images/search.png"  class="search-btn" onclick="reqSearch()"/>
		</div>	
	</div>
	<div class="left-nav">
		<img alt="" src="images/logo.jpg">
		<ul class="nav-list">
			<li onclick="getIndex()" id="navIndex">首页</li>
			<li onclick="">分类</li>
			<li onclick="">发现</li>
			<li onclick="getMe()" id="navMe">我的</li>
		</ul>
		<c:if test="${sessionScope.user!=null}">
			<c:if test="${sessionScope.user.isMerchants }">
			<button class="reg-merchants" onclick="getMyCommodity()" id="getMyCommodity">我的商品</button>
		</c:if>
		<c:if test="${!sessionScope.user.isMerchants }">
			<button class="reg-merchants" onclick="regMerchant()">注册商家</button>
		</c:if>
		</c:if>
	</div>
	
	<!--------------------------------------------------------------中间部分important--------------------------------------------->
	<div class="center" id="center">
		
	</div>
	<!---------------------------------------------------------------中间部分important-------------------------------------------->
	
	<div class="right-nav-shopping-car" id="shopping-car">
		<p id="shopping-car-number" data-num="${fn:length(sessionScope.userCart)}" style="display: none">${fn:length(sessionScope.userCart)}</p>
		<img src="images/cart.png" title="购物车">
	</div>
	<div class="right-nav-shopping-message">
	<img src="images/message.png" title="消息">
	</div>
	<div class="go-top">
	<a href="#searchdiv"><img alt="置顶" src="images/go_top.png" title="置顶"></a>
	</div>
	<div class="right-content">
		<div class="right-content-in">
			<div id="cart-scroll">
			<c:forEach items="${sessionScope.userCart }" var="item">
				<div class="userCart-item">
					<div class="choose-div">
						<label for="${item }" class="choose_label choose_check">
						<input type="checkbox" class="choose_input" id="${item }" name="choose"></label>
					</div>
					<div class="userCart-item-img"><img src="${(fn:split(item.cPic, '&'))[0] }" ></div>
					<div class="userCart-item-info">
						<p><font  color="red">￥</font><font color="red" class="Commoney">${item.price }</font></p>
						<p>${item.cName }&nbsp;(剩${item.number }件)</p>
						<button class="subBtn" onclick="subAction(this)">-</button>
						<input type="text" value="${item.cartNumber}" class="numberInput" 
						disabled="disabled" data-cid="${ item.cId}" data-cname="${item.cName }">
						<button class="addBtn" onclick="addAction(this)" data-max="${item.number }">+</button>
					</div>
				</div>
			</c:forEach>
			</div>
			<div id="settlement">
				<div class="settlement-left">
				<label  for="checkAllBox"  class="choose_label choose_check" style="margin-left: 0px;">
				<input type="checkbox" id="checkAllBox" onclick="CheckAll(this)"  class="choose_input"></label>全选
				</div>
				<div class="settlement-right">
					<p style="font-size: 18px;">合计:<font  color="red">￥</font><font color="red" id="sumSettlement">0</font></p>
					<button class="settlement-btn" onclick="payMoney(this)" 
					data-uid="${sessionScope.user.uId }" data-money="${sessionScope.user.money }">结算</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
/****************************************socket内容*****************************************************/
 //var wswebsocketUrl = data.webSocketUrl;
 var uid=$("#bg").data("uid")
 var websocket = null;
 //判断当前浏览器是否支持WebSocket
 if ('WebSocket' in window) {
 	//console.log(wswebsocketUrl);
     websocket = new WebSocket("ws://127.0.0.1:8088/EasyGo/ws");
 }
 else {
     alert('当前浏览器 Not support websocket')
 }  

 //连接发生错误的回调方法
 websocket.onerror = function () {
     setMessageInnerHTML("WebSocket连接发生错误");
 };

 //连接成功建立的回调方法
 websocket.onopen = function () {
     setMessageInnerHTML("WebSocket连接成功");
 }

 //接收到消息的回调方法
 websocket.onmessage = function (event) {
 	var msg = event.data;
 	//业务处理逻辑
 	if(msg=="绑定成功"){
 		window.clearInterval(timer);
 	}else{
 		alert(msg)
 	}
    //
 }

 //连接关闭的回调方法
 websocket.onclose = function () {
     setMessageInnerHTML("WebSocket连接关闭");
     window.clearInterval(timer);
 }

 //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
 window.onbeforeunload = function () {
     closeWebSocket();
 }

 //将消息显示在网页上
 function setMessageInnerHTML(innerHTML) {
    console.log(innerHTML);
 }

 //关闭WebSocket连接
 function closeWebSocket() {
     websocket.close();
 }

 //发送消息
 function send() {
 	//var sid = $.cookie('sid'); //后台将httpOnly设置为false
     websocket.send("uid"+uid);
 }
 var timer = setInterval(send, 1000);
/****************************************socket内容*****************************************************/
function reqSearch(){
	var content=$("#search").val()
		$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"reqSearch","conetent":content
			},
			dataType:"text",
			async:true,
			success:function(data){
				$.get("views/index.jsp",{"reqSearch":"yes"},function(data){
					$("#center").html(data)
				});
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
}
$(function (){        //登录与注册切换
	$("#navIndex").click()
	//$("#getMyCommodity").click()
	//初始化右边购物车高度
		var winHeight=window.screen.height 
		$(".right-content").css({"height":winHeight-50+"px"})
		$(".right-content-in").css({"height":(winHeight-70)+"px"})
		$('.change a').click(function ()
		  {
		     $('.signform').animate({height: 'toggle', opacity: 'toggle'}, 'slow');
		});
	
		var navTab=$("#bg").data("navTab")
		if(navTab!=null&&navTab!=""){
			
		}
		var msg=$("#bg").data("msg")
		if(msg!=null&&msg!=""){
			alert(msg)
		}
		
}) 
/****************************************购物车逻辑*****************************************************/
function payMoney(that){   //结算功能
	var uid=$(that).data("uid")
	var sumMoney=$("#sumSettlement").html();
	if(uid!=""&&sumMoney!=0){
		var userMoney=$(that).data("money")
		
		if(parseFloat(userMoney)>=parseFloat(sumMoney)){
			//遍历勾选的商品
			var checkeds=$("#cart-scroll .choose-div input:checked")
			var cIds="";
			var cNumbers="";
			var cPics="";
			var cNames="";
			var cPrices=""
			for(var i=0;i<checkeds.length;i++){
				let divInfo=checkeds.eq(i).parents(".choose-div").nextAll(".userCart-item-info")
				
				cIds+=divInfo.find("input[type=text]").data("cid")+"&"
				cNames+=divInfo.find("input[type=text]").data("cname")+"&"
				cNumbers+=divInfo.find("input[type=text]").val()+"&"
				cPics+=divInfo.prev(".userCart-item-img").find("img").attr("src")+"&"
				cPrices+=divInfo.find("p .Commoney").html()+"&"
			}
			cIds=cIds.substring(0,cIds.length-1)
			cNumbers=cNumbers.substring(0,cNumbers.length-1)
			cPics=cPics.substring(0,cPics.length-1)
			cNames=cNames.substring(0,cNames.length-1)
			cPrices=cPrices.substring(0,cPrices.length-1)
			$.get("views/getPay.jsp",
					{"sumMoney":sumMoney,"cIds":cIds,"cNumbers":cNumbers,"cPics":cPics,"cNames":cNames,"cPrices":cPrices},
					function(data){
				$("body").append(data)
				$("#bg").css({
		            display: "block", height: $(document).height(),
		           });
			});
		}else{
			alert("余额不足！")
		}
	}else{
		//alert("666")
	}
}
$("#cart-scroll .choose-div input").click(function(){
			if($(this).is(":checked")){          	//勾选
				$(this).parent().removeClass("choose_check").addClass("choose_checked");
				var	sum=$("#sumSettlement").html()
				let divInfo=$(this).parents(".choose-div").nextAll(".userCart-item-info")
				let moneyitem=divInfo.find("p .Commoney").html()*divInfo.find("input[type=text]").val()
				sum=(parseFloat(moneyitem)+parseFloat(sum)).toFixed(2)
				$("#sumSettlement").html(sum)
			}else{                              	//取选
				$(this).parent().removeClass("choose_checked").addClass("choose_check");
				$("#settlement input")[0].checked=false;
				var	sum=$("#sumSettlement").html()
				let divInfo=$(this).parents(".choose-div").nextAll(".userCart-item-info")
				let moneyitem=divInfo.find("p .Commoney").html()*divInfo.find("input[type=text]").val()
				sum=(parseFloat(sum)-parseFloat(moneyitem)).toFixed(2)
				$("#sumSettlement").html(sum)
			}
		})
function subAction(that){
	var number=$(that).next("input[type=text]").val()
	if(number>1){
		number--
		$(that).next("input[type=text]").val(number)
		
		var chooseInfo=$(that).parents(".userCart-item-info").prevAll(".choose-div").find("label input[type=checkbox]")
		if(chooseInfo.is(":checked")){
			//修改总价
			var	sum=$("#sumSettlement").html()
			let moneyitem=$(that).parents(".userCart-item-info").find("p .Commoney").html()
			sum=(parseFloat(sum)-parseFloat(moneyitem)).toFixed(2)
			$("#sumSettlement").html(sum)
		}  			
	}
	//alert(number)
}
function addAction(that){
	var number=$(that).prev("input[type=text]").val()
	var maxnumber=$(that).data("max")
	if(number<maxnumber){
		number++
		$(that).prev("input[type=text]").val(number)
		
		var chooseInfo=$(that).parents(".userCart-item-info").prevAll(".choose-div").find("label input[type=checkbox]")
		if(chooseInfo.is(":checked")){
			//修改总价
			var	sum=$("#sumSettlement").html()
			let moneyitem=$(that).parents(".userCart-item-info").find("p .Commoney").html()
			sum=(parseFloat(sum)+parseFloat(moneyitem)).toFixed(2)
			$("#sumSettlement").html(sum)
		}  
	}
	//alert(number)
}
function CheckAll(that){
	//alert($(that)[0].checked)
	if(!$(that)[0].checked){      //取选全选
		$(that).parent(".choose_label").removeClass("choose_checked").addClass("choose_check");
		var selAll=$("#cart-scroll .choose-div input");
		for(var i=0;i<selAll.length;i++){
			selAll[i].checked=false;
			$(selAll[i]).parent(".choose_label").removeClass("choose_checked").addClass("choose_check");
		}
		$("#sumSettlement").html(0)
	}else{						//全选
		$(that).parent(".choose_label").removeClass("choose_check").addClass("choose_checked");
		var selAll=$("#cart-scroll div input");
		for(var i=0;i<selAll.length;i++){
			selAll[i].checked=true;
			$(selAll[i]).parent(".choose_label").removeClass("choose_check").addClass("choose_checked");
		}
		
		var itemAll=$(".userCart-item-info")
		var sum=parseFloat(0.00)
		for(var i=0;i<itemAll.length;i++){
			let moneyitem=itemAll.eq(i).find("p .Commoney").html()*itemAll.eq(i).find("input[type=text]").val()
			sum+=parseFloat(moneyitem)
		}
		$("#sumSettlement").html(sum)
	}
}
function payRequset(){           //支付请求Servlet data-cids="${param.cIds }" data-cnums="${param.cNumbers }" data-summoney="${ param.sumMoney }
	var cIds=$("#payIndent").data("cids")
	var cNums=$("#payIndent").data("cnums")
	var sumMoney=$("#payIndent").data("summoney")
	var uid=$("#payIndent").data("uid")
	var addr=$("#payIndent").find(".addr-div input[type=text]").val()
	var phone=$("#payIndent").find(".phone-div input[type=text]").val()
	$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"payRequset",
				"cIds":cIds,"cNums":cNums,"sumMoney":sumMoney,
				"uid":uid,"addr":addr,"phone":phone
			},
			dataType:"json",
			async:true,
			success:function(data){
				var uids=data.uids
				 for ( var i = 0; i <uids.length; i++){ 
					 websocket.send("发送到"+uids[i]+"&&&您收新的订单，请及时处理！")
					}
				alert(data.state)
				location.reload()
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
	
}
/****************************************购物车逻辑************************************/
function changeAnimation(that){
	var id=$(that).data("id")
	var str="animation"+id
	if(id==1){
		$("#showpic-big-ul").removeClass("animation1").removeClass("animation2").removeClass("animation3").animate({left:"-0%"},500,function(){
			$("#showpic-big-ul").addClass("animation1")
		});
	}
	if(id==2){
		$("#showpic-big-ul").removeClass("animation1").removeClass("animation2").removeClass("animation3").animate({left:"-100%"},500,function(){
			$("#showpic-big-ul").addClass("animation2")
		});
	}
	if(id==3){
		$("#showpic-big-ul").removeClass("animation1").removeClass("animation2").removeClass("animation3").animate({left:"-200%"},500,function(){
			$("#showpic-big-ul").addClass("animation3")
		});
	}
	
	
//alert($(that).parent("#showpic-big-ul"))
}

/****************************商品详细页面***************************************/

function getToCart(that){
	var cmid=$(that).data("cmid")     //商品的商家id
	var mid=$(that).data("mid")     //登录的商家id
	if(cmid!=mid){
			var cid=$(that).data("cid")     //商品id
			var uid=$(that).data("uid")     //用户id
			$.ajax({
				url:"Search",
				type:"post",
				data:{
					"reqtype":"getToCart",
					"cId":cid,
					"uId":uid
				},
				dataType:"text",
				async:true,
				success:function(data){
					if(data.replace(/^\s+|\s+$/g,"")=="成功"){
						var btop=$("#shopping-car").css("top")
						var bright=$("#shopping-car").css("right")
						var bwidth=$("#shopping-car").css("width")
						var bheight=$("#shopping-car").css("height")
						var bdiv=document.createElement("div")
						$(bdiv).addClass("bdivaa")
						$("body").append(bdiv)
						$(".bdivaa").css({"display":"block"}).animate({'right':bright,"top":btop,"width":bwidth,"height":bheight},1000,function(){
							$(".bdivaa").remove()
						})
						
						var num=$("#shopping-car-number").html()      //修改购物车数量
						$("#shopping-car-number").html(parseInt(num)+1)
					}else{
						alert(data)
					}
				},
				error:function(jqXHR,textStatus,errorThrown){
					console.log(jqXHR+","+textStatus+","+errorThrown)
				}
			})
			
		}else{
			alert("您是商品的商家")
		}
	
	
}
/**************************商品上传*******************************/
function pushGoods(){
	$.get("views/editComs.jsp",function(data){
		$("#pushGoods").replaceWith(data)
		$("#pushGoods").css("display","")
		$("#bg").css({
            display: "block", height: $(document).height(),
           });
	});
}
function getMyGoods(){			//获取商铺发布的商品
	$.get("navTab",{ nav: "MyCommodity" },function(data){
		$.get("views/foreachMyGoods.jsp",function(data){
			$("#center").find(".shop-content").html(data)
		});
	})
}
function getIndent(){     //获取商铺订单
		$.get("views/merchantIdent.jsp",function(data){
			$("#center").find(".shop-content").html(data)
		});
}
function startFaHuo(that){         //开始发货
	var iId=$(that).data("iid")
	var cId=$(that).data("cid")
	var number=$(that).data("number")
	var companyName=$(that).prev(".my-ident-item-state").find("p select").val()
	$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"startFaHuo",
				"cId":cId,"number":number,"iId":iId,
				"companyName":companyName
			},
			dataType:"json",
			async:true,
			success:function(data){
				if(data.state=="发货成功"){
					alert("发货成功！")
					$(that).prev(".my-ident-item-state").find("p").eq(0).html("送货中")
					$(that).prev(".my-ident-item-state").find("p").eq(1).html("快递公司&nbsp;"+data.msg)
					$(that).replaceWith("<a href='#' class='my-ident-item-more'>查看详情</a>")
				}else{
					alert(data.state)
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
}
function signclose2(){
	 $("#bg").css({
         display: "none", height: $(document).height(),
        });
	  document.getElementById('pushGoods').style.display="none"
		 
	 // if($("#signclose1").data("isUpdate")=="yes"){
	//		location.reload()  
	 // }
}
function signclose3(that){
	 $("#bg").css({
        display: "none", height: $(document).height(),
       });
		 $(that).parents("#payIndent").remove()
}
function readpic(that){
	 var reader = new FileReader();  //创建文件读取对象
     var file = that.files[0]; //获取file组件中的文件
     reader.readAsDataURL (file);  //文件读取装换为base64类型
     reader.onload = function (result) {
         //reader对象的result属性存储流读取的数据
         $($(".push-img .pushImg")[$(that).data("img")]).attr("src", this.result);
        // $($(".push-img img")[$(that).data("img")]).attr("onclick", "document.getElementById('picfile1').click();");
        $($(".push-img .pushImg")[$(that).data("img")]).attr("onclick", "");
         
         console.log(this.result) // 打印出转换后的base64
     }
}
function deleteTheImg(that){
	var picfile=$(that).data("picfile")
	var pId="document.getElementById('"+picfile+"').click()"
	picfile="#"+picfile;
	$(that).next("img").attr("src","images/addpic.png");
	$(that).next("img").attr("onclick", pId);
	$(picfile).val(""); 
	$(that).css("display","none")
	$(that).data("changed","1")
	$(that).hide();
}
function goToTheCom(that){          //**************************前往商品详细页面
	var cid=$(that).data("cid")
	$.get("navTab",{"cId":cid,"nav":"reqComment"},function(data){
		$.get("views/getOneCommodity.jsp",{cid:cid},function(data){
			$("#center").html(data)
		});
	});
		
}
function pushSubmit(){
	var form = document.getElementById('formPushGoods')
	var formData = new FormData(form); 
		$.ajax({ 
			   url:"GoodsUpload", 
			   type:"post", 
			   data:formData, 
			   processData:false,
	           contentType:false,
	           async:true,
			   success:function(data){ 
			    alert(data)
			   },
			   error:function(err){ 
				    //alert("网络连接失败,稍后重试",err.responseText); 
				      alert("发布成功!")
				      $("#navMe").click()
				} 
		}) 
}
function updateSubmit(that){
	//检查哪些图片背修改 
	var num="";
	if($(".deletePic").eq(0).data("changed")!=""&&$(".deletePic").eq(0).data("changed")!=null){
		num+=1+""
	}
	if($(".deletePic").eq(1).data("changed")!=""&&$(".deletePic").eq(1).data("changed")!=null){
		num+=2+""
	}
	if($(".deletePic").eq(2).data("changed")!=""&&$(".deletePic").eq(2).data("changed")!=null){
		num+=3+""
	}
	var cid=$(that).data("cid")
	var form = document.getElementById('formPushGoods')
	var formData = new FormData(form); 
	formData.append("cid",cid);
	formData.append("num",num);
	$.ajax({ 
		   	url:"GoodsUpload", 
		   	type:"post", 
		   	data:formData, 
		   	processData:false,
        	contentType:false,
        	async:true,
		  	success:function(data){ 
		    	alert(data)
		     //$("#getMyCommodity").click()
		   	},
		   	error:function(err){ 
			    //alert("网络连接失败,稍后重试",err.responseText); 
			      alert("修改成功！！！")
			      $("#getMyCommodity").click()
			} 
	}) 
}
function pushDownCom(that){
	var cId=$(that).data("cid")
	if(window.confirm('你确定要下架商品吗？')){
       //alert("确定");
		$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"pushDownCom",
				"cId":cId
			},
			dataType:"text",
			async:true,
			success:function(data){
				if(data.replace(/^\s+|\s+$/g,"")=="已下架"){
					alert("已下架！")
					$(that).attr("onclick","pushCom(this);");
					$(that).html("上架")
					$(that).css("background-color","#b45654")
					$(that).parents(".shop-commodity-item").css("background-color","#e6d6e6")
					//alert($(that).parents(".shop-commodity-item").html())
					//location.reload()
					//$("#gotoLogin").click()
				}else{
					alert(data)
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
       
     }else{
       // alert("取消");
      //  return false;
    }

}
function pushCom(that){
	var cId=$(that).data("cid")
	if(window.confirm('你需要上架商品吗？')){
	       //alert("确定");
			$.ajax({
				url:"Search",
				type:"post",
				data:{
					"reqtype":"pushCom",
					"cId":cId
				},
				dataType:"text",
				async:true,
				success:function(data){
					if(data.replace(/^\s+|\s+$/g,"")=="已上架"){
						alert("已上架！")
						$(that).attr("onclick","pushDownCom(this);");
						$(that).html("下架")
						$(that).css("background-color","#4CAF50")
						$(that).parents(".shop-commodity-item").css("background-color","#fff")
						//location.reload()
						//$("#gotoLogin").click()
					}else{
						alert(data)
					}
				},
				error:function(jqXHR,textStatus,errorThrown){
					console.log(jqXHR+","+textStatus+","+errorThrown)
				}
			})
	       
	     }
}
/*********************用户信息修改**********/
function readHead(that){
    for(var i=0;i<that.files.length;i++){
        let reader = new FileReader();  //创建文件读取对象
        var file1 = that.files[i]; //获取file组件中的文件
        reader.readAsDataURL (file1);  //文件读取装换为base64类型
        reader.onload = function (result) {
            //reader对象的result属性存储流读取的数据
            $("#headSrc").attr("src", this.result);
            console.log(this.result) // 打印出转换后的base64
        }
    }
}
function uploadPic(){
	var form = document.getElementById('formhead')
	var formData = new FormData(form); 
	if($("#headfile")[0].files.length>0) {
		$.ajax({ 
			   url:"FileUpload", 
			   type:"post", 
			   data:formData, 
			   processData:false,
	           contentType:false,
			   success:function(data){ 
			    if(data.replace(/^\s+|\s+$/g,"")=="上传失败"){ 
			     alert("上传失败！"); 
			    }else if(data.replace(/^\s+|\s+$/g,"")=="上传成功"){
			    	alert("上传成功！"); 
			    	location.reload()
			    	
			    } 
			    
			   }, 
			   error:function(err){ 
			    alert("网络连接失败,稍后重试",err.responseText); 
			   } 
			  
		}) 
	}
	
}
function updateMName() {
	var mName=$("#mNameeText").val()
	if(mName==""){
		alert("店铺名不能为空值！")
	}
	$.ajax({ 
		   url:"Search", 
		   type:"post", 
		   data:{
			   "reqtype":"updateMName",
			   "mName":mName
		   }, 
		   success:function(data){
			   if(data.replace(/^\s+|\s+$/g,"")=="修改成功")
			   $("#signclose1").data("isUpdate","yes")
		 	 alert(data)
		   }, 
		   error:function(err){ 
		    alert("网络连接失败,稍后重试",err); 
		   } 
		  
	}) 
}
function updatePhone() {
	var phone=$("#phoneText").val()
	if(phone==""){
		alert("手机号不能为空！")
	}
	$.ajax({ 
		   url:"Search", 
		   type:"post", 
		   data:{
			   "reqtype":"updatePhone",
			   "phone":phone
		   }, 
		   success:function(data){ 
			   if(data.replace(/^\s+|\s+$/g,"")=="修改成功")
				   $("#signclose1").data("isUpdate","yes")
			   alert(data)
		   }, 
		   error:function(err){ 
		    alert("网络连接失败,稍后重试"+err); 
		   } 
		  
	}) 
}
/**********登录处理*************/

function checkPwd1(that){	//检查密码长度
	
	if($(that).val().length<6){
		$(that).next(".star").html("密码长度不能小于6")
	}else if($(that).val()!=$("#registerrepwd").val()&&$("#registerrepwd").val()!=""){
		$(that).next(".star").html("两次密码不一致！")
	}else{
		$(that).next(".star").html("")
		$("#registerrepwd").next(".star").html("")
	}
	
}
function checkPwd2(that){	//检查两次密码一致
	if($(that).val().length<6){
		$(that).next(".star").html("密码长度不能小于6")
	}else if($(that).val()!=$("#registerpwd").val()&&$("#registerpwd").val()!=""){
		$(that).next(".star").html("两次密码不一致！")
	}else{
		$(that).next(".star").html("")
		$("#registerpwd").next(".star").html("")
	}
}
function checkUserName(that){      //异步检测用户名
	//1、获得输入框的输入的内容
	var username = $(that).val();
	//2、根据输入框的内容去数据库中模糊查询---List<Product>
	var content = "";
	//console.log("${pageContext.request.contextPath}/Search")
	$.ajax({
			url:"Search",
			type:"post",
			data:{"reqtype":"checkUserName",
				"username":username},
			dataType:"text",
			async:true,
			success:function(data){
				//3、将返回的商品的名称 现在showDiv中
				if(data.length>0){
					$(that).next(".star").html(data)
				}
				if(obj.value.length==0){//判断输入框是否为空，如果为空则隐藏提示区域
					$(that).next(".star").html("")
				}		
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
}

function updateUser(){       //更改用户信息
	
	document.getElementById('updateUser').style.display=""
		$("#bg").css({
            display: "block", height: $(document).height(),
           });
}
function signclose1(){
	 $("#bg").css({
         display: "none", height: $(document).height(),
        });
	  document.getElementById('updateUser').style.display="none"
		 
	  if($("#signclose1").data("isUpdate")=="yes"){
			location.reload()  
	  }
			   

}


function login(){
	document.getElementById('signform').style.display=""
		$("#bg").css({
            display: "block", height: $(document).height(),
           });
}


function signclose() {                                  //关闭
	   document.getElementById('signform').style.display="none"
	   document.getElementById('registerform').style.display="none"
		   $("#bg").css({
	            display: "none", height: $(document).height(),
	           });
	   $(".star").each(function(index){
		   $(this).html("")
		}); 
	   $(".signform").each(function(index){
		  $(this).find("input").each(function(i){
			  $(this).val("")
		  })
		}); 
}
function refreshCode(e){
	e.src = "views/code.jsp?id="+new Date();	
}

function loading(that){
	$(that).nextAll(".star").html("")
}

function regetRequest(){
	
	var num=0;
	var username=$("#registeruser").val()
	if(username==""){
		$("#registeruser").next(".star").html("用户名不能为空！")
		num=1;
	}
	var password=$("#registerpwd").val()
	if(password==""){
		$("#registerpwd").next(".star").html("密码不能为空！")
		num=1;
	}
	if($("#registerrepwd").val()==""){
		$("#registerrepwd").next(".star").html("密码不能为空！")
		num=1;
	}
	var regCode=$("#registercode").val()
	if(regCode==""){
		$("#registercode").nextAll(".star").html("验证码不能为空！")
		num=1;
	}
	$("#registerform .star").each(function(index){
		if($(this).html().replace(/^\s+|\s+$/g,"")!=""){
			num=1;
		}
	});
	if(num==0){          //开始注册
		$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"reg",
				"username":username,
				"password":password,
				"regCode":regCode
			},
			dataType:"text",
			async:true,
			success:function(data){
				if(data.replace(/^\s+|\s+$/g,"")=="注册成功"){
					alert("注册成功")
					//location.reload()
					$("#gotoLogin").click()
				}else if(data.replace(/^\s+|\s+$/g,"")=="验证码错误"){
					$("#registercode").nextAll(".star").html(data)
					$("#imgCode2").click()
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
	}
}
function loginRequest(){
	var num=0
	var username=$("#user").val()
	if(username==""){
		$("#user").next(".star").html("用户名不能为空！")
		num=1
	}
	var password=$("#pwd").val()
	if(password==""){
		$("#pwd").next(".star").html("密码不能为空！")
		num=1
	}
	if(num==0){
		$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"login",
				"username":username,
				"password":password
			},
			dataType:"text",
			async:true,
			success:function(data){
				if(data.replace(/^\s+|\s+$/g,"")=="登录成功"){
					alert("登录成功")
					location.reload()
				}else if(data.replace(/^\s+|\s+$/g,"")=="登录失败"){
					$("#user").next(".star").html("用户名不存在或者密码错误")
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
	}
}

/***********登录处理结束*************/
function getIndex(){
	$.get("navTab",{ nav: "index" },function(data){
		$.get("views/index.jsp",function(data){
			//$("#center")[0].replaceChild(data,$("#center-mes")[0])
			//alert(data)
			$("#center").html(data)
		});
	});
	
	
	//var div=document.createElement("div")
	//var objJquery = $(div);
}
function getMe(){                          //获取用户信息页面
	$.get("navTab",{ nav: "getMe" },function(data){
		$.get("views/getMe.jsp",function(data){
			$("#center").html(data)
			$("#state0").click()
		});
	});
}
function getAllIdent(){
	$.get("views/userIndent.jsp",function(data){
		$("#center").find(".my-indent #my-indent-content").html(data)
	});
}
function getNoSendIdent(){
	$.get("views/userIndent.jsp",{"state":"1"},function(data){
		$("#center").find(".my-indent #my-indent-content").html(data)
	});
}
function getSendIdent(){
	$.get("views/userIndent.jsp",{"state":"2"},function(data){
		$("#center").find(".my-indent #my-indent-content").html(data)
	});
}
function getCommentIdent(){
	$.get("views/userIndent.jsp",{"state":"3"},function(data){
		$("#center").find(".my-indent #my-indent-content").html(data)
	});
}
function getCompleteIdent(){
	$.get("views/userIndent.jsp",{"state":"4"},function(data){
		$("#center").find(".my-indent #my-indent-content").html(data)
	});
}
function getMyCommodity(){
		$.get("views/getMyCommodity.jsp",function(data){
			$("#center").html(data)
			$("#getMyGoods").click()
		});
		$.get("views/editComs.jsp",function(data){
			$("#center").before(data)
		});
}

function reqConfirm(that){       //确认收货
	var iId=$(that).data("iid")
	var cId=$(that).data("cid")
	var number=$(that).data("number")
	$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"reqConfirm",
				"cId":cId,"number":number,"iId":iId
			},
			dataType:"json",
			async:true,
			success:function(data){
				if(data.state=="收货成功"){
					if(window.confirm('收货成功!是否立即去评价？')){
						$("#state3").click()					}
				}else{
					alert(data.state)
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
}
function reqComment(that){          //商品评价
	//alert("评价66666666")
	var iId=$(that).data("iid")
	var cId=$(that).data("cid")
	if($(that).parents(".my-ident-item").next(".comment").html()==""||$(that).parents(".my-ident-item").next(".comment").html()==null){
		$(that).parents(".my-ident-all").append("<div class='comment'>"+
				"<div contenteditable='true' class='demoEdit'></div>"+ 
				"<button class='comment-btn' onclick='sendComment(this)' data-cid='"+cId+
				"' data-iid='"+iId+"'>"+
				"发表评论</button></div>")
	}else{
		$(that).parents(".my-ident-item").next(".comment").remove()
	}
	
}
function sendComment(that){                //发送评论 
		var content=$(that).prev("div[class=demoEdit]").html()
		var cId=$(that).data("cid")
		var iId=$(that).data("iid")
		//alert(content+","+cId+","+iId)
		$.ajax({
		url:"Search",
		type:"post",
		data:{
			"reqtype":"createComment",
			"content":content,
			"cId":cId,"iId":iId
		},
		dataType:"json",
		async:true,
		success:function(data){
			alert(data.state)
			if(data.state=="评论成功"){
				$("#state4").click()					
			}
		},
		error:function(jqXHR,textStatus,errorThrown){
			console.log(jqXHR+","+textStatus+","+errorThrown)
		}
	})
}
function asfafasfwfa(){
	$.ajax({
		url:"Search",
		type:"post",
		data:{
			"reqtype":"reqComment",
			"cId":cId,"iId":iId
		},
		dataType:"json",
		async:true,
		success:function(data){
			if(data.state=="评论成功"){
				$("#state4").click()					
			}else{
				alert(data.state)
			}
		},
		error:function(jqXHR,textStatus,errorThrown){
			console.log(jqXHR+","+textStatus+","+errorThrown)
		}
	})
}
function updateGoods(that){          //修改商品
	var cId=$(that).data("cid")
	$.get("views/editComs.jsp",{cid:cId},function(data){
		$("#pushGoods").replaceWith(data)
		$("#pushGoods").css("display","")
		$("#bg").css({
            display: "block", height: $(document).height(),
           });
	});
	
}
function regMerchant(){
	$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"regMerchant",
			},
			//dataType:"text",
			async:true,
			success:function(data){
				if(data.replace(/^\s+|\s+$/g,"")=="注册成功"){
					alert("注册成功")
					location.reload()
				}else if(data.replace(/^\s+|\s+$/g,"")=="注册失败"){
					alert("注册失败")
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
}

$(".right-nav-shopping-car").click(function(){
	if( $(this).css("right")=="10px"){            //开始展开
		//$("#sumSettlement").html("0")
		let num1=$("#shopping-car-number").data("num")
		let num2=$("#shopping-car-number").html()
		if(num1!=num2){
			$.get("views/getMyCart.jsp",function(data){
				$("#cart-scroll").html(data)
				$("#sumSettlement").html("0")
			});
		}
	
		 $(this).animate({"right":"350px"},1000);
		 $(".right-content").animate({"right":"0px"},1000);
		 $(".right-nav-shopping-message").animate({"right":"350px"},1000);
		 $(".go-top").animate({"right":"350px"},1000);
	}else{
		  $(".right-content").animate({"right":"-340px"},1000);
		  $(this).animate({"right":"10px"},1000);
		  $(".right-nav-shopping-message").animate({"right":"10px"},1000);
		  $(".go-top").animate({"right":"10px"},1000);
	}
});
$(".right-nav-shopping-message").click(function(){
	if( $(this).css("right")=="10px"){
		 $(this).animate({"right":"350px"},1000);
		 $(".right-content").animate({"right":"0px"},1000);
		 $(".right-nav-shopping-car").animate({"right":"350px"},1000);
		 $(".go-top").animate({"right":"350px"},1000);
	}else{
		  $(".right-content").animate({"right":"-340px"},1000);
		  $(this).animate({"right":"10px"},1000);
		  $(".right-nav-shopping-car").animate({"right":"10px"},1000);
		  $(".go-top").animate({"right":"10px"},1000);
	}
});

</script>
</html>