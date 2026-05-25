<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard | DevNote</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{
    --white:#FFFFFF;
    --light-gray:#D4D4D4;
    --gray:#B3B3B3;
    --dark:#2B2B2B;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial, sans-serif;
    background:var(--white);
    color:var(--dark);
}

.user-layout{
    min-height:100vh;
    display:flex;
}

.sidebar{
    width:330px;
    min-height:100vh;
    background:var(--white);
    border-right:1px solid var(--light-gray);
    padding:28px 22px;
}

.profile-card{
    display:flex;
    align-items:center;
    gap:16px;
    background:#f5f5f5;
    border:1px solid var(--light-gray);
    border-radius:18px;
    padding:18px;
    margin-bottom:28px;
}

.profile-img{
    width:82px;
    height:82px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid var(--white);
    background:var(--light-gray);
}

.profile-info{
    min-width:0;
}

.profile-info h3{
    font-size:21px;
    color:var(--dark);
    margin-bottom:7px;
}

.profile-info p{
    font-size:15px;
    color:#666;
    word-break:break-all;
}

.menu{
    display:flex;
    flex-direction:column;
    gap:8px;
}

.menu a,
.logout a{
    text-decoration:none;
    color:var(--dark);
}

.menu-item{
    display:flex;
    align-items:center;
    gap:18px;
    padding:18px 14px;
    border-radius:14px;
    font-size:18px;
    transition:0.25s ease;
}

.menu-item:hover{
    background:#f3f3f3;
    transform:translateX(4px);
}

.menu-item i{
    width:34px;
    height:34px;
    border-radius:10px;
    display:flex;
    align-items:center;
    justify-content:center;
    background:var(--dark);
    color:var(--white);
    font-size:16px;
}

.logout{
    margin-top:30px;
    border-top:1px solid var(--light-gray);
    padding-top:22px;
}

.logout .menu-item i{
    background:#777;
}

.main-content{
    flex:1;
    min-height:100vh;
    padding:45px 55px;
    background:#fafafa;
}

.top-title{
    margin-bottom:35px;
}

.top-title h1{
    font-size:36px;
    color:var(--dark);
    margin-bottom:10px;
}

.top-title p{
    font-size:18px;
    color:#666;
}

.quick-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:24px;
    margin-bottom:40px;
}

.quick-card{
    background:var(--white);
    border:1px solid var(--light-gray);
    border-radius:18px;
    padding:34px 24px;
    text-align:center;
    text-decoration:none;
    color:var(--dark);
    transition:0.25s ease;
}

.quick-card:hover{
    transform:translateY(-6px);
    box-shadow:0 12px 28px rgba(0,0,0,0.08);
}

.quick-card i{
    width:62px;
    height:62px;
    border-radius:50%;
    background:#eeeeee;
    color:var(--dark);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:25px;
    margin:0 auto 18px;
}

.quick-card h3{
    font-size:20px;
    margin-bottom:10px;
}

.quick-card p{
    color:#666;
    font-size:15px;
    line-height:1.5;
}

.recent-box{
    background:var(--white);
    border:1px solid var(--light-gray);
    border-radius:18px;
    padding:35px;
}

.recent-box h2{
    font-size:24px;
    margin-bottom:20px;
}

.empty-state{
    text-align:center;
    padding:50px 20px;
    color:#666;
}

.empty-state i{
    width:72px;
    height:72px;
    border-radius:50%;
    background:#eeeeee;
    color:var(--dark);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:30px;
    margin:0 auto 18px;
}

.empty-state h3{
    color:var(--dark);
    margin-bottom:10px;
}

.create-btn{
    display:inline-block;
    margin-top:22px;
    background:var(--dark);
    color:var(--white);
    padding:13px 24px;
    border-radius:10px;
    text-decoration:none;
    font-weight:bold;
    transition:0.25s ease;
}

.create-btn:hover{
    background:#000;
}
@media(max-width:900px){
    .user-layout{
        flex-direction:column;
    }

    .sidebar{
        width:100%;
        min-height:auto;
        border-right:none;
        border-bottom:1px solid var(--light-gray);
    }

    .main-content{
        padding:30px 22px;
    }

    .quick-grid{
        grid-template-columns:1fr;
    }
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="user-layout">

    <aside class="sidebar">

        <div class="profile-card">

            <c:choose>
                <c:when test="${not empty sessionScope.user.profile_img}">
                    <img src="${pageContext.request.contextPath}/uploads/${sessionScope.user.profile_img}"
                         class="profile-img" alt="Profile">
                </c:when>

                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/uploads/default.png"
                         class="profile-img" alt="Profile">
                </c:otherwise>
            </c:choose>

            <div class="profile-info">
                <h3>${sessionScope.user.name}</h3>
                <p>${sessionScope.user.email}</p>
            </div>

        </div>

        <nav class="menu">

            <a href="${pageContext.request.contextPath}/profile.jsp">
                <div class="menu-item">
                    <i class="fa-solid fa-user"></i>
                    <span>My Profile</span>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/CreateCheatSheetPageServlet">
                <div class="menu-item">
                    <i class="fa-solid fa-file-circle-plus"></i>
                    <span>Create Cheat Sheet</span>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/MyCheatSheetsServlet">
                <div class="menu-item">
                    <i class="fa-solid fa-folder"></i>
                    <span>My Cheat Sheet</span>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/MyFavoriteCheatSheetsServlet">
			    <div class="menu-item">
			        <i class="fa-solid fa-heart"></i>
			        <span>Favorite Cheat Sheets</span>
			    </div>
			</a>

        </nav>

        <div class="logout">
            <a href="${pageContext.request.contextPath}/LogoutServlet">
                <div class="menu-item">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <span>Logout</span>
                </div>
            </a>
        </div>

    </aside>

    <main class="main-content">

        <div class="top-title">
            <h1>Welcome back, ${sessionScope.user.name}!</h1>
            <p>Manage your profile and cheat sheets from your dashboard.</p>
        </div>

        <div class="quick-grid">

            <a href="${pageContext.request.contextPath}/profile.jsp" class="quick-card">
                <i class="fa-solid fa-user"></i>
                <h3>My Profile</h3>
                <p>View and update your personal information.</p>
            </a>

            <a href="${pageContext.request.contextPath}/CreateCheatSheetPageServlet" class="quick-card">
                <i class="fa-solid fa-file-circle-plus"></i>
                <h3>Create Cheat Sheet</h3>
                <p>Create a new programming cheat sheet.</p>
            </a>

            <a href="${pageContext.request.contextPath}/MyCheatSheetsServlet" class="quick-card">
                <i class="fa-solid fa-folder-open"></i>
                <h3>My Cheat Sheet</h3>
                <p>View, edit and manage your cheat sheets.</p>
            </a>

        </div>

        

    </main>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>