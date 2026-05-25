<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="pageSize" value="9" />

<c:choose>
    <c:when test="${not empty param.page}">
        <c:set var="currentPage" value="${param.page}" />
    </c:when>
    <c:otherwise>
        <c:set var="currentPage" value="1" />
    </c:otherwise>
</c:choose>

<c:set var="totalItems" value="${fn:length(cheatList)}" />
<c:set var="totalPages" value="${(totalItems + pageSize - 1) / pageSize}" />
<c:set var="startIndex" value="${(currentPage - 1) * pageSize}" />
<c:set var="endIndex" value="${startIndex + pageSize - 1}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>
    <c:choose>
        <c:when test="${not empty pageTitle}">${pageTitle}</c:when>
        <c:otherwise>Cheat Sheets</c:otherwise>
    </c:choose>
</title>

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

.wrapper{
    width:90%;
    max-width:1200px;
    margin:45px auto;
}

.title{
    text-align:center;
    font-size:38px;
    margin-bottom:10px;
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
    color:var(--dark);
    transition:0.3s;
    background:var(--white);
    display:block;
}

.card:hover{
    background:#f7f7f7;
    transform:translateY(-5px);
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
    transition:0.25s;
}

.tag-link:hover{
    background:var(--dark);
    color:var(--white);
}

.stats{
    display:flex;
    gap:18px;
    margin-top:18px;
    font-size:14px;
    color:#555;
}

.empty{
    text-align:center;
    font-size:22px;
    font-weight:700;
    margin-top:60px;
}

.pagination{
    display:flex;
    justify-content:center;
    align-items:center;
    gap:10px;
    margin-top:40px;
    flex-wrap:wrap;
}

.pagination a,
.pagination span{
    padding:10px 15px;
    border:2px solid var(--light-gray);
    border-radius:10px;
    text-decoration:none;
    color:var(--dark);
    font-weight:700;
}

.pagination a:hover{
    background:var(--light-gray);
}

.pagination .active-page{
    background:var(--dark);
    color:var(--white);
    border-color:var(--dark);
}

@media(max-width:900px){
    .grid{
        grid-template-columns:repeat(2,1fr);
    }
}

@media(max-width:600px){
    .grid{
        grid-template-columns:1fr;
    }
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="wrapper">

    <h1 class="title">
        <c:choose>
            <c:when test="${not empty pageTitle}">
                ${pageTitle}
            </c:when>
            <c:otherwise>
                Explore Cheat Sheets
            </c:otherwise>
        </c:choose>
    </h1>

    <p class="subtitle">
        <c:choose>
            <c:when test="${not empty pageSubtitle}">
                ${pageSubtitle}
            </c:when>
            <c:otherwise>
                Browse approved public cheat sheets created by DevNote users.
            </c:otherwise>
        </c:choose>
    </p>

    <c:if test="${empty cheatList}">
        <p class="empty">No cheat sheets found.</p>
    </c:if>

    <c:if test="${not empty cheatList}">
        <div class="grid">
        <c:forEach var="c" items="${cheatList}" varStatus="st">

                <c:if test="${st.index >= startIndex && st.index <= endIndex}">

                    <div class="card">

                        <a href="${pageContext.request.contextPath}/CheatSheetDetailServlet?id=${c.id}"
                           style="text-decoration:none;color:inherit;">

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

                            <div class="meta">
                                <i class="fa fa-user"></i> ${c.authorName}
                            </div>

                            <div class="meta">
                                <i class="fa fa-folder"></i> ${c.categoryName}
                            </div>

                            <div class="meta">
                                <i class="fa fa-code"></i> ${c.language}
                            </div>

                        </a>

                        <div class="tags">
                            <c:forEach var="t" items="${c.tagList}">
                                <a href="${pageContext.request.contextPath}/CheatSheetByTagServlet?tag=${t}"
                                   class="tag-link">
                                    #${t}
                                </a>
                            </c:forEach>
                        </div>

                        <div class="stats">
                            <span>
                                <i class="fa fa-eye"></i> ${c.view_count}
                            </span>

                            <span>
                                <i class="fa fa-download"></i> ${c.download_count}
                            </span>
                        </div>

                    </div>

                </c:if>

            </c:forEach>

        </div>

        <c:if test="${totalItems > pageSize}">
            <div class="pagination">

                <c:if test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}">
                        Previous
                    </a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="p">
                    <c:choose>
                        <c:when test="${p == currentPage}">
                            <span class="active-page">${p}</span>
                        </c:when>

                        <c:otherwise>
                            <a href="?page=${p}">${p}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}">
                        Next
                    </a>
                </c:if>

            </div>
        </c:if>

    </c:if>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>