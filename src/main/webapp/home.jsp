<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>

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

.category-wrapper{
    width:90%;
    max-width:1180px;
    margin:45px auto;
}

.welcome-box{
    background:var(--white);
    border:2px solid var(--light-gray);
    border-radius:20px;
    padding:28px 32px;
    margin-bottom:35px;
}

.welcome-box h2{
    margin:0 0 8px;
    font-size:32px;
    color:var(--dark);
}

.welcome-box p{
    margin:0;
    font-size:16px;
    color:#666;
}

.category-title{
    text-align:center;
    font-size:34px;
    margin-bottom:10px;
    color:var(--dark);
}

.category-subtitle{
    text-align:center;
    color:var(--gray);
    margin-bottom:35px;
    font-size:16px;
}

.category-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:28px;
}

.category-card{
    background:var(--white);
    border:2px solid var(--light-gray);
    border-radius:16px;
    padding:35px 25px;
    text-decoration:none;
    color:var(--dark);
    transition:0.3s;
    text-align:center;
}

.category-card:hover{
    transform:translateY(-5px);
    background:var(--light-gray);
    border-color:var(--gray);
}

.card-icon{
    width:78px;
    height:78px;
    border-radius:50%;
    background:var(--light-gray);
    display:flex;
    align-items:center;
    justify-content:center;
    margin:0 auto 22px;
}

.card-icon i{
    font-size:32px;
    color:var(--dark);
}

.card-title{
    font-size:24px;
    font-weight:700;
    margin-bottom:12px;
}

.card-desc{
    font-size:15px;
    line-height:1.7;
    color:var(--dark);
}

.no-category{
    text-align:center;
    margin-top:60px;
    font-size:22px;
    font-weight:bold;
    color:var(--dark);
}

@media(max-width:900px){
    .category-grid{
        grid-template-columns:repeat(2,1fr);
    }
}

@media(max-width:600px){
    .category-grid{
        grid-template-columns:1fr;
    }

    .welcome-box h2{
        font-size:26px;
    }
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="category-wrapper">

    <c:if test="${not empty sessionScope.user}">
        <div class="welcome-box">
            <h2>Hi ${sessionScope.user.name}, welcome back!</h2>
            <p>Explore categories and continue building your cheat sheets.</p>
        </div>
    </c:if>

    <h1 class="category-title">Browse Categories</h1>
    <p class="category-subtitle">
        Explore cheat sheets by category and improve your skills.
    </p>

    <c:if test="${empty categoryList}">
        <p class="no-category">No Categories Found.</p>
    </c:if>

    <c:if test="${not empty categoryList}">
        <div class="category-grid">

            <c:forEach var="c" items="${categoryList}">
                <a href="${pageContext.request.contextPath}/CheatSheetByCategoryServlet?id=${c.id}"
   							class="category-card">

                    <div class="card-icon">
                        <i class="fa-solid fa-layer-group"></i>
                    </div>

                    <div class="card-title">
                        ${c.name}
                    </div>

                    <div class="card-desc">
                        Browse all cheat sheets from this category.
                    </div>

                </a>
            </c:forEach>

        </div>
    </c:if>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>