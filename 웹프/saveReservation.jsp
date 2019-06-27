<%@page contentType = "text/html; charset=UTF-8"%>
<%@page import = "java.io.*"%>
<%	request.setCharacterEncoding("UTF-8");
	int flag = 1;
	String mov1 = request.getParameter("revMov1");
	String mov2 = request.getParameter("revMov2");
	int point = Integer.parseInt(session.getAttribute("point").toString());
	if(mov1.equals("") && mov2.equals("")){
		%>
		<script>
			alert("예매 수를 입력하시오.");
			window.location = 'main.jsp';
		</script>
		<%
		flag = 0;
	}
	if(mov1.equals("")){
		mov1 = "0";
	}
	if(mov2.equals("")){
		mov2 = "0";
	}
	int numberOfMov1 = Integer.parseInt(session.getAttribute("mov1").toString());
	int numberOfMov2 = Integer.parseInt(session.getAttribute("mov2").toString());
	int revMov1 = Integer.parseInt(mov1);
	int revMov2 = Integer.parseInt(mov2);
	String id = session.getAttribute("id").toString();
	String passwd = session.getAttribute("passwd").toString();
	if(revMov1 == 0 && revMov2 == 0 && flag == 1){
		%>
		<script>
			alert("예매 수를 입력하시오.");
			window.location = 'main.jsp';
		</script>
		<%
		flag = 0;
	}
	if(numberOfMov1 < revMov1 || numberOfMov2 < revMov2 && flag == 1){
		%>
		<script>
			alert("좌석이 부족합니다.");
			window.location = 'main.jsp';
		</script>
		<%
		flag = 0;
	}
	int totalPrice = revMov1 * 5000 + revMov2 * 5000;
	if(totalPrice > point && flag == 1){
		%>
		<script>
			alert("포인트가 부족합니다.");
			window.location = 'main.jsp';
		</script>
		<%
		flag = 0;
	}
	if(flag == 1){
		point = point - totalPrice;
		int totalNumOfMov = revMov1 + revMov2;
		numberOfMov1 = numberOfMov1 - revMov1;
		numberOfMov2 = numberOfMov2 - revMov2;
		int currentMov1 = Integer.parseInt(session.getAttribute("movie1").toString()) + revMov1;
		session.setAttribute("movie1", currentMov1);
		int currentMov2 = Integer.parseInt(session.getAttribute("movie2").toString()) + revMov2;
		session.setAttribute("movie2", currentMov2);
		PrintWriter mov1Writer = null;
		PrintWriter mov2Writer = null;
		PrintWriter idWriter = null;
		try{
			String directory = application.getRealPath("MOVIE");
			String idDirectory = application.getRealPath("WEB-INF");
			String mov1FilePath = directory + "/movie1.txt";
			String mov2FilePath = directory + "/movie2.txt";
			String idFilePath = idDirectory + "/" + id + ".txt";
			idWriter = new PrintWriter(idFilePath);
			mov1Writer = new PrintWriter(mov1FilePath);
			mov1Writer.print(numberOfMov1);
			mov2Writer = new PrintWriter(mov2FilePath);
			mov2Writer.print(numberOfMov2);
			idWriter.println(passwd);
			idWriter.println(point);
			idWriter.println(currentMov1);
			idWriter.println(currentMov2);
		}
		catch(Exception e){
		
		}
		finally{
			idWriter.close();
			mov1Writer.close();
			mov2Writer.close();
			%>
				<script>
					alert(<%=totalNumOfMov%> + "장 예매 성공");
					window.location = 'main.jsp';
				</script>
			<%
		}
	}
	
	
%>
