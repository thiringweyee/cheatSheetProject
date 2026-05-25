<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Panel</title>

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

.admin-container{
    display:flex;
    min-height:100vh;
}

.sidebar{
    width:310px;
    background:var(--dark);
    padding:28px 22px;
    box-sizing:border-box;
}

.sidebar h2{
    color:var(--white);
    font-size:28px;
    margin:0 0 28px;
    text-align:center;
}

.sidebar h2 span{
    color:var(--gray);
}

.admin-profile-card{
    display:flex;
    align-items:center;
    gap:15px;
    background:#3a3a3a;
    border:1px solid #555;
    border-radius:18px;
    padding:16px;
    margin-bottom:28px;
}

.admin-profile-img{
    width:72px;
    height:72px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid var(--gray);
    background:var(--light-gray);
}

.admin-profile-info{
    min-width:0;
}

.admin-profile-info h3{
    color:var(--white);
    font-size:19px;
    margin:0 0 6px;
}

.admin-profile-info p{
    color:var(--light-gray);
    font-size:14px;
    margin:0;
    word-break:break-all;
}

.sidebar-menu,
.sidebar-bottom{
    display:flex;
    flex-direction:column;
    gap:8px;
}

.sidebar-menu a,
.sidebar-bottom a{
    display:flex;
    align-items:center;
    text-decoration:none;
    color:var(--white);
    padding:15px 18px;
    border-radius:14px;
    font-size:16px;
    font-weight:600;
    transition:0.3s;
}

.sidebar-menu a i,
.sidebar-bottom a i{
    width:22px;
    margin-right:12px;
    font-size:18px;
}

.sidebar-menu a:hover,
.sidebar-bottom a:hover{
    background:var(--gray);
    color:var(--dark);
}

.sidebar-bottom{
    margin-top:28px;
    padding-top:20px;
    border-top:1px solid #555;
}

.main-content{
    flex:1;
    padding:50px;
}

.main-content h1{
    margin-top:0;
    font-size:42px;
    color:var(--dark);
}

.main-content p{
    font-size:18px;
    color:#777;
}

.dashboard-cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:25px;
    margin-top:40px;
}

.dashboard-card{
    background:var(--white);
    border:2px solid var(--light-gray);
    border-radius:18px;
    padding:30px;
    transition:0.3s;
    text-decoration:none;
    color:var(--dark);
}

.dashboard-card:hover{
    background:var(--light-gray);
    transform:translateY(-4px);
}

.dashboard-card i{
    font-size:42px;
    color:var(--dark);
    margin-bottom:18px;
}

.dashboard-card h3{
    margin:0 0 10px;
    font-size:24px;
    color:var(--dark);
}

.dashboard-card p{
    margin:0;
    font-size:15px;
    color:var(--dark);
    line-height:1.7;
}

@media(max-width:900px){
    .admin-container{
        flex-direction:column;
    }

    .sidebar{
        width:100%;
    }

    .main-content{
        padding:30px 22px;
    }
}
</style>
</head>

<body>

<%
UserBean adminUser = (UserBean) session.getAttribute("user");

if(adminUser == null){
    response.sendRedirect("login.jsp");
    return;
}

if(!"ADMIN".equalsIgnoreCase(adminUser.getRole())){
    response.sendRedirect("userview.jsp");
    return;
}
%>

<%@ include file="header.jsp" %>

<div class="admin-container">

    <aside class="sidebar">

        <h2><span>DevNote</span> Admin</h2>

        <div class="admin-profile-card">
            <img
            src="<%= request.getContextPath() %>/uploads/<%= adminUser.getProfile_img() != null ? adminUser.getProfile_img() : "default.png" %>"
            alt="Admin Profile"
            class="admin-profile-img">

            <div class="admin-profile-info">
                <h3><%= adminUser.getName() %></h3>
                <p><%= adminUser.getEmail() %></p>
            </div>
        </div>

        <nav class="sidebar-menu">

            <a href="adminview.jsp">
            <i class="fa fa-table-columns"></i>
                Dashboard
            </a>

            <a href="createCategory.jsp">
                <i class="fa fa-folder-plus"></i>
                Add Categories
            </a>

            <a href="CategoryListServlet">
                <i class="fa fa-list"></i>
                Category List
            </a>

            <a href="UserListServlet">
                <i class="fa fa-users"></i>
                User List
            </a>

            <a href="${pageContext.request.contextPath}/CheatSheetRecordServlet">
                <i class="fa fa-book"></i>
                Cheat Sheets Record
            </a>

            <a href="PendingCheatSheetsServlet">
                <i class="fa fa-clock"></i>
                Pending Cheat Sheets
            </a>
            
            <a href="AdminCommentListServlet">
			    <i class="fa fa-comments"></i>
			    Comment Records
			</a>

        </nav>

        <div class="sidebar-bottom">

            <a href="profile.jsp">
                <i class="fa fa-user"></i>
                My Profile
            </a>

            <a href="LogoutServlet">
                <i class="fa fa-right-from-bracket"></i>
                Logout
            </a>

        </div>

    </aside>

    <main class="main-content">

        <h1>Admin Dashboard</h1>

        <p>Manage categories, users, and cheat sheets from one place.</p>

        <div class="dashboard-cards">

            <a href="CategoryListServlet" class="dashboard-card">
                <i class="fa fa-folder"></i>
                <h3>Categories</h3>
                <p>Create and manage cheat sheet categories.</p>
            </a>

            <a href="UserListServlet" class="dashboard-card">
                <i class="fa fa-users"></i>
                <h3>Users</h3>
                <p>Manage registered users and user activities.</p>
            </a>

            <a href="CheatSheetRecordServlet" class="dashboard-card">
                <i class="fa fa-book"></i>
                <h3>Cheat Sheets Record</h3>
                <p>Control and organize all cheat sheet contents.</p>
            </a>

            <a href="PendingCheatSheetsServlet" class="dashboard-card">
                <i class="fa fa-clock"></i>
                <h3>Pending Cheat Sheets</h3>
                <p>Review, approve or reject user publish requests.</p>
            </a>

        </div>

    </main>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>