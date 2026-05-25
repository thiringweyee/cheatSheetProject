<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Favorite Cheat Sheets</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{--white:#FFFFFF;--light-gray:#D4D4D4;--gray:#B3B3B3;--dark:#2B2B2B;}

body{
    margin:0;
    background:var(--white);
    font-family:'Segoe UI',sans-serif;
    color:var(--dark);
}

.wrapper{
    width:90%;
    max-width:1200px;
    margin:45px auto;
}

.title{
    font-size:38px;
    margin-bottom:10px;
    text-align:center;
}

.subtitle{
    text-align:center;
    color:#666;
    margin-bottom:35px;
}

.grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:25px;
}

.card{
    border:2px solid var(--light-gray);
    border-radius:18px;
    padding:25px;
    background:var(--white);
    transition:0.3s;
}

.card:hover{
    background:#f7f7f7;
    transform:translateY(-5px);
}

.card a{
    text-decoration:none;
    color:inherit;
}

.card h3{
    font-size:24px;
    margin:0 0 12px;
}

.desc{
    line-height:1.6;
    color:#555;
    margin-bottom:18px;
}

.meta{
    font-size:14px;
    color:#666;
    margin-bottom:9px;
}

.tags{
    display:flex;
    flex-wrap:wrap;
    gap:8px;
    margin-top:15px;
}

.tag-link{
    background:var(--light-gray);
    color:var(--dark);
    padding:7px 12px;
    border-radius:20px;
    font-size:13px;
    text-decoration:none;
    font-weight:600;
}

.empty{
    text-align:center;
    font-size:22px;
    font-weight:700;
    margin-top:70px;
}

@media(max-width:900px){
    .grid{grid-template-columns:repeat(2,1fr);}
}

@media(max-width:600px){
    .grid{grid-template-columns:1fr;}
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="wrapper">

    <h1 class="title">Favorite Cheat Sheets</h1>
    <p class="subtitle">Cheat sheets you bookmarked.</p>

    <c:if test="${empty favoriteCheatList}">
        <p class="empty">No favorite cheat sheets yet.</p>
    </c:if>

    <c:if test="${not empty favoriteCheatList}">
        <div class="grid">

            <c:forEach var="c" items="${favoriteCheatList}">

                <div class="card">

                    <a href="${pageContext.request.contextPath}/CheatSheetDetailServlet?id=${c.id}">
                        <h3>${c.title}</h3>

                        <p class="desc">
                            <c:choose>
                                <c:when test="${fn:length(c.description) > 120}">
                                    ${fn:substring(c.description, 0, 120)}...
                                </c:when>
                                <c:otherwise>
                                    ${c.description}
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <div class="meta"><i class="fa fa-user"></i> ${c.authorName}</div>
                        <div class="meta"><i class="fa fa-folder"></i> ${c.categoryName}</div>
                        <div class="meta"><i class="fa fa-code"></i> ${c.language}</div>
                    </a>

                    <div class="tags">
                        <c:forEach var="t" items="${c.tagList}">
                            <a href="${pageContext.request.contextPath}/CheatSheetByTagServlet?tag=${t}"
                               class="tag-link">
                                #${t}
                            </a>
                        </c:forEach>
                    </div>

                </div>

            </c:forEach>

        </div>
    </c:if>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>