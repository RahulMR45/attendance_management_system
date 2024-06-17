<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Attendance</title>
    <style>
       body {
    background-image: url('https://th.bing.com/th/id/OIP.Zzhl66kLn8kF2miVAiuKtwHaLH?w=640&h=960&rs=1&pid=ImgDetMain');
    background-size: cover;
    background-position: center; 
    background-repeat: no-repeat; 
    background-color: #f2f2f2; 
    font-family: Arial, sans-serif;
    text-align: center;
    margin: 0;
    overflow: hidden; 
    height: 100vh; 
}

        .message {
            margin: 20px auto;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            width: 50%;
        }
    </style>
</head>
<body>
    <h1>Update Attendance</h1>

    <div class="message">
        <%
            String url = "jdbc:mysql://localhost:3306/attendance";
            String user = "root";
            String password = "6362";

            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, user, password);

                if (request.getMethod().equals("POST")) {
                    String date = request.getParameter("date");
                    String[] rollNumbers = {"r1", "r2", "r3", "r4", "r5"};

                    String query = "UPDATE attendance SET r1=?, r2=?, r3=?, r4=?, r5=? WHERE date=?";
                    pstmt = con.prepareStatement(query);
                    for (int i = 0; i < rollNumbers.length; i++) {
                        pstmt.setString(i + 1, request.getParameter(rollNumbers[i]));
                    }
                    pstmt.setDate(6, java.sql.Date.valueOf(date));
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.print("<p>Attendance updated successfully.</p>");
                    } else {
                        out.print("<p>No attendance found for the specified date.</p>");
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.print("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    out.print("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

    <form action="update.jsp" method="post" onsubmit="return validateForm()">
        <label for="date">Date:</label>
        <input type="date" name="date" id="date" required><br>
        <label for="r1">Roll No. 1:</label>
        <input type="text" name="r1" id="r1" pattern="[pa]" title='Please enter "p" or "a".'><br>
        <label for="r2">Roll No. 2:</label>
        <input type="text" name="r2" id="r2" pattern="[pa]" title='Please enter "p" or "a".'><br>
        <label for="r3">Roll No. 3:</label>
        <input type="text" name="r3" id="r3" pattern="[pa]" title='Please enter "p" or "a".'><br>
        <label for="r4">Roll No. 4:</label>
        <input type="text" name="r4" id="r4" pattern="[pa]" title='Please enter "p" or "a".'><br>
        <label for="r5">Roll No. 5:</label>
        <input type="text" name="r5" id="r5" pattern="[pa]" title='Please enter "p" or "a".'><br>
        <button type="submit">Update</button>
    </form>
	<a href="Index.jsp" class="button">Back to Home</a>
    <script>
        function validateForm() {
            var rollInputs = ['r1', 'r2', 'r3', 'r4', 'r5'];
            var validInput = /^[pa]*$/; 

            for (var i = 0; i < rollInputs.length; i++) {
                var input = document.getElementById(rollInputs[i]).value.trim().toLowerCase();
                if (input !== '' && !validInput.test(input)) {
                    alert('Invalid input for Roll Number ' + (i + 1) + '. Only accept "p" or "a".');
                    return false; 
                }
            }

            return true;
        }
    </script>
</body>
</html>
