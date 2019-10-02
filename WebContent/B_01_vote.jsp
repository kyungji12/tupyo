<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>투표하기</title>
		<style>
			.mytable { 
				border-collapse:collapse;
				}  
			.mytable th, .mytable td { 
				border:1px solid black; 
				padding: 10;
				}
		</style>
	</head>
	
	<body>
		<h3 align=center>-*-*-*-*-*-*-　　투표　　-*-*-*-*-*-*-</h3>
		<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery("select * from hubotable;");
		%>	
		<form method=post action='B_02_result.jsp' name=vote >
		<div style="text-align:center;">
			<select name=hubo required>	
				<option value=''>후보 선택</option>	
		<%
         while(rset.next()){
            out.println("<option value='"+rset.getInt(1)+"'>"+rset.getInt(1)+"번 "+rset.getString(2)+"</option>");
         }
		%>   
			</select>
			
			<select name=age required>
				<option value=''>투표자 연령대</option>
				<option value='10'>10대</option>
				<option value='20'>20대</option>
				<option value='30'>30대</option>
				<option value='40'>40대</option>
				<option value='50'>50대</option>
				<option value='60'>60대</option>
				<option value='70'>70대</option>
				<option value='80'>80대</option>
				<option value='90'>90대</option>
			</select>
			
			<input type=submit value=투표하기>
		
		</div>
		</form>
			
		<%	
			
			
			rset.close();
			stmt.close();
			conn.close();
		}catch (Exception e){
			out.println("오류가 발생했습니다.");
		}
		%>
	</body>
</html>