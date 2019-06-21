<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
    <c:forEach items="${item.childrenComment }" var="itemc">
<hr style="background-color: #888;opacity: 0.2;width: 80%;margin: 10px auto">
							<div class="comment">
							<div contenteditable="true" class="demoEdit" id="commentText" style="width: 70%"></div> 
							<button class="comment-btn" onclick="sendComment(this)" data-cid="" data-uid="${sessionScope.user.uId }">发表评论</button>
							</div>
							<hr style="background-color: #888;opacity: 0.2;width: 80%;margin: 10px auto">
							<div class="hotComment-item" style="width:90%;margin-left: 5%">
								<div class="hotComment-top"><img src="${itemc.uHead }"><p>${itemc.uName}</p></div>
								<div class="hotComment-centent"><p style="width:80%">
								${itemc.content }
								</p></div>
								<div class="hotComment-bottom">
									<p class="hotComment-bottom-p">${itemc.time }</p>
									<div class="hotComment-bottom-right">
										<c:forEach items="${ itemc.pick}" var="pick">
											<c:if test="${pick==sessionScope.user.uId }">
												<c:set var="what" scope="page" value="${pick}"/>
											</c:if>
										</c:forEach>
										<c:if test="${what!=null}">
												<img src="images/pick1.png" title="赞一下" onclick="doCancelPick(this)" data-uid="${itemc.uid }">
										</c:if>
										<c:if test="${what==null}">
												<img src="images/pick0.png" title="赞一下"  onclick="doPick(this)" data-uid="${itemc.uid }">
										</c:if>
										<p>${fn:length(itemc.pick) }</p>
									</div>
									<div>
										<c:forEach items="${ itemc.unpick}" var="pick">
											<c:if test="${pick==sessionScope.user.uId }">
												<c:set var="what1" scope="page" value="${pick}"/>
											</c:if>
										</c:forEach>
										<c:if test="${what1!=null}">
												<img src="images/unpick1.png" title="踩一下" onclick="doCancelUnPick(this)"
												data-uid="${itemc.uid }">
										</c:if>
										<c:if test="${what1==null}">
												<img src="images/unpick0.png" title="踩一下" onclick="doUnPick(this)"
												data-uid="${itemc.uid }">
										</c:if>
									<p>${fn:length(itemc.unpick) }</p></div>
									</div>
								</div>
							</div>
			</c:forEach>				