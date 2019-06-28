<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<title>Web Chat</title>
<style>
div {
	border: 1px solid black;
	box-xizing: border-box;
}

.container {
	width: 250px;
	height: 350px;
	margin: 0 auto;
}

#contents {
	width: 100%;
	height: 90%;
	overflow-y: auto;
}

.control {
	width: 100%;
	height: 10%;
}

.control>input[type=text] {
	height: 100%;
	width: 80%;
	margin: 0px;
	box-sizing: border-box;
}

.control>input[type=button] {
	height: 100%;
	width: 17%;
	margin: 0px;
	box-sizing: border-box;
}
</style>
</head>
<body>

	<div class="container">
		<div id="contents"></div>
		<div class="control">
			<input type="text" id="input"> <input type="button" id="send"
				value="전송">
		</div>
	</div>

	<script>
		var socket = new WebSocket("ws://192.168.60.7/chat");
		var isScrollUp = false;
		var chat = document.getElementById("contents");
		
		console.log(chat);
		socket.onmessage = function(evt) {
			$("#contents").append(evt.data + '<br>');
			if (!isScrollUp) {
				$("#contents").animate({
					scrollTop : chat.scrollHeight - chat.clientHeight
				}, 100);
			}
		}

		function func() {
			var msg = $("#input").val();
			$("#input").val("");
			socket.send(msg);
		}

		$("#send").on("click", func);

		$("#input").keypress(function(e) {
			if (e.keyCode == 13) {
				func()
			}
		})
	</script>

</body>
</html>