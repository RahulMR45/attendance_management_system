<!DOCTYPE html>
<html>
<head>
    <title>Attendance Management System</title>
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
        h1 {
            color: #333;
        }
        .button-container {
            margin-bottom: 20px;
        }
        button {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Attendance Management System</h1>

    <div class="button-container">
        <button onclick="window.location.href='create.jsp'">Mark Attendance</button><br/>
        <button onclick="window.location.href='read.jsp'">Read Attendance</button><br/>
        <button onclick="window.location.href='update.jsp'">Update Attendance</button><br/>
        <button onclick="window.location.href='delete.jsp'">Delete Attendance</button><br/>
    </div>
</body>
</html>
