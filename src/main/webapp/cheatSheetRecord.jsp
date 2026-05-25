<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheat Sheet Records</title>

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
    width:94%;
    max-width:1250px;
    margin:45px auto;
}

.top{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:28px;
}

.top h1{
    margin:0;
    font-size:38px;
}

.back-btn{
    background:var(--dark);
    color:var(--white);
    padding:12px 18px;
    border-radius:12px;
    text-decoration:none;
    font-weight:700;
}

.table-box{
    border:2px solid var(--light-gray);
    border-radius:18px;
    overflow:hidden;
}

table{
    width:100%;
    border-collapse:collapse;
}

th,td{
    padding:15px;
    border-bottom:1px solid var(--light-gray);
    text-align:left;
    font-size:14px;
}

th{
    background:#f4f4f4;
    font-size:15px;
}

.status-active{
    color:green;
    font-weight:700;
}

.status-banned{
    color:red;
    font-weight:700;
}

.action a{
    text-decoration:none;
    font-weight:700;
    margin-right:10px;
    color:var(--dark);
}

.ban{
    color:red!important;
}

.unban{
    color:green!important;
}

.empty{
    text-align:center;
    font-size:22px;
    font-weight:700;
    margin-top:60px;
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="wrapper">

    <div class="top">
        <h1>Cheat Sheet Records</h1>

        <a href="adminview.jsp" class="back-btn">
            <i class="fa fa-arrow-left"></i>
            Back Dashboard
        </a>
    </div>

    <c:if test="${empty recordList}">
        <p class="empty">No cheat sheet records found.</p>
    </c:if>

    <c:if test="${not empty recordList}">
        <div class="table-box">
            <table>
                <tr>
                    <th>No</th>
                    <th>Cheat Sheet Title</th>
                    <th>Uploaded By</th>
                    <th>Category</th>
                    <th>Language</th>
                    <th>Created Time</th>
                    <th>Uploaded Time</th>
                    <th>Visibility</th>
                    <th>Status</th>
                    <th>Ban Status</th>
                    <th>Action</th>
                </tr>

                <c:forEach var="c" items="${recordList}" varStatus="st">
                    <tr>
                        <td>${st.count}</td>

                        <td>${c.title}</td>

                        <td>${c.authorName}</td>

                        <td>${c.categoryName}</td>

                        <td>${c.language}</td>

                        <td>${c.created_at}</td>
                        
                        <td>${c.updated_at}</td>

                        <td>${c.visibility}</td>

                        <td>${c.status}</td>

                        <td>
                            <c:choose>
                                <c:when test="${c.ban_status == 'ACTIVE'}">
                                    <span class="status-active">Active</span>
                                </c:when>

                                <c:otherwise>
                                    <span class="status-banned">Banned</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td class="action">
                            <a href="AdminCheatSheetDetailServlet?id=${c.id}">
							    View
							</a>

                            <c:choose>
                                <c:when test="${c.ban_status == 'ACTIVE'}">
                                    <a href="BanCheatSheetServlet?id=${c.id}"
                                       class="ban"
                                       onclick="return confirm('Ban this cheat sheet?')">
                                        Ban
                                    </a>
                                </c:when>

                                <c:otherwise>
                                    <a href="UnbanCheatSheetServlet?id=${c.id}"
                                       class="unban"
                                       onclick="return confirm('Unban this cheat sheet?')">
                                        Unban
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </c:if>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>