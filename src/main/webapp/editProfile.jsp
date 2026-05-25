<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="model.UserBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>

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

.edit-wrapper{
    width:700px;
    margin:60px auto;
}

.edit-card{
    border:2px solid var(--light-gray);
    border-radius:24px;
    padding:40px;
    background:var(--white);
}

.edit-card h1{
    margin-top:0;
    margin-bottom:35px;
    font-size:42px;
}

.profile-preview{
    text-align:center;
    margin-bottom:35px;
}

.profile-preview img{
    width:140px;
    height:140px;
    border-radius:50%;
    object-fit:cover;
    border:4px solid var(--gray);
}

.form-group{
    margin-bottom:24px;
}

.form-group label{
    display:block;
    margin-bottom:10px;
    font-size:17px;
    font-weight:700;
}

.form-group i{
    margin-right:10px;
}

.form-group input{
    width:100%;
    padding:16px;
    border:2px solid var(--light-gray);
    border-radius:14px;
    box-sizing:border-box;
    outline:none;
    font-size:15px;
}

.form-group input:focus{
    border-color:var(--gray);
}

.save-btn{
    width:100%;
    padding:17px;
    border:none;
    border-radius:14px;
    background:var(--dark);
    color:var(--white);
    font-size:16px;
    font-weight:700;
    cursor:pointer;
    transition:0.3s;
}

.save-btn:hover{
    background:var(--gray);
    color:var(--dark);
}

.msg{
    text-align:center;
    margin-bottom:20px;
    font-weight:700;
    color:var(--dark);
}

</style>

</head>

<body>

<%@ include file="header.jsp" %>

<%
UserBean editUser = (UserBean) session.getAttribute("user");

if(editUser == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<div class="edit-wrapper">

    <div class="edit-card">

        <h1>Edit Profile</h1>

        <p class="msg">${msg}</p>

        <div class="profile-preview">

            <img
            src="<%= request.getContextPath() %>/uploads/<%= editUser.getProfile_img() != null ? editUser.getProfile_img() : "default.png" %>">

        </div>

        <form action="EditProfileServlet"
              method="post"
              enctype="multipart/form-data">

            <input type="hidden"
                   name="uid"
                   value="<%= editUser.getId() %>">

            <div class="form-group">

                <label>
                    <i class="fa fa-user"></i>
                    Username
                </label>

                <input type="text"
                       name="uname"
                       value="<%= editUser.getName() %>">

            </div>

            <div class="form-group">

                <label>
                    <i class="fa fa-envelope"></i>
                    Email
                </label>

                <input type="email"
                       name="uemail"
                       value="<%= editUser.getEmail() %>">

            </div>

            <div class="form-group">

                <label>
                    <i class="fa fa-lock"></i>
                    New Password
                </label>

                <input type="password"
                       name="upass"
                       placeholder="Enter new password">

            </div>

            <div class="form-group">

                <label>
                    <i class="fa fa-image"></i>
                    Change Profile Image
                </label>

                <input type="file"
                       name="uimg"
                       accept="image/*">

            </div>

            <input type="submit"
                   value="Save Changes"
                   class="save-btn">

        </form>

    </div>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>