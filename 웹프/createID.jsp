<%@page contentType = "text/html; charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset = "UTF-8">
	</head>
	<body>
		<form action = "create.jsp" method = "POST">
			<p>ID : <input type = "text" name = "userID" required></p>
			<p>PW : <input type = "password" name = "userPW" required></p>
			<input type = "submit" value = "회원가입" class = "submitButton">
		</form>
	</body>
</html>