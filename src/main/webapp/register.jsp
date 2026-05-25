<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{
    --white:#FFFFFF;
    --light-gray:#D4D4D4;
    --gray:#B3B3B3;
    --dark:#2B2B2B;
}

body{
    margin:0;
    background:var(--white);
    font-family:'Segoe UI',sans-serif;
    color:var(--dark);
}

.form-container{
    width:600px;
    margin:60px auto;
    background:var(--white);
    border:2px solid var(--light-gray);
    border-radius:22px;
    padding:40px;
    box-sizing:border-box;
}

.form-container h2{
    margin-top:0;
    margin-bottom:30px;
    text-align:center;
    font-size:34px;
    color:var(--dark);
}

.form-group{
    margin-bottom:22px;
}

.form-group label{
    display:block;
    margin-bottom:10px;
    font-weight:700;
    color:var(--dark);
}

.form-group i{
    margin-right:10px;
    color:var(--dark);
}

input[type="text"],
input[type="email"],
input[type="password"],
input[type="file"]{
    width:100%;
    padding:15px;
    border:2px solid var(--light-gray);
    border-radius:14px;
    box-sizing:border-box;
    outline:none;
    font-size:15px;
}

input:focus{
    border-color:var(--gray);
}

.msg{
    text-align:center;
    color:var(--dark);
    font-weight:700;
}

.submit-btn{
    width:100%;
    background:var(--dark);
    color:var(--white);
    border:none;
    padding:16px;
    border-radius:14px;
    cursor:pointer;
    font-size:16px;
    font-weight:700;
}

.submit-btn:hover{
    background:var(--gray);
    color:var(--dark);
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="form-container">

    <h2>Registration Information</h2>

    <p class="msg">${msg}</p>

    <form action="RegisterServlet" method="post" enctype="multipart/form-data">

        <div class="form-group">
            <label><i class="fa fa-user"></i>Your Username</label>
            <input type="text" name="uname">
        </div>

        <div class="form-group">
            <label><i class="fa fa-envelope"></i>Your Email Address</label>
            <input type="email" name="uemail">
        </div>

        <div class="form-group">
            <label><i class="fa fa-lock"></i>Your Password</label>
            <input type="password" name="upass">
        </div>

        <div class="form-group">
            <label><i class="fa fa-lock"></i>Confirm Password</label>
            <input type="password" name="ucpass">
        </div>

        <div class="form-group">
            <label><i class="fa fa-image"></i>Profile Image</label>
            <input type="file" name="uimg" accept="image/*">
        </div>

        <input type="submit"
               value="Finished? Click to Complete Registration"
               class="submit-btn">

    </form>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>