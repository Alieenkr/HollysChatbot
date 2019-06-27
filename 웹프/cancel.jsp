<%@page contentType = "text/html; charset=UTF-8"%>
<%@page import = "java.io.*"%>
<%	request.setCharacterEncoding("UTF-8");
	int flag = 1;
	int point = Integer.parseInt(session.getAttribute("point").toString());
	int movie1 = Integer.parseInt(session.getAttribute("movie1").toString());
	int movie2 = Integer.parseInt(session.getAttribute("movie2").toString());
	int mov1 = Integer.parseInt(session.getAttribute("mov1").toString());
	int mov2 = Integer.parseInt(session.getAttribute("mov2").toString());
	Object cancelMov1 = request.getParameter("cancelMov1");
	Object cancelMov2 = request.getParameter("cancelMov2");
	if(movie1 != 0){
		if(movie2 != 0){
			if(cancelMov1 == null){
				if(cancelMov2 == null){
					%>
					<script>
						alert("취소할 표를 선택하시오.");
						window.location = 'cancelReservation.jsp';
					</script>
					<%
				flag = 0;
				}
				else if(cancelMov2.equals("cancelMov2")){
					point += movie2 * 5000;
					mov2 += movie2;
					movie2 = 0;
					session.setAttribute("movie2", movie2);
					session.setAttribute("mov2", mov2);
				}
			}
			else if(cancelMov1.equals("cancelMov1")){
				point += movie1 * 5000;
				mov1 += movie1;
				movie1 = 0;
				session.setAttribute("movie1", movie1);
				session.setAttribute("mov1", mov1);
			}
		}
		else{
			if(cancelMov1 == null){
				%>
			<script>
				alert("취소할 표를 선택하시오.");
				window.location = 'cancelReservation.jsp';
			</script>
			<%
			flag = 0;
			}
			else if(cancelMov1.equals("cancelMov1")){
				point += movie1 * 5000;
				mov1 += movie1;
				movie1 = 0;
				session.setAttribute("movie1", movie1);
				session.setAttribute("mov1", mov1);
			}
		}
	}
	else if(movie2 != 0){
		if(cancelMov2 == null){
			%>
			<script>
				alert("취소할 표를 선택하시오.");
				window.location = 'cancelReservation.jsp';
			</script>
			<%
			flag = 0;
		}
		else if(cancelMov2.equals("cancelMov2")){
			point += movie2 * 5000;
			mov2 += movie2;
			movie2 = 0;
			session.setAttribute("movie2", movie2);
			session.setAttribute("mov2", mov2);
		}
	}
	if(flag == 1){
		PrintWriter mov1Writer = null;
		PrintWriter mov2Writer = null;
		PrintWriter idWriter = null;
		String id = session.getAttribute("id").toString();
		String passwd = session.getAttribute("passwd").toString();
		try{
			String directory = application.getRealPath("MOVIE");
			String idDirectory = application.getRealPath("WEB-INF");
			String mov1FilePath = directory + "/movie1.txt";
			String mov2FilePath = directory + "/movie2.txt";
			String idFilePath = idDirectory + "/" + id + ".txt";
			idWriter = new PrintWriter(idFilePath);
			mov1Writer = new PrintWriter(mov1FilePath);
			mov1Writer.print(mov1);
			mov2Writer = new PrintWriter(mov2FilePath);
			mov2Writer.print(mov2);
			idWriter.println(passwd);
			idWriter.println(point);
			idWriter.println(movie1);
			idWriter.println(movie2);
		}
		catch(Exception e){
		
		}
		finally{
			idWriter.close();
			mov1Writer.close();
			mov2Writer.close();
			%>
				<script>
					alert("예매 취소 성공");
					window.location = 'main.jsp';
				</script>
			<%
		}
	}
		
%>
