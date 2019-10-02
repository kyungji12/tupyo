<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>투표 결과창</title>
		<style>
		#container{
			margin-left: auto;
			margin-right: auto;
			
		}
		</style>
	</head>
	<body id="container">
		<h1>투표</h1>
		<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
			Statement stmt = conn.createStatement();
			
			int huboID = Integer.parseInt(request.getParameter("hubo"));		
			int tupyoAge = Integer.parseInt(request.getParameter("age"));

			stmt.execute("insert into tupyotable (id, age) values("+huboID+","+tupyoAge+");");
			
			out.println("기호"+huboID+"번에 투표 완료.");
			
			out.println("<form align=center method=post action='intro.jsp'>");
			out.println("<tr>");
			out.println("<td align=center><input type=submit value=홈으로></td>");
			out.println("</tr></form>");	
			
			out.println("<form align=center method=post action='C_01_perVote.jsp'>");
			out.println("<tr>");
			out.println("<td align=center><input type=submit value=결과보기></td>");
			out.println("</tr></form>");
			
			stmt.close();
			conn.close();
		}catch(Exception e){
			out.println("정확히 선택해서 투표해주세요~");
		}
		%>
	</body>
</html>