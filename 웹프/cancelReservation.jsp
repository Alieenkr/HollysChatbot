<%@page contentType = "text/html; charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<link rel = "stylesheet" type = "text/css" href = "/WP/cancelStyle.css"/>
</head>
<body>
	<p><%=session.getAttribute("id")%>님이 로그인<form action = "logout.jsp" method = "POST"><input type = "submit" value = "로그아웃" id = "logout"></form></p>
	<form action = "cancel.jsp" method = "POST">
<%
	int movie1 = Integer.parseInt(session.getAttribute("movie1").toString());
	int movie2 = Integer.parseInt(session.getAttribute("movie2").toString());
	if(movie1 != 0){
		if(movie2 != 0){
			%>
			
			<table class = "table">
				<th colspan = "5" class = "table">
					예매 내역
				</th>
				<tr class = "table">
					<td class = "table">상영관</td>
					<td class = "table">영화</td>
					<td class = "table">상영시간</td>
					<td class = "table">예매 수</td>
					<td class = "table">취소</td>
				</tr>
				<tr class = "table">
					<td class = "table">1관</td>
					<td class = "table">어벤져스</td>
					<td class = "table">15:00~17:00</td>
					<td class = "table"><%=session.getAttribute("movie1")%></td>
					<td class = "table"><input type = "radio" name = "cancelMov1" value = "cancelMov1"></td>
				</tr>
				<tr class = "table">
					<td class = "table">2관</td>
					<td class = "table">어벤져스2</td>
					<td class = "table">17:00~19:00</td>
					<td class = "table"><%=session.getAttribute("movie2")%></td>
					<td class = "table"><input type = "radio" name = "cancelMov2" value = "cancelMov2"></td>
				</tr>
			</table>
			<%
		}
		else{
			%>
			
			<table class = "table">
				<th colspan = "5" class = "table">
					예매 내역
				</th>
				<tr class = "table">
					<td class = "table">상영관</td>
					<td class = "table">영화</td>
					<td class = "table">상영시간</td>
					<td class = "table">예매 수</td>
					<td class = "table">취소</td>
				</tr>
				<tr class = "table">
					<td class = "table">1관</td>
					<td class = "table">어벤져스</td>
					<td class = "table">15:00~17:00</td>
					<td class = "table"><%=session.getAttribute("movie1")%></td>
					<td class = "table"><input type = "radio" name = "cancelMov1" value = "cancelMov1"></td>
				</tr>
			</table>
			<%
		}
	}
	else if(movie2 != 0){
		%>
			
			<table class = "table">
				<th colspan = "5" class = "table">
					예매 내역
				</th>
				<tr class = "table">
					<td class = "table">상영관</td>
					<td class = "table">영화</td>
					<td class = "table">상영시간</td>
					<td class = "table">예매 수</td>
					<td class = "table">취소</td>
				</tr>
				<tr class = "table">
					<td class = "table">2관</td>
					<td class = "table">어벤져스2</td>
					<td class = "table">17:00~19:00</td>
					<td class = "table"><%=session.getAttribute("movie2")%></td>
					<td class = "table"><input type = "radio" name = "cancelMov2" value = "cancelMov2"></td>
				</tr>
			</table>
			<%
	}
	else{
		%>
		<script>
			alert("예매 내역이 없습니다.");
			window.location = 'main.jsp';
		</script>
		<%
	}

%>
	<input type = "submit" value = "예매 취소"></form>
	<input type = "button" onclick = "toReservation()" value = "예매하러 가기">
	<script>
		function toReservation(){
			window.location = 'main.jsp';
		}
	</script>
</body>
</html>