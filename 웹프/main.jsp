<%@page contentType = "text/html; charset=UTF-8"%>
<%@page import = "java.io.*"%>
<%	int flag = 1;
	request.setCharacterEncoding("UTF-8");
	BufferedReader idReader = null;
	BufferedReader mov1Reader = null;
	BufferedReader mov2Reader = null;
	String userID = request.getParameter("userID");
	if(userID == null){
		userID = session.getAttribute("id").toString();
	}
	String mov1 = "";
	String mov2 = "";
	try{
		String idDirectory = application.getRealPath("WEB-INF");
		String movDirectory = application.getRealPath("MOVIE");
		String idFilePath = idDirectory + "/" + userID + ".txt";
		String mov1FilePath = movDirectory + "/movie1.txt";
		String mov2FilePath = movDirectory + "/movie2.txt";
		mov1Reader = new BufferedReader(new FileReader(mov1FilePath));
		mov2Reader = new BufferedReader(new FileReader(mov2FilePath));
		idReader = new BufferedReader(new FileReader(idFilePath));
	}
	catch(Exception e){
		%>
		<script>
			alert("존재하지 않는 아이디");
			window.location = 'login.jsp';
		</script>
		<%
		flag = 0;
	}
	finally{
		if(flag == 1){
			String passwd = idReader.readLine();
		String userPW = request.getParameter("userPW");
		if(userPW == null){
			userPW = session.getAttribute("passwd").toString();
		}
		if(!userPW.equals(passwd)){
			%>
			<script>
				alert("정확하지 않은 비밀번호");
				window.location = 'login.jsp';
			</script>
			<%
		}
		else{
			session.setAttribute("id", userID);
			session.setAttribute("passwd", passwd);
			String point = idReader.readLine();
			session.setAttribute("point", point);
			String movie1 = idReader.readLine();
			String movie2 = idReader.readLine();
			session.setAttribute("movie1", movie1);
			session.setAttribute("movie2", movie2);
			mov1 = mov1Reader.readLine();
			mov2 = mov2Reader.readLine();
			session.setAttribute("mov1", mov1);
			session.setAttribute("mov2", mov2);
			idReader.close();
			mov1Reader.close();
			mov2Reader.close();
		}
		}
		
	}
%>
<!DOCTYPE HTML>
<html>
<head>
	<link rel = "stylesheet" type = "text/css" href = "/WP/reservationStyle.css"/>
</head>
<body>
	<p><%=session.getAttribute("id")%>님이 로그인<form action = "logout.jsp" method = "POST"><input type = "submit" value = "로그아웃" id = "logout"></form></p><br>
	<p><%=session.getAttribute("id")%>님의 현재 포인트는 <%=session.getAttribute("point")%>원 입니다.</p>
	<form action = "buyPoint.jsp" method = "POST">
		<p>point : <input type = "text" name = "buyPoint"><input type = "submit" value = "포인트 구매"></form>
	<form action = "saveReservation.jsp" method = "POST">
		<table class = "table">
			<th colspan = "5" class = "table">
				A 영화관
			</th>
			<tr class = "table">
				<td class = "table">상영관</td>
				<td class = "table">영화</td>
				<td class = "table">상영시간</td>
				<td class = "table">잔여 좌석 수</td>
				<td class = "table">예매</td>
			</tr>
			<tr class = "table">
				<td class = "table">1관</td>
				<td class = "table">어벤져스</td>
				<td class = "table">15:00~17:00</td>
				<td class = "table"><%=session.getAttribute("mov1")%></td>
				<td class = "table"><input type = "text" name = "revMov1"></td>
			</tr>
			<tr class = "table">
				<td class = "table">2관</td>
				<td class = "table">어벤져스2</td>
				<td class = "table">17:00~19:00</td>
				<td class = "table"><%=session.getAttribute("mov2")%></td>
				<td class = "table"><input type = "text" name = "revMov2"></td>
			</tr>
		</table>
		<input type = "submit" value = "예매" class = "submit"></form>
	<br>
	<form action = "cancelReservation.jsp" method = "POST">
		<input type = "submit" value = "예매 확인" class = "submit"></form>
</body>
</html>