<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="text" id="test"><button onclick="test()">提交</button>
</body>

<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>

<script type="text/javascript">
function test(){
	var test=$("#test").val()
	
	$.ajax({
		url:"Search",
		type:"post",
		data:{
			"reqtype":"test","content":test
		},
		dataType:"text",
		async:true,
		success:function(data){
			alert(data)
		},
		error:function(jqXHR,textStatus,errorThrown){
			console.log(jqXHR+","+textStatus+","+errorThrown)
		}
	})
}

</script>
</html>