<%@ page import="model.UserBean" %>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

:root{
    --white:#FFFFFF;
    --light-gray:#D4D4D4;
    --gray:#B3B3B3;
    --dark:#2B2B2B;
}

/* Reset */
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:var(--white);
}

/* Topbar */
.topbar{
    background:var(--white);

    padding:18px 35px;

    display:flex;
    align-items:center;

    border-bottom:1px solid var(--light-gray);
}

/* Logo */
.logo{
    font-size:42px;
    font-weight:800;

    text-decoration:none;

    color:var(--dark);

    letter-spacing:-1px;
}

.logo span{
    color:var(--gray);
}

/* Search */
.search-bar{
    margin-left:auto;
    margin-right:30px;
}

.search-bar form{
    margin:0;
}

.search-bar input{
    width:340px;

    padding:14px 20px;

    border-radius:35px;

    border:2px solid var(--light-gray);

    outline:none;

    font-size:15px;

    background:var(--white);

    color:var(--dark);
}

.search-bar input:focus{
    border-color:var(--gray);
}

/* Social */
.social-icons i{
    color:var(--dark);

    margin:0 10px;

    font-size:22px;

    cursor:pointer;

    transition:0.3s;
}

.social-icons i:hover{
    color:var(--gray);
}

/* Navbar */
.navbar{
    background:var(--light-gray);

    padding:18px 35px;

    display:flex;
    align-items:center;
}

/* Links */
.navbar a{
    text-decoration:none;

    color:var(--dark);

    margin-right:35px;

    font-size:18px;
    font-weight:600;

    transition:0.3s;

    position:relative;
}

.navbar a:hover{
    color:var(--gray);
}

/* Hover Line */
.navbar a::after{
    content:'';

    position:absolute;

    left:0;
    bottom:-12px;

    width:0;
    height:3px;

    background:var(--dark);

    transition:0.3s;
}

.navbar a:hover::after{
    width:100%;
}

/* Auth */
.auth-buttons{
    margin-left:auto;

    display:flex;
    align-items:center;
}

/* Buttons */
.auth-buttons button{
    padding:12px 24px;

    border-radius:14px;

    border:2px solid var(--dark);

    background:var(--white);

    color:var(--dark);

    font-size:16px;
    font-weight:600;

    cursor:pointer;

    transition:0.3s;

    margin-left:14px;
}

/* Register Button */
.auth-buttons button:last-child{
    background:var(--dark);
    color:var(--white);
}

.auth-buttons button:hover{
    transform:translateY(-2px);
}

/* Profile */
.profile-link{
    display:flex;
    align-items:center;

    text-decoration:none;

    color:var(--dark);

    font-size:16px;
    font-weight:700;
}

.profile-link img{
    width:42px;
    height:42px;

    border-radius:50%;

    object-fit:cover;

    margin-right:12px;

    border:2px solid var(--gray);
}

</style>

<%
UserBean user = (UserBean) session.getAttribute("user");
%>

<!-- Topbar -->
<div class="topbar">

    <a href="HomeServlet" class="logo">
        Dev<span>Note</span>
    </a>

    <div class="search-bar">
    <form action="${pageContext.request.contextPath}/SearchByTagServlet"
          method="get">

        <input type="text"
               name="keyword"
               placeholder="Search by tag name..."
               required>

    </form>
	</div>

    <div class="social-icons">

        <i class="fab fa-facebook-f"></i>

        <i class="fab fa-twitter"></i>

        <i class="fab fa-instagram"></i>

    </div>

</div>

<!-- Navbar -->
<div class="navbar">

<a href="HomeServlet">

        <i class="fa fa-home"></i>
        java

    </a>

<a href="CheatSheetListServlet">
    <i class="fa fa-book-open"></i>
    Cheat Sheets
</a>

<a href="${pageContext.request.contextPath}/PopularCheatSheetsServlet">

    <i class="fa fa-fire"></i>
    Popular

</a>

<%
if(user != null){

    if("USER".equalsIgnoreCase(user.getRole())){
%>

    <a href="CreateCheatSheetPageServlet">
    <i class="fa fa-plus-circle"></i>
    Create
	</a>
    
    <a href="userview.jsp">

        <i class="fa fa-user-gear"></i>
        Manage Account

    </a>
    

<%
    }else if("ADMIN".equalsIgnoreCase(user.getRole())){
%>

    <a href="createCategory.jsp">

        <i class="fa fa-folder-plus"></i>
        Categories

    </a>
    
    <a href="adminview.jsp">

        <i class="fa fa-table-columns"></i>
        Dashboard

    </a>

<%
    }
}
%>

<div class="auth-buttons">

<%
if(user == null){
%>

    <button onclick="location.href='login.jsp'">

        <i class="fa fa-user"></i>
        Login

    </button>

    <button onclick="location.href='register.jsp'">

        <i class="fa fa-user-plus"></i>
        Register

    </button>

<%
}else{
%>

    <a href="profile.jsp" class="profile-link">

        <img src="<%= request.getContextPath() %>/uploads/<%= user.getProfile_img() != null ? user.getProfile_img() : "default.png" %>">

        <%= user.getName() %>

    </a>

    <button onclick="location.href='LogoutServlet'">

        Logout

    </button>

<%
}
%>

</div>

</div>
