<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
     
     <c:if test="${param.reqSearch!=null }">
     	<c:set var="coms" scope="page" value="${sessionScope.searchCom}" />
     </c:if>
     <c:if test="${param.reqSearch==null }">
     	<c:set var="coms" scope="page" value="${applicationScope.allCom}" />
     </c:if>
     
		<div id="index-center">
			<c:set var="count" scope="page" value="1" />
			<c:forEach items="${coms }" var="item" varStatus="s">
				<c:if test="${s.first }">
					<div class="index-item">
				</c:if>
				
				<c:set var="number" scope="page" value="${s.count%3}" />
				
				<c:if test="${count==1 }">
					<c:if test="${number==1}">
						<div class="index-item-top">
						<div class="index-coms-item1">
						<img alt="" src="${(fn:split(item.cPic, '&'))[0] }" onclick="goToTheCom(this)" data-cid="${item.cId}">
						<p style="font-size: 18px;color:red">￥${item.price }</p>
						<p>${item.cName }&nbsp;(${item.cType })</p>
						</div>
					</c:if>
					<c:if test="${number==2}">
						<div class="index-coms-item1">
						<img alt="" src="${(fn:split(item.cPic, '&'))[0] }" onclick="goToTheCom(this)" data-cid="${item.cId}">
						<p style="font-size: 18px;color:red">￥${item.price }</p>
						<p>${item.cName }&nbsp;(${item.cType })</p>
						</div>
					</c:if>
					<c:if test="${number==0 }">
						</div><div class="index-item-bottom  index-coms-item2" onclick="goToTheCom(this)" data-cid="${item.cId}">
							<img alt="" src="${(fn:split(item.cPic, '&'))[0] }">
							<div>
							<p style="font-size: 18px;color:red">￥${item.price }</p>
							<p>${item.cName }&nbsp;(${item.cType })</p>
							</div>
						</div>
					</c:if>
				</c:if>
				
				<c:if test="${count==0 }">
					<c:if test="${number==1}">
						<div class="index-item-bottom  index-coms-item2">
							<img alt="" src="${(fn:split(item.cPic, '&'))[0] }" onclick="goToTheCom(this)" data-cid="${item.cId}">
							<div>
							<p style="font-size: 18px;color:red">￥${item.price }</p>
							<p>${item.cName }&nbsp;(${item.cType })</p>
							</div>
						</div>
					</c:if>
					<c:if test="${number==2}">
						<div class="index-item-top">
							<div class="index-coms-item1">
							<img alt="" src="${(fn:split(item.cPic, '&'))[0] }" onclick="goToTheCom(this)" data-cid="${item.cId}">
							<p style="font-size: 18px;color:red">￥${item.price }</p>
							<p>${item.cName }&nbsp;(${item.cType })</p>
							</div>
					</c:if>
					<c:if test="${number==0 }">
							<div class="index-coms-item1">
							<img alt="" src="${(fn:split(item.cPic, '&'))[0] }" onclick="goToTheCom(this)" data-cid="${item.cId}">
							<p style="font-size: 18px;color:red">￥${item.price }</p>
							<p>${item.cName }&nbsp;(${item.cType })</p>
							</div>
						</div>
					</c:if>
				</c:if>
				
				<c:if test="${number==0 }">
					</div>       <!-- index-item结束位 -->
					<div class="index-item">
					<c:if test="${count==0 }">
						<c:set var="count1" scope="page" value="1" />
					</c:if>
					<c:if test="${count==1 }">
						<c:set var="count1" scope="page" value="0" />
					</c:if>
					
					<c:set var="count" scope="page" value="${ count1}" />
					
				</c:if>
				<c:if test="${s.last&&number!=0 }">
					</div></div>
				</c:if>
			</c:forEach>
			
		</div>