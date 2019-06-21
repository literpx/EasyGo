<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
    
    		<c:forEach items="${sessionScope.userIndent }" var="item">
    			<c:if test="${param.state!=null }">
    				<c:if test="${param.state==item.stateNum }">
    					<div style="border-bottom: 1px solid #949494;" class="my-ident-all">
    				<div class="my-ident-item">
						<img src="${(fn:split(item.cPic, '&'))[0] }" />
						<div class="my-ident-item-info">
							<p>${item.cName }&nbsp;&nbsp;数量:${item.number }</p>
							<p>下单时间:&nbsp;${item.time }</p>
						</div>
						<div class="my-ident-item-state" style="text-align: center;">
							<p style="color:red">${item.state }</p>
							<p>${item.comName }</p>
						</div>
						<c:if test="${item.state=='待发货' }">
							<button class="my-ident-item-btn" onclick="urgedInent(this)" data-mid="${item.mId }" style="background-color: red">催促发货</button>
						</c:if>
						<c:if test="${item.state=='送货中' }">
							<button class="my-ident-item-btn" onclick="reqConfirm(this)"  
							data-cid="${item.cId }" data-number="${item.number }" data-iid="${item.iId }">确认收货</button>
						</c:if>
						<c:if test="${item.state=='待评价' }">
							<button class="my-ident-item-btn" onclick="reqComment(this)"  data-cid="${item.cId }"
							  data-iid="${item.iId }" style="background-color: green">立即评价</button>
						</c:if>
						<c:if test="${item.state=='已完成' }">
							<a href="#" class="my-ident-item-more">查看详情</a>
						</c:if>
					</div>
					</div>
    				</c:if>
    			</c:if>
    			<c:if test="${param.state==null }">
    				<div style="border-bottom: 1px solid #949494;" class="my-ident-all">
    				<div class="my-ident-item">
						<img src="${(fn:split(item.cPic, '&'))[0] }" />
						<div class="my-ident-item-info">
							<p>${item.cName }&nbsp;&nbsp;数量:${item.number }</p>
							<p>下单时间:&nbsp;${item.time }</p>
						</div>
						<div class="my-ident-item-state" style="text-align: center;">
							<p style="color:red">${item.state }</p>
							<p>${item.comName }</p>
						</div>
						<c:if test="${item.state=='待发货' }">
							<button class="my-ident-item-btn" onclick="urgedInent(this)" data-mid="${item.mId }" style="background-color: red">催促发货</button>
						</c:if>
						<c:if test="${item.state=='送货中' }">
							<button class="my-ident-item-btn" onclick="reqConfirm(this)"  
							data-cid="${item.cId }" data-number="${item.number }" data-iid="${item.iId }">确认收货</button>
						</c:if>
						<c:if test="${item.state=='待评价' }">
							<button class="my-ident-item-btn" onclick="reqComment(this)"  data-cid="${item.cId }"
							  data-iid="${item.iId }" style="background-color: green">立即评价</button>
						</c:if>
						<c:if test="${item.state=='已完成' }">
							<a href="#" class="my-ident-item-more">查看详情</a>
						</c:if>
					</div>
					</div>
    			</c:if>
    			
			</c:forEach>
			
<script type="text/javascript">
function urgedInent(that){
	var mId=$(that).data("mid")
	//alert(mId)
		$.ajax({
			url:"Search",
			type:"post",
			data:{
				"reqtype":"getuIdBymId",
				"mId":mId
			},
			dataType:"json",
			async:true,
			success:function(data){
				if(data.state=="成功"){
					 websocket.send("发送到"+data.uId+"&&&您收新一笔催单，请及时处理！")	
					 alert("催单成功")
				}else{
					alert(data.state)
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR+","+textStatus+","+errorThrown)
			}
		})
}
</script>