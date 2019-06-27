<%@page contentType = "text/html; charset=UTF-8"%>
<%@page import = "java.io.*"%>
<%	int flag = 1;
	request.setCharacterEncoding("UTF-8");
	String id = session.getAttribute("id").toString();
	int currentPoint = Integer.parseInt(session.getAttribute("point").toString());
	String stringPoint = request.getParameter("buyPoint");
	if(stringPoint.equals("")){
		%>
		<script>
			alert("구매할 포인트를 입력하시오.");
			window.location = 'main.jsp';
		</script>
	<%
		flag = 0;
	}
	if(flag == 1){
		int buyPoint = Integer.parseInt(stringPoint);
	currentPoint += buyPoint;
	String point = Integer.toString(currentPoint);
	session.setAttribute("point", point);
	PrintWriter writer = null;
	String passwd = session.getAttribute("passwd").toString();
	String movie1 = session.getAttribute("movie1").toString();
	String movie2 = session.getAttribute("movie2").toString();
	try{
		String directory = application.getRealPath("WEB-INF");
		File dir = new File(directory);
		String filePath = directory + "/" + id + ".txt";
		writer = new PrintWriter(filePath);
		writer.println(passwd);
		writer.println(point);
		writer.println(movie1);
		writer.println(movie2);
	}
	catch(Exception e){
		
	}
	finally{
		writer.close();
		%>
		<script>
			alert("포인트 구매 성공");
			window.location = 'main.jsp';
		</script>
		<%
		
	}
	}
	
%>