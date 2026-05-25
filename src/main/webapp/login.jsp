<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

:root{
    --white:#FFFFFF;
    --light-gray:#D4D4D4;
    --gray:#B3B3B3;
    --dark:#2B2B2B;
}

/* Body */
body{
    margin:0;
    background:var(--white);
    font-family:'Segoe UI',sans-serif;
    color:var(--dark);
}

/* Login Box */
.login-container{
    width:500px;

    margin:70px auto;

    background:var(--white);

    border:2px solid var(--light-gray);

    border-radius:22px;

    padding:40px;

    box-sizing:border-box;
}

/* Title */
.login-container h2{
    margin-top:0;
    margin-bottom:30px;

    text-align:center;

    font-size:34px;

    color:var(--dark);
}

/* Message */
.msg{
    text-align:center;

    color:var(--dark);

    font-weight:700;

    margin-bottom:20px;
}

/* Form Group */
.form-group{
    margin-bottom:24px;
}

/* Label */
.form-group label{
    display:block;

    margin-bottom:10px;

    font-weight:700;

    color:var(--dark);
}

/* Icon */
.form-group i{
    margin-right:10px;
}

/* Input */
input[type="email"],
input[type="password"]{

    width:100%;

    padding:15px;

    border:2px solid var(--light-gray);

    border-radius:14px;

    outline:none;

    box-sizing:border-box;

    font-size:15px;
}

/* Focus */
input:focus{
    border-color:var(--gray);
}

/* Button */
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

    transition:0.3s;
}

/* Hover */
.submit-btn:hover{
    background:var(--gray);

    color:var(--dark);
}

</style>

</head>

<body>

<%@ include file="header.jsp" %>

<div class="login-container">

    <h2>Login Information</h2>

    <p class="msg">
        ${msg}
    </p>

    <form action="LoginServlet"
          method="post">

        <div class="form-group">

            <label>

                <i class="fa fa-envelope"></i>

                Your Email Address

            </label>

            <input type="email"
                   name="uemail">

        </div>

        <div class="form-group">

            <label>

                <i class="fa fa-lock"></i>

                Your Password

            </label>

            <input type="password"
                   name="upass">

        </div>

        <input type="submit"
               value="Login to DevNote"
               class="submit-btn">

    </form>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>