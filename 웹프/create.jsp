<%@page contentType = "text/html; charset=UTF-8"%>
<%@page import = "java.io.*"%>
<!DOCTYPE HTML>
<html>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	try{
		BufferedReader reader = null;
		String directory = application.getRealPath("WEB-INF");
		File dir = new File(directory);
		String userID = request.getParameter("userID");
		String filePath = directory + "/" + userID + ".txt";
		FileReader fileReader = new FileReader(filePath);
		
			%>
			<script>
				alert("존재하는 아이디");
				window.location = 'login.jsp';
			</script>
		<%
	}
	catch(Exception e){
		String userID = request.getParameter("userID");
		String userPW = request.getParameter("userPW");
		String points = "0";
		String movie1 = "0";
		String movie2 = "0";
		PrintWriter writer = null;
		try{
			String directory = application.getRealPath("WEB-INF");
			File dir = new File(directory);
			String filePath = directory + "/" + userID + ".txt";
			if(!dir.exists()){
				dir.mkdir();
			}
			writer = new PrintWriter(filePath);
			writer.println(userPW);
			writer.println(points);
			writer.println(movie1);
			writer.println(movie2);
		%>
			<script>
				alert("아이디 생성 성공");
			</script>
		<%
		}
		catch( Exception ex ){}
		finally{
			try{
				writer.close();
				%>
				<script>
					window.location = 'login.jsp';
				</script>
				<%
			}
			catch( Exception exe){
			
			}
		}
	}
	
%>
</body>
</html>