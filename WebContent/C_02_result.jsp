<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
	<head>
		<meta charset="UTF-8">
		<title>연령별 득표</title>
		
		<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
			Statement stmt = conn.createStatement();
			
			int id = Integer.parseInt(request.getParameter("huboid"));
			
			ResultSet rset = stmt.executeQuery("SELECT a.id, b.NAME, a.age, a.counting "+
			         "FROM (SELECT id, age, COUNT(age)AS counting FROM tupyotable WHERE id = "+id+" GROUP BY age) AS a "+
			         "JOIN (SELECT id, NAME FROM hubotable) AS b "+
			         "ON a.id = b.id;");
			
		%>
	 	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   		<script type="text/javascript">
		google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(drawChart);

	      function drawChart() {
	
	        var data = google.visualization.arrayToDataTable([
	          ['기호','link','득표수'],          
	      <%  
	          int count=0;
	          while(rset.next()){
	            count++;
	            out.println("['"+rset.getInt(3)+"대 ', '',"+rset.getInt(4)+"]");
	            if(rset.isLast())break;
	            out.print(",");  
	         }
	      %> 
	
	          
	        ]);  
	      //퍼센트값 보이게하는 부분    
	      var groupData = google.visualization.data.group(
	    		    data,
	    		    [{column: 0, modifier: function () {return 'total'}, type:'string'}],
	    		    [{column: 2, aggregation: google.visualization.data.sum, type: 'number'}]
	    		  );

	    		  var formatPercent = new google.visualization.NumberFormat({
	    		    pattern: '#,##0.0%'
	    		  });

	    		  var formatShort = new google.visualization.NumberFormat({
	    		    pattern: 'short'
	    		  });
	
	        var view = new google.visualization.DataView(data);
	        	view.setColumns([0, 2,{
        		calc: function (dt, row) {
     				 //var amount =  formatShort.formatValue(dt.getValue(row, 2));
     				 var percent = formatPercent.formatValue(dt.getValue(row, 2) / groupData.getValue(0, 1));
 				     return ' (' + percent + ')';
   					 },
				    type: 'string',
				    role: 'annotation'
				  }]);	
	        	

	        var options = {'title':'연령 별 득표','width':800,'height':600};

	        var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
	        	chart.draw(view, options);
	
	        var selectHandler = function(e) {
		         window.location = data.getValue(chart.getSelection()[0]['row'], 1 );
		        }
	
	         google.visualization.events.addListener(chart, 'select', selectHandler);
	      	}
	      
	    </script>
	  </head>

  <body>
  	<h3 align=center>-*-*-*-*-*-*-　　성향분석　　-*-*-*-*-*-*-</h3>
    <div align=center id="chart_div">로딩중...</div>
    
    <%
	    out.println("<form align=center method=post action='C_01_perVote.jsp'>");
		out.println("<tr>");
		out.println("<td align=center><input type=submit value=뒤로가기></td>");
		out.println("</tr></form>");
    	
		out.println("<form align=center method=post action='intro.jsp'>");
		out.println("<tr>");
		out.println("<td align=center><input type=submit value=홈으로></td>");
		out.println("</tr></form>");
		rset.close();
		stmt.close();
		conn.close();
		}catch (Exception e){
			out.println("오류가 발생하였습니다.");
		}
	%>
  </body>
</html>