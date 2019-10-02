<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			.mytable { 
				border-collapse:collapse;
				}  
			.mytable th, .mytable td { 
				border:1px solid black; 
				padding: 10;
				}
		</style>
		<%
		try{
		//DB연결
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
		Statement stmt = conn.createStatement();	
		
		//값 읽어오기
		ResultSet rset = stmt.executeQuery("select * from hubotable;");
		
		%>	
	</head>
	<body>
		<h3 align=center>-*-*-*-*-*-*-　　후보자 명단　　-*-*-*-*-*-*-</h3>
		<table class=mytable align=center>
			<tr>
				<td bgcolor=#9999ff><p align=center>기호 번호</p></td>
				<td bgcolor=#9999ff><p align=center>후보자명</p></td>
			</tr>
	
		<%
		while(rset.next()){
			out.println("<tr>");
			out.println("<td><p align=center>기호 "+rset.getInt(1)+"번</p></td>");
			out.println("<td><p align=center>"+rset.getString(2)+"</p></td>");
			out.println("</tr>");
		}
			rset.close();
			stmt.close();
			conn.close();
		}catch(Exception e){
			out.println("<p align=center>등록된 후보가 없습니다.</p>");
		}
		%>
		</table>
	</body>
</html>