<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="model.UserBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>

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

/* Wrapper */
.profile-wrapper{
    width:700px;
    margin:60px auto;
}

/* Username */
.profile-wrapper h1{
    font-size:52px;
    margin-bottom:35px;
    color:var(--dark);
}

/* Profile Card */
.profile-section{
    background:var(--white);

    border:2px solid var(--light-gray);

    border-radius:22px;

    padding:35px;

    display:flex;
    align-items:flex-start;

    gap:35px;
}

/* Image */
.profile-image{
    width:140px;
    height:140px;

    border-radius:18px;

    object-fit:cover;

    border:3px solid var(--gray);
}

/* Right Side */
.profile-details{
    flex:1;
}

/* Profile Title */
.profile-details h3{
    margin-top:0;
    margin-bottom:30px;

    font-size:28px;

    color:var(--dark);
}

/* Links */
.profile-details a{
    display:flex;
    align-items:center;

    text-decoration:none;

    color:var(--dark);

    font-size:18px;
    font-weight:600;

    padding:16px 18px;

    border:2px solid var(--light-gray);

    border-radius:14px;

    margin-bottom:18px;

    transition:0.3s;
}

/* Hover */
.profile-details a:hover{
    background:var(--light-gray);
}

/* Icons */
.profile-details i{
    width:25px;
    margin-right:14px;
    font-size:18px;
}

</style>

</head>

<body>

<%@ include file="header.jsp" %>

<%
UserBean profileUser = (UserBean) session.getAttribute("user");

if(profileUser == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<div class="profile-wrapper">

    <h1>
        <%= profileUser.getName() %>
    </h1>

    <div class="profile-section">

        <!-- Profile Image -->
        <img
        src="<%= request.getContextPath() %>/uploads/<%= profileUser.getProfile_img() != null ? profileUser.getProfile_img() : "default.png" %>"
        alt="Profile Image"
        class="profile-image">

        <!-- Profile Links -->
        <div class="profile-details">

            <h3>

                <i class="fa fa-user"></i>

                Profile

            </h3>

            <a href="editProfile.jsp">

                <i class="fa fa-pen-to-square"></i>

                Edit Profile

            </a>

            <a href="${pageContext.request.contextPath}/MyCheatSheetsServlet">

                <i class="fa fa-book"></i>

                My CheatSheets

            </a>

            <a href="LogoutServlet">

                <i class="fa fa-right-from-bracket"></i>

                Logout

            </a>

        </div>

    </div>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>