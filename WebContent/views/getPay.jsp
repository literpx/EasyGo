<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
  <c:set var="cIds" scope="page" value="${fn:split(param.cIds, '&')}"/>
  <c:set var="cNames" scope="page" value="${fn:split(param.cNames, '&')}"/>
  <c:set var="cPics" scope="page" value="${fn:split(param.cPics, '&')}"/>
  <c:set var="cNumbers" scope="page" value="${fn:split(param.cNumbers, '&')}"/> 
  <c:set var="cPrices" scope="page" value="${fn:split(param.cPrices, '&')}"/> 
  <c:set var="sumNumber" scope="page" value="0"/> 
  <c:forEach items="${cNumbers }" var="item">
  	<c:set var="sumNumber" scope="page" value="${sumNumber+item}"/> 
  </c:forEach>
  
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#payIndent{
	font-family: 微软雅黑;
    position: fixed;
    background-color: white;
    top: 20%;
    left: 35%;
    width: 420px;
    height: 420px;
    border-radius: 1em;
    z-index: 999;
    padding-left: 15px;
}
#pay-scroll{
	width:98%;
	height:50%;
	clear: both;
    overflow-x: hidden;
    overflow-y: auto;
    white-space: nowrap;
    scroll-snap-points-y: repeat(100%);
    scroll-snap-type: mandatory;
}
#pay-scroll div{
	height: 150px
}
.addr-div,.phone-div{
height: 50px;
margin-top: 15px;
}
.addr-div input,.phone-div input{
    border-radius: 0.2em;
    width:70%;
    height: 40px;
    border: none;
    background-color:#f2f2f2;
    font-size: 20px;
    margin-left: 10px;
}
.pay-div{
	display: flex;
	flex-direction: row;
	justify-content: space-around;
}
.pay-div p{
	font-size: 20px;
	font-weight: bold;
	color: red;
	margin-top: 10px;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div id="payIndent" data-cids="${param.cIds }" data-cnums="${param.cNumbers }" 
	data-summoney="${ param.sumMoney }" data-uid="${sessionScope.user.uId }">
		<div class="signclose">
          <img src="images/signclose.png" width="35px" height="35px" onclick="signclose3(this)">
      </div>
      <p>支付订单</p>
      <div class="addr-div">收货地址<input type="text" value="${sessionScope.user.addr }"></div>
      <div class="phone-div">手&nbsp;机&nbsp;号&nbsp;<input type="text" value="${sessionScope.user.phone }"></div>
      <div id="pay-scroll">
      		<c:forEach items="${cIds }" var="item" varStatus="s">
				<div class="userCart-item">
					<div class="userCart-item-img"><img src="${ cPics[s.index]}" ></div>
					<div class="userCart-item-info" style="margin-top:20px;">
						<p><font  color="red">￥</font><font color="red" class="Commoney">${cPrices[s.index]}</font></p>
						<p>${ cNames[s.index]}</p>
					</div>
					<div style="margin-top:50px;">x${ cNumbers[s.index]}</div>
				</div>
			</c:forEach>
      </div>
      <div class="pay-div"><p>￥${ param.sumMoney }</p>
      <button class="settlement-btn" style="width:150px;margin-left: 20px;margin-top: 5px" onclick="payRequset()">确认支付(${sumNumber})</button>
      </div>
 </div>
	
</body>
</html>