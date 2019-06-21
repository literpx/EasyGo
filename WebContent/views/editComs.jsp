<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
     
<c:if test="${param.cid!=null }">
<c:forEach items="${sessionScope.myCom }" var="item">
	<c:if test="${item.cId==param.cid}">
		<c:set var="commodity" scope="page" value="${item}" target="Commodity"/>
		<c:set var="cPic" scope="page" value="${fn:split(item.cPic, '&')}" target="ArrayList"/>
	</c:if>
</c:forEach>
</c:if>


<div id="pushGoods" style="display: none">
	<div class="signclose">
          <img src="images/signclose.png" width="35px" height="35px" onclick="signclose2()" data-isUpdate="no" id="signclose2">
      </div>
      <div class="push-item"><form method="POST" enctype="multipart/form-data" id="formPushGoods">
			<input type="file" name="picfile1" id="picfile1" onchange="readpic(this)" style="display: none"  accept = "image/*" data-img="0"/>
			<input type="file" name="picfile2" id="picfile2" onchange="readpic(this)" style="display: none"  accept = "image/*" data-img="1"/>
			<input type="file" name="picfile3" id="picfile3" onchange="readpic(this)" style="display: none"  accept = "image/*" data-img="2"/>
      <div class="push-img" >
    	<div style="position:relative;" class="push-img-div"><img src="images/deletePic.png" class="deletePic" style="position:absolute;right:15px;
    	top:15px;width:30px;height:30px;display: none;z-index: 14" onclick="deleteTheImg(this)" data-picfile="picfile1">
      	<c:if test="${cPic[0]!=null }">
      		<img src="${cPic[0] }" onclick="document.getElementById('picfile1').click();" class="pushImg" >
      	</c:if>
      	<c:if test="${cPic[0]==null }">
      		<img src="images/addpic.png" onclick="document.getElementById('picfile1').click();"  class="pushImg">
      	</c:if>
      	</div>
      	<div style="position:relative;" class="push-img-div"><img src="images/deletePic.png" class="deletePic" style="position:absolute;right:30px;
    	top:30px;width:30px;height:30px;display: none;z-index: 14" onclick="deleteTheImg(this)" data-picfile="picfile2">
      	<c:if test="${cPic[1]!=null }">
      		<img src="${cPic[1] }" onclick="document.getElementById('picfile2').click();"  class="pushImg">
      	</c:if>
      	<c:if test="${cPic[1]==null }">
       		<img src="images/addpic.png" onclick="document.getElementById('picfile2').click(); "  class="pushImg">
      	</c:if>
      	</div>
      	<div style="position:relative;" class="push-img-div"><img src="images/deletePic.png" class="deletePic" style="position:absolute;right:30px;
    	top:30px;width:30px;height:30px;display: none;z-index: 14" onclick="deleteTheImg(this)" data-picfile="picfile3">
      	<c:if test="${cPic[2]!=null }">
      		<img src="${cPic[2] }" onclick="document.getElementById('picfile3').click();" class="pushImg">
      	</c:if>
      	<c:if test="${cPic[2]==null }">
      		<img src="images/addpic.png" onclick="document.getElementById('picfile3').click();" class="pushImg">
      	</c:if>
      	</div>
      </div>
      <div class="push-name">
	      <input type="text" id="push-name" name="name" placeholder="商品名称" value="${commodity.cName}" style="width:160px">
	      <input type="text" id="push-price" name="price"  placeholder="价格" value="${commodity.price}">
	      <input type="text" id="push-number" name="number"  placeholder="数量" value="${commodity.number}">
      </div>
      <div class="push-type">类型
      <c:forEach items="${applicationScope.allType}" var="item" varStatus="s">
      <c:if test="${s.count%5==0 }">
      	<br>
      </c:if>
      	<label>
      	<c:if test="${fn:contains(commodity.cType,item)}">
      	<input name="type" type="checkbox" value="${item}" checked="checked"/>
      	</c:if>
      	<c:if test="${!fn:contains(commodity.cType,item)}">
      	<input name="type" type="checkbox" value="${item}"/>
      	</c:if>
      	${item} </label>
      </c:forEach>
      	
		 <input name="otherType" type="text" id="push-other" placeholder="其他">
      </div>
      <div class="push-desc"><textarea name="desc" rows="10" cols="50" placeholder="商品介绍" >${commodity.content}</textarea></div>
      <div class="push-submit">
      	<c:if test="${commodity==null}">
		 	<button onclick="pushSubmit()">发布</button>
		</c:if>
     	 <c:if test="${commodity!=null}">
		 	<button onclick="updateSubmit(this)" data-cid=${commodity.cId }>修改</button>
		 </c:if>
      </div>
      </form></div>
</div>
<script type="text/javascript">
$(function (){        //登录与注册切换
		$(".push-img .push-img-div").mouseover(function (){
			if(!($(this).children(".pushImg").attr("src")=="images/addpic.png")){
				$(this).children(".pushImg").css("opacity","0.7")
	           $(this).children(".deletePic").show();  
			}
        }).mouseout(function (){  
        		$(this).children(".deletePic").hide();
        		$(this).children(".pushImg").css("opacity","1")
        	
        });  
}) 
</script>