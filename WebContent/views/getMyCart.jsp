<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<c:forEach items="${sessionScope.userCart }" var="item">
				<div class="userCart-item">
					<div class="choose-div">
						<label for="${item }" class="choose_label choose_check">
						<input type="checkbox" class="choose_input" id="${item }" name="choose"></label>
					</div>
					<div class="userCart-item-img"><img src="${(fn:split(item.cPic, '&'))[0] }" ></div>
					<div class="userCart-item-info">
						<p><font  color="red">￥</font><font color="red" class="Commoney">${item.price }</font></p>
						<p>${item.cName }&nbsp;(剩${item.number }件)</p>
						<button class="subBtn" onclick="subAction(this)">-</button>
						<input type="text" value="${item.cartNumber}" class="numberInput" 
						disabled="disabled" data-cid="${ item.cId}" data-cname="${item.cName }">
						<button class="addBtn" onclick="addAction(this)" data-max="${item.number }">+</button>
					</div>
				</div>
			</c:forEach>
<script type="text/javascript">		
$("#cart-scroll .choose-div input").click(function(){
			if($(this).is(":checked")){          	//勾选
				$(this).parent().removeClass("choose_check").addClass("choose_checked");
				
				let	sum=$("#sumSettlement").html()
				sum=parseFloat(sum)
				let divInfo=$(this).parents(".choose-div").nextAll(".userCart-item-info")
				let moneyitem=divInfo.find("p .Commoney").html()*divInfo.find("input[type=text]").val()
				sum+=parseFloat(moneyitem)
				$("#sumSettlement").html(sum)
				
			}else{                              	//取选
				$(this).parent().removeClass("choose_checked").addClass("choose_check");
				$("#settlement input")[0].checked=false;
				
				let	sum=$("#sumSettlement").html()
				sum=parseFloat(sum)
				let divInfo=$(this).parents(".choose-div").nextAll(".userCart-item-info")
				let moneyitem=divInfo.find("p .Commoney").html()*divInfo.find("input[type=text]").val()
				sum-=parseFloat(moneyitem)
				$("#sumSettlement").html(sum)
			}
		})
</script>