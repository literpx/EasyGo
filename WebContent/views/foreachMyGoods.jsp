<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
          <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
			<c:forEach items="${sessionScope.myCom }" var="item" varStatus="s">
			<div class="shop-commodity-item" style="background-color: ${item.isShow?'#fff':'#e6d6e6'}">
				<div class="commodity-item-left">
					<img src="${fn:substring(item.cPic,0,fn:indexOf(item.cPic,'&'))}" data-cid="${item.cId }" onclick="goToTheCom(this)" data-cid="${item.cId}">
				</div>
				<div class="commodity-item-right">
					<div class="commodity-item-right-one"><p>${item.cName }</p><button onclick="updateGoods(this)" data-cid="${item.cId }">修改</button></div>
					<div class="commodity-item-right-two">
						<p>价格&nbsp;<font color="red">￥${item.price }</font></p>
						<c:if test="${item.isShow}">
						<button onclick="pushDownCom(this)" data-cid='${item.cId }'>下架</button>
						</c:if>
						<c:if test="${!item.isShow}">
						<button onclick="pushCom(this)" data-cid="${item.cId }" style="background-color: #b45654">上架</button>
						</c:if>
					</div>
					<div class="commodity-item-right-two2"><p>数量&nbsp;${item.number }</p></div>
					<div class="commodity-item-right-three"><p>销量&nbsp;${item.sales }</p></div>
				</div>
			</div>
			</c:forEach>
