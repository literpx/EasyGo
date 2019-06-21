<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 
    <c:forEach items="${applicationScope.allCom }" var="item">
		<c:if test="${item.cId==param.cid}">
			<c:set var="thiscomm" scope="page" value="${item}" target="Commodity"/>
			<c:set var="thiscPic" scope="page" value="${fn:split(item.cPic, '&')}" target="ArrayList"/>
		</c:if>
	</c:forEach>
	
    
		<div id="commodityInfo">
			
			<div id="commodityInfo-left">
				<div id="commodityInfo-showpic">
					<div id="showpic-small">
						<a href="javascript:void(0);" onclick="changeAnimation(this)" data-id="1">
							<c:if test="${thiscPic[0]!=null }">
								<img src="${thiscPic[0] }" />
							</c:if>
							<c:if test="${thiscPic[0]==null }">
								<img src="images/loadmore.jpg" />
							</c:if>
						</a>
						<a href="javascript:void(0);" onclick="changeAnimation(this)" data-id="2">
							<c:if test="${thiscPic[1]!=null }">
								<img src="${thiscPic[1] }" />
							</c:if>
							<c:if test="${thiscPic[1]==null }">
								<img src="images/loadmore.jpg" />
							</c:if>
						</a>
						<a href="javascript:void(0);" onclick="changeAnimation(this)" data-id="3">
							<c:if test="${thiscPic[2]!=null }">
								<img src="${thiscPic[2] }" />
							</c:if>
							<c:if test="${thiscPic[2]==null }">
								<img src="images/loadmore.jpg" />
							</c:if>
						</a>
					</div>
					<div id="showpic-big">
						<ul class="animation1" id="showpic-big-ul">
						  <li><a href="javascript:void(0);">
						  	<c:if test="${thiscPic[0]!=null }">
							 	<img src="${thiscPic[0] }" />
							 </c:if>
							 <c:if test="${thiscPic[0]==null }">
								<img src="images/loadmore.jpg" />
							 </c:if>
						  </a></li>
						  <li><a href="javascript:void(0);">
						  	 <c:if test="${thiscPic[1]!=null }">
								<img src="${thiscPic[1] }" />
							 </c:if>
							 <c:if test="${thiscPic[1]==null }">
								<img src="images/loadmore.jpg" />
							 </c:if>
						  </a></li>
						  <li><a href="javascript:void(0);">
							 <c:if test="${thiscPic[2]!=null }">
								<img src="${thiscPic[2] }" />
							 </c:if>
							 <c:if test="${thiscPic[2]==null }">
								<img src="images/loadmore.jpg" />
							 </c:if>
						  </a></li>
						</ul>
					</div>
				</div>
				<div id="commodityInfo-msg">
					<div id="commodityInfo-money">
						￥${thiscomm.price }
					</div>
					<div id="commodityInfo-name">
						<p id="info-name">${thiscomm.cName }&nbsp;&nbsp;
						<font style="font-size: 18px">(${ thiscomm.cType})</font></p>
						<div id="shareBtn"><img src="images/share.png" width="15px" height="15px">分享</div>
					</div>
					<div id="commodityInfo-shop">
						<p id="info-shop">商铺名：${thiscomm.mName }</p>
					</div>
					<div id="commodityInfo-bottom">
						<p>快递:免运费</p>
						<p>销售量&nbsp;${thiscomm.sales }</p>
						<p>广东广州</p>
					</div>
					<hr style="opacity: 0.4;background-color: #f4f4f4">
					<div id="commodityInfo-buyBtn">
						<button id="getToChart" onclick="getToCart(this)" data-cid="${thiscomm.cId }" data-cmid="${thiscomm.mId}"
						 data-uid="${sessionScope.user.uId}" data-mid="${sessionScope.user.mId}">加入购物车</button>
						<button id="getToBuy" onclick="getToBuy(this)" data-cid="${thiscomm.cId }" data-cmid="${thiscomm.mId}"
						 data-uid="${sessionScope.user.uId}" data-mid="${sessionScope.user.mId}">立即购买</button>
					</div>
				</div>
			</div>
			<div id="commodityInfo-right" data-uid="${sessionScope.user.uId }">
				<div class="hotComment">
					<c:forEach items="${sessionScope.cComment }" var="item">
					<div class="hotComment-item">
						<div class="hotComment-top"><img src="${item.uHead }"><p>${item.uName}</p></div>
						<div class="hotComment-centent"><p>
						${item.content }
						</p></div>
						<div class="hotComment-bottom">
							<p class="hotComment-bottom-p">${item.time }</p>
							<div class="hotComment-bottom-right">
							<div><img src="images/comment2.png" title="评论" class="" onclick="getchildrenComment(this)">
							<p>${fn:length(item.childrenComment) }</p></div>
							<div>
								<c:forEach items="${ item.pick}" var="pick">
									<c:if test="${pick==sessionScope.user.uId }">
										<c:set var="what" scope="page" value="${pick}"/>
									</c:if>
								</c:forEach>
								<c:if test="${what!=null}">
										<img src="images/pick1.png" title="赞一下" onclick="doCancelPick(this)" data-rid="${item._id }">
								</c:if>
								<c:if test="${what==null}">
										<img src="images/pick0.png" title="赞一下"  onclick="doPick(this)" data-rid="${item._id }">
								</c:if>
								<c:remove var="what"/>
								<p>${fn:length(item.pick) }</p>
							</div>
							<div>
								<c:forEach items="${ item.unpick}" var="pick">
									<c:if test="${pick==sessionScope.user.uId }">
										<c:set var="what1" scope="page" value="${pick}"/>
									</c:if>
								</c:forEach>
								<c:if test="${what1!=null}">
										<img src="images/unpick1.png" title="踩一下" onclick="doCancelUnPick(this)"
										data-rid="${item._id }">
								</c:if>
								<c:if test="${what1==null}">
										<img src="images/unpick0.png" title="踩一下" onclick="doUnPick(this)"
										data-rid="${item._id }">
								</c:if>
								<c:remove var="what1"/>
							<p>${fn:length(item.unpick) }</p></div>
							</div>
						</div>
					</div>	
					<div class="childrenComment" style="display: none">
						<hr style="background-color: #888;opacity: 0.2;width: 80%;margin: 10px auto">
							<div class="comment">
							<div contenteditable="true" class="demoEdit" id="commentText" style="width: 70%"></div> 
							<button class="comment-btn" onclick="sendChildrenComment(this)" data-rid="${item._id }" data-uid="${sessionScope.user.uId }">发表评论</button>
							</div>
						<c:forEach items="${item.childrenComment }" var="itemc">
							<hr style="background-color: #888;opacity: 0.2;width: 80%;margin: 10px auto">
							<div class="hotComment-item" style="width:90%;margin-left: 5%">
								<div class="hotComment-top"><img src="${itemc.uHead }"><p>${itemc.uName}</p></div>
								<div class="hotComment-centent"><p style="width:80%">
								${itemc.content }
								</p></div>
								<div class="hotComment-bottom">
									<p class="hotComment-bottom-p">${itemc.time }</p>
									<div class="hotComment-bottom-right" style="margin-left: 30px;width: 200px;">
									<div>
										<c:forEach items="${ itemc.pick}" var="pick">
											<c:if test="${pick==sessionScope.user.uId }">
												<c:set var="what3" scope="page" value="${pick}"/>
											</c:if>
										</c:forEach>
										<c:if test="${what3!=null}">
												<img src="images/pick1.png" title="赞一下" onclick="doCancelPick2(this)"
												data-uid="${itemc.uid }" data-handle="$pull" data-rid="${item._id }">
												
										</c:if>
										<c:if test="${what3==null}">
												<img src="images/pick0.png" title="赞一下"  onclick="doPick2(this)"
												data-uid="${itemc.uid }" data-handle="$push" data-rid="${item._id }">
										</c:if>
										<c:remove var="what3"/>
										<p>${fn:length(itemc.pick) }</p>
									</div>
									<div>
										<c:forEach items="${ itemc.unpick}" var="pick">
											<c:if test="${pick==sessionScope.user.uId }">
												<c:set var="what4" scope="page" value="${pick}"/>
											</c:if>
										</c:forEach>
										<c:if test="${what4!=null}">
												<img src="images/unpick1.png" title="踩一下" onclick="doCancelUnPick2(this)"
												data-uid="${itemc.uid }" data-handle="$pull" data-rid="${item._id }">
										</c:if>
										<c:if test="${what4==null}">
												<img src="images/unpick0.png" title="踩一下" onclick="doUnPick2(this)"
												data-uid="${itemc.uid }" data-handle="$push" data-rid="${item._id }">
										</c:if>
										<c:remove var="what4"/>
									<p>${fn:length(itemc.unpick) }</p></div>
									</div>
								</div>
								</div>
							</c:forEach>			
							</div>	
					<hr style="background-color: #666666;opacity: 0.4;width: 90%;margin: 10px auto">
					</c:forEach>
				</div>
			</div>
		</div>	
<script type="text/javascript">
function sendChildrenComment(that){
	var content=$(that).prev("div[class=demoEdit]").html()
	var rId=$(that).data("rid")
	var uId=$(that).data("uid")
	if(uId==null||uId==""){
		alert("请先登录")		
	}else{
			$.ajax({
				url:"Search",
				type:"post",
				data:{
					"reqtype":"sendChildrenComment",
					"content":content,
					"rId":rId,"uId":uId
				},
				dataType:"json",
				async:true,
				success:function(data){
					alert(data.state)
				},
				error:function(jqXHR,textStatus,errorThrown){
					console.log(jqXHR+","+textStatus+","+errorThrown)
				}
			})
	}
	
}
function doUnPick2(that){         //踩子评论
	var uuId=$("#commodityInfo-right").data("uid")   //用户uid
	var rId=$(that).data("rid")  //评论id
	var uId=$(that).data("uid")		//操作子评论的uid
	var handle=$(that).data("handle")
	var pick
	if($(that).attr("title")=="赞一下"){
		pick="pick"
	}else{
		pick="unpick"
	}
	if(uuId==null||uuId==""){
		alert("请先登录")		
	}else{
			var isPick=null
			var pickDom=$(that).parent("div").prev("div").find("img[title='赞一下']")
			if(pickDom.attr("src")=="images/pick1.png"){
				isPick="pick"
			}
			$.ajax({
				url:"Search",
				type:"post",
				data:{
					"reqtype":"updateChildrenComment",
					"rId":rId,"uId":uId,"uuId":uuId,"handle":handle,"isPick":isPick,"pick":pick
				},
				dataType:"json",
				async:true,
				success:function(data){
					$(that).next("p").html(parseInt($(that).next("p").html())+1)
					$(that).replaceWith("<img src='images/unpick1.png' title='踩一下' onclick='doCancelUnPick2(this)' "+
							"data-uid='"+uId+"' data-handle='$pull' data-rid='"+rId+"'>")
					if(isPick!=null){
						pickDom.next("p").html(parseInt(pickDom.next("p").html())-1)
						pickDom.replaceWith("<img src='images/pick0.png' title='赞一下'  onclick='doPick2(this)' "+
						"data-uid='"+uId+"' data-handle='$push' data-rid='"+rId+"'>")
					}
				},
				error:function(jqXHR,textStatus,errorThrown){
					console.log(jqXHR+","+textStatus+","+errorThrown)
				}
			})
	}
}
function doCancelUnPick2(that){
	var uuId=$("#commodityInfo-right").data("uid")  
	var rId=$(that).data("rid")  
	var uId=$(that).data("uid")
	var handle=$(that).data("handle")
	var pick
	if($(that).attr("title")=="赞一下"){
		pick="pick"
	}else{
		pick="unpick"
	}
	if(uuId==null||uuId==""){
		alert("请先登录")		
	}else{
		$.ajax({ 
			   url:"Search", 
			   type:"post", 
			   data:{
				   "reqtype":"updateChildrenComment",
					"rId":rId,"uId":uId,"uuId":uuId,"handle":handle,"pick":pick
			   }, 
			   success:function(data){ 
				  	$(that).next("p").html(parseInt($(that).next("p").html())-1)
					$(that).replaceWith("<img src='images/unpick0.png' title='踩一下' onclick='doUnPick2(this)' "+
							"data-uid='"+uId+"' data-handle='$push' data-rid='"+rId+"'>")
			   }, 
			   error:function(err){ 
			    alert("网络连接失败,稍后重试"+err); 
			   } 
		}) 
	}
}
function doPick2(that){
	var uuId=$("#commodityInfo-right").data("uid")   //用户uid
	var rId=$(that).data("rid")  //评论id
	var uId=$(that).data("uid")		//操作子评论的uid
	var handle=$(that).data("handle")
	var pick
	if($(that).attr("title")=="赞一下"){
		pick="pick"
	}else{
		pick="unpick"
	}
	if(uuId==null||uuId==""){
		alert("请先登录")		
	}else{
			var isPick=null
			var pickDom=$(that).parent("div").next("div").find("img[title='踩一下']")
			if(pickDom.attr("src")=="images/unpick1.png"){
				isPick="unpick"
			}
			$.ajax({
				url:"Search",
				type:"post",
				data:{
					"reqtype":"updateChildrenComment",
					"rId":rId,"uId":uId,"uuId":uuId,"handle":handle,"isPick":isPick,"pick":pick
				},
				dataType:"json",
				async:true,
				success:function(data){
					$(that).next("p").html(parseInt($(that).next("p").html())+1)
					$(that).replaceWith("<img src='images/pick1.png' title='赞一下'  onclick='doCancelPick2(this)' "+
							"data-uid='"+uId+"' data-handle='$pull' data-rid='"+rId+"'>")
					if(isPick!=null){
						pickDom.next("p").html(parseInt(pickDom.next("p").html())-1)
						pickDom.replaceWith("<img src='images/unpick0.png' title='踩一下' onclick='doUnPick2(this)' "+
								"data-uid='"+uId+"' data-handle='$push' data-rid='"+rId+"'>")
					}
				},
				error:function(jqXHR,textStatus,errorThrown){
					console.log(jqXHR+","+textStatus+","+errorThrown)
				}
			})
	}
}
function doCancelPick2(that){
	var uuId=$("#commodityInfo-right").data("uid")  
	var rId=$(that).data("rid")  
	var uId=$(that).data("uid")
	var handle=$(that).data("handle")
	var pick
	if($(that).attr("title")=="赞一下"){
		pick="pick"
	}else{
		pick="unpick"
	}
	if(uuId==null||uuId==""){
		alert("请先登录")		
	}else{
		$.ajax({ 
			   url:"Search", 
			   type:"post", 
			   data:{
				   "reqtype":"updateChildrenComment",
					"rId":rId,"uId":uId,"uuId":uuId,"handle":handle,"pick":pick
			   }, 
			   success:function(data){ 
				  	$(that).next("p").html(parseInt($(that).next("p").html())-1)
					$(that).replaceWith("<img src='images/pick0.png' title='赞一下'  onclick='doPick2(this)' "+
							"data-uid='"+uId+"' data-handle='$push' data-rid='"+rId+"'>")
			   }, 
			   error:function(err){ 
			    alert("网络连接失败,稍后重试"+err); 
			   } 
		}) 
	}
}
function getchildrenComment(that){
	var dom=$(that).parents(".hotComment-item").next(".childrenComment")
	if(dom.is(":hidden")){
		$(that).parents(".hotComment-item").next(".childrenComment").slideDown("fast")
	}else{
		$(that).parents(".hotComment-item").next(".childrenComment").slideUp("fast")
	}
	
}
function doUnPick(that){    //踩
	var uId=$("#commodityInfo-right").data("uid")
	var rid=$(that).data("rid")  
	if(uId==""||uId==null){
		alert("请先登录！")
	}else{
		var isPick=null
		var pickDom=$(that).parent("div").prev("div").find("img[title='赞一下']")
		if(pickDom.attr("src")=="images/pick1.png"){
			isPick="yes"
		}
		$.ajax({ 
			   url:"Search", 
			   type:"post", 
			   data:{
				   "reqtype":"doUnPick",
				   "rId":rid,"uId":uId,"isPick":isPick
			   }, 
			   success:function(data){ 
				  	$(that).next("p").html(parseInt($(that).next("p").html())+1)
					$(that).replaceWith("<img src='images/unpick1.png' title='踩一下' onclick='doCancelUnPick(this)' data-rid='"+rid+"'>")
					if(isPick!=null){
						pickDom.next("p").html(parseInt(pickDom.next("p").html())-1)
						pickDom.replaceWith("<img src='images/pick0.png' title='赞一下'  onclick='doPick(this)' data-rid='"+rid+"'>")
					}
			   }, 
			   error:function(err){ 
			    alert("网络连接失败,稍后重试"+err); 
			   } 
			  
		}) 
	}
	
}
function doCancelUnPick(that){			//取消踩
	var uId=$("#commodityInfo-right").data("uid")  
	var rid=$(that).data("rid")  
	if(uId==""||uId==null){
		alert("请先登录！")
	}else{
		$.ajax({ 
			   url:"Search", 
			   type:"post", 
			   data:{
				   "reqtype":"doCancelUnPick",
				   "rId":rid,"uId":uId
			   }, 
			   success:function(data){ 
				  	$(that).next("p").html(parseInt($(that).next("p").html())-1)
					$(that).replaceWith("<img src='images/unpick0.png' title='踩一下' onclick='doUnPick(this)' data-rid='"+rid+"'>")
			   }, 
			   error:function(err){ 
			    alert("网络连接失败,稍后重试"+err); 
			   } 
			  
		}) 
	}
}
		
function doPick(that){			//赞
	var uId=$("#commodityInfo-right").data("uid")  
	var rid=$(that).data("rid") 
	if(uId==""||uId==null){
		alert("请先登录！")
	}else{
		var isUnPick=null
		var pickDom=$(that).parent("div").next("div").find("img[title='踩一下']")
		if(pickDom.attr("src")=="images/unpick1.png"){
			isUnPick="yes"
		}
		$.ajax({ 
			   url:"Search", 
			   type:"post", 
			   data:{
				   "reqtype":"doPick",
				   "rId":rid,"uId":uId,"isUnPick":isUnPick
			   }, 
			   success:function(data){ 
				  	$(that).next("p").html(parseInt($(that).next("p").html())+1)
					$(that).replaceWith("<img src='images/pick1.png' title='赞一下' onclick='doCancelPick(this)' data-rid='"+rid+"'>")
					if(isUnPick!=null){
						pickDom.next("p").html(parseInt(pickDom.next("p").html())-1)
						pickDom.replaceWith("<img src='images/unpick0.png' title='踩一下'  onclick='doUnPick(this)' data-rid='"+rid+"'>")
					}
			   }, 
			   error:function(err){ 
			    alert("网络连接失败,稍后重试"+err); 
			   } 
			  
		}) 
	}
}
function doCancelPick(that){		//取消赞
	var uId=$("#commodityInfo-right").data("uid")  
	var rid=$(that).data("rid")  
	$.ajax({ 
		   url:"Search", 
		   type:"post", 
		   data:{
			   "reqtype":"doCancelPick",
			   "rId":rid,"uId":uId
		   }, 
		   success:function(data){ 
				   $(that).next("p").html(parseInt($(that).next("p").html())-1)
					$(that).replaceWith("<img src='images/pick0.png' title='赞一下' onclick='doUnPick(this)' data-rid='"+rid+"'>")
		   }, 
		   error:function(err){ 
		    alert("网络连接失败,稍后重试"+err); 
		   } 
		  
	}) 
}
</script>