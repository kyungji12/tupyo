<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>등록</title>
		<%
		try{
		//DB연결
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
		Statement stmt = conn.createStatement();
		
		String name = request.getParameter("huboName");
		String hName = new String(name.getBytes("8859_1"),"UTF-8");
		
		stmt.execute("insert into hubotable (id, name) values("+request.getParameter("huboID")+",'"+hName+"');");
		
		out.println("<a text-align=center>기호"+request.getParameter("huboID")+"번 "+hName+"님 후보 등록 완료.</a>");
		
		out.println("<form align=center method=post action='A_register.jsp'>");
		out.println("<tr>");
		out.println("<td align=center><input type=submit value=뒤로가기></td>");
		out.println("</tr></form>");
		
		out.println("<form align=center method=post action='intro.jsp'>");
		out.println("<tr>");
		out.println("<td align=center><input type=submit value=홈으로></td>");
		out.println("</tr></form>");
		
		//stmt.close();
		conn.close();
	}catch(Exception e){
		out.println("<p align=center>후보 등록에 실패하였습니다.</p>"+e);
	}
		%>	
	</head>
	<body>
	</body>
</html>