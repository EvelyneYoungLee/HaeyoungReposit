<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<title>Home1</title>
</head>
<body>
	<input type="text" id="val">
	<script>
		$("#val").on("input", function() {
			$.ajax({
				url:"ajax.do",
			}).done(function(resp){
				console.log(resp[0]);
			});
		})
	</script>

</body>
</html>