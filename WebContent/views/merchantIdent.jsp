<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
    	<c:forEach items="${sessionScope.merchantIndent }" var="item">
				<div class="my-ident-item">
					<img src="${(fn:split(item.cPic, '&'))[0] }" />
					<div class="my-ident-item-info">
						<p>${item.cName }&nbsp;&nbsp;数量:${item.number }</p>
						<p>下单时间:&nbsp;${item.time }</p>
					</div>
					<div class="my-ident-item-state">
						<p style="color:red">${item.state }</p>
						<p>快递公司&nbsp;
							<c:if test="${item.comName!=null }">
								${item.comName}
							</c:if>
							<c:if test="${item.comName==null }">
								<select>
								<c:forEach items="${applicationScope.allCompany }" var="item2">
									<option value="${item2 }">${item2 }</option>
								</c:forEach>
							</select>
							</c:if>
						</p>
					</div>
					<c:if test="${item.state=='待发货' }">
						<button class="my-ident-item-btn" onclick="startFaHuo(this)"  
						data-cid="${item.cId }" data-number="${item.number }" data-iid="${item.iId }">开始发货</button>
					</c:if>
					<c:if test="${!(item.state=='待发货') }">
						<a href="#" class="my-ident-item-more">查看详情</a>
					</c:if>
				</div>
			</c:forEach>