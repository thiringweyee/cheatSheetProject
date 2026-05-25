<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Comment Records</title>

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
    background:var(--white);
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
    vertical-align:top;
}

th{
    background:#f4f4f4;
    font-size:15px;
}

.comment-text{
    max-width:360px;
    line-height:1.7;
    color:#555;
}

.status{
    display:inline-block;
    padding:6px 12px;
    border-radius:20px;
    font-weight:700;
    font-size:13px;
}

.active{
    background:#e8f7e8;
    color:green;
}

.hidden{
    background:#fff4df;
    color:#c47a00;
}

.deleted{
    background:#ffe8e8;
    color:red;
}

.action{
    white-space:nowrap;
}

.action-btn{
    text-decoration:none;
    font-weight:700;
    margin-right:10px;
}

.hide-btn{
    color:#c47a00;
}

.restore-btn{
    color:green;
}

.delete-btn{
    color:red;
}

.empty{
    text-align:center;
    font-size:22px;
    font-weight:700;
    margin-top:60px;
}

@media(max-width:900px){
    .table-box{
        overflow-x:auto;
    }

    table{
        min-width:950px;
    }

    .top{
        flex-direction:column;
        align-items:flex-start;
        gap:15px;
    }
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
        <h1>
            <i class="fa fa-comments"></i>
            Comment Records
        </h1>

        <a href="adminview.jsp" class="back-btn">
            <i class="fa fa-arrow-left"></i>
            Back Dashboard
        </a>
    </div>

    <c:if test="${empty commentList}">
        <p class="empty">No comment records found.</p>
    </c:if>

    <c:if test="${not empty commentList}">
        <div class="table-box">
            <table>
                <tr>
                    <th>No</th>
                    <th>User</th>
                    <th>Cheat Sheet</th>
                    <th>Comment</th>
                    <th>Status</th>
                    <th>Created</th>
                    <th>Action</th>
                </tr>

                <c:forEach var="cm" items="${commentList}" varStatus="st">
                    <tr>
                        <td>${st.count}</td>

                        <td>${cm.userName}</td>

                        <td>${cm.cheatTitle}</td>

                        <td class="comment-text">
                            <c:choose>
                                <c:when test="${cm.status == 'deleted'}">
                                    <em>Deleted by admin</em>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${cm.content}"/>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <span class="status ${cm.status}">
                                ${cm.status}
                            </span>
                        </td>

                        <td>${cm.created_at}</td>

                        <td class="action">
                            <c:if test="${cm.status != 'hidden'}">
                                <a class="action-btn hide-btn"
                                   href="AdminCommentStatusServlet?id=${cm.id}&status=hidden"
                                   onclick="return confirm('Hide this comment?')">
                                    Hide
                                </a>
                            </c:if>

                            <c:if test="${cm.status != 'active'}">
                                <a class="action-btn restore-btn"
                                   href="AdminCommentStatusServlet?id=${cm.id}&status=active"
                                   onclick="return confirm('Restore this comment?')">
                                    Restore
                                </a>
                            </c:if>

                            <c:if test="${cm.status != 'deleted'}">
                                <a class="action-btn delete-btn"
                                   href="AdminCommentStatusServlet?id=${cm.id}&status=deleted"
                                   onclick="return confirm('Delete this comment?')">
                                    Delete
                                </a>
                            </c:if>
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