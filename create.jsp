<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Attendance</title>
    <style>
body {
    background-image: url('https://th.bing.com/th/id/OIP.Zzhl66kLn8kF2miVAiuKtwHaLH?w=640&h=960&rs=1&pid=ImgDetMain');
    background-size: cover; /* Cover the entire background */
    background-position: center; /* Center the background image */
    background-repeat: no-repeat; /* Prevent repeating of background image */
    background-color: #f2f2f2; /* Fallback background color */
    font-family: Arial, sans-serif;
    text-align: center;
    margin: 0;
    overflow: hidden; /* Hide any overflow content */
    height: 100vh; /* Ensure full viewport height */
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
    <h1>Mark attendance</h1>

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

                    String query = "SELECT * FROM attendance WHERE date = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setDate(1, java.sql.Date.valueOf(date));
                    ResultSet rsCheck = pstmt.executeQuery();
                    if (rsCheck.next()) {
                        out.print("<p>Attendance already marked for this date.</p>");
                    } else {
                        // Insert new entry if it doesn't already exist
                        query = "INSERT INTO attendance (date, r1, r2, r3, r4, r5) VALUES (?, ?, ?, ?, ?, ?)";
                        pstmt = con.prepareStatement(query);
                        pstmt.setDate(1, java.sql.Date.valueOf(date));
                        for (int i = 0; i < rollNumbers.length; i++) {
                            pstmt.setString(i + 2, request.getParameter(rollNumbers[i]));
                        }
                        pstmt.executeUpdate();

                        out.print("<p>Attendance marked successfully.</p>");
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

    <form action="create.jsp" method="post" onsubmit="return validateForm()">
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
        <button type="submit">Submit</button>
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
