<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
    <div id="me-head">
			<div class="me-head-left">
				<div class="me-head-left-top">
					<c:if test="${sessionScope.user.head==null}">
						<img src="images/defaultHead.jpg" <c:if test="${sessionScope.user!=null }">onclick="updateUser()"</c:if>/>
					</c:if>
					<c:if test="${sessionScope.user.head!=null}">
						<img src="${sessionScope.user.head}" onclick="updateUser()" />
					</c:if>
				<p class="me-head-left username">${sessionScope.user.uName}</p></div>
				<div class="me-head-left-bottom">
					
					<c:if test="${sessionScope.user.isMerchants}">
						<img src="images/shop.png" width="30" height="30" >&nbsp;&nbsp;${sessionScope.user.mName}
					</c:if>
					<c:if test="${!sessionScope.user.isMerchants}">
						注册商家<input type="button" value="立即注册">
					</c:if>
				</div>
			</div>
			<div class="myAttention">
				<div class="myAttention-top">我的关注</div><hr style="color:#444;opacity:0.2">
				<div class="myAttention-bottom">
					<div ><p class="myAttention-one">6</p><p class="two">商品关注</p></div>
					<div><p class="myAttention-one">10</p><p class="two">店铺关注</p></div>
					<div><p class="myAttention-one">3</p><p class="two">收藏内容</p></div>
	
				</div>
			</div>
			<div class="me-head-right">
				<div class="me-head-right-top">我的钱包</div><hr style="color:#444;opacity:0.2">
				<div class="me-head-right-bottom">
					<div class="juan"><p class="one">0</p><p class="two">优惠卷</p><a  href="#"  class="three">领劵</a></div>
					<div class="money"><p class="one">7.52</p><p class="two">红包</p><a  href="#"  class="three">去抢</a></div>
					<div class="shouhuo"><p class="one" style="color:red">${sessionScope.user.money!=null?sessionScope.user.money:0.00 }</p><p class="two">充值</p><a  href="#" class="three">查看</a></div>
					<div class="yigoumai"><p class="one">520</p><p class="two">金豆</p><a  href="#" class="three">收集</a></div>
				</div>
			</div>
		</div>
		
		<div class="my-indent">
			<p>我的订单</p><hr style="color:#444;opacity:0.2">
			<div class="my-indent-nav">
				<div onclick="getNoSendIdent()" id="state1"><img src="images/fukuan.png">待发货</div>
				<div onclick="getSendIdent()" id="state2"><img src="images/shouhuo.png">待收货</div>
				<div onclick="getCommentIdent()" id="state3"><img src="images/comment.png">待评论</div>
				<div onclick="getCompleteIdent()" id="state4"><img src="images/wancheng.png">已完成</div>
				<div onclick="getAllIdent()" id="state0"><img src="images/all.png">全部订单</div>
			</div>
			<hr style="color:#444;opacity:0.2;">
			
			<div id="my-indent-content">
				
			</div>
		</div>