<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   		 <div class="shop-top">
			<div class="masking">
				<div class="shop-top-one"></div>
				<div class="shop-top-two">
					<p style="font-size:22px">${sessionScope.user.mName }</p>
					<div class="fans"><img src="images/huangguan.jpg" width="40px" height="40px"><p>粉丝数：5.23万</p></div>
					<c:if test="${sessionScope.user==null }">
						<button class="pushGoods">发布商品</button>
						<button class="pushGoods">我的商品</button>
						<button class="pushGoods">商铺订单</button>
					</c:if>
					<c:if test="${sessionScope.user!=null }">
						<button class="pushGoods" onclick="pushGoods()">发布商品</button>
						<button class="pushGoods" onclick="getMyGoods()" id="getMyGoods">我的商品</button>
						<button class="pushGoods" onclick="getIndent()">商铺订单</button>
					</c:if>
					
				</div>
				<div class="shop-top-three">
					<p>商品描述&nbsp;&nbsp;7.9</p>
					<p>商品评价&nbsp;&nbsp;8.3</p>
					<p>卖家服务&nbsp;&nbsp;9.0</p>
					<p>物理服务&nbsp;&nbsp;6.7</p>
				</div>
			</div>
		</div>
		<div class="shop-content">
		
		</div>
		
	
		

