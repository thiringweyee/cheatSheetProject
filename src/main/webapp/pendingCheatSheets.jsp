<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pending Cheat Sheets</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{--white:#FFFFFF;--light-gray:#D4D4D4;--gray:#B3B3B3;--dark:#2B2B2B;}
body{margin:0;background:var(--white);font-family:'Segoe UI',sans-serif;color:var(--dark);}
.wrapper{width:90%;max-width:1150px;margin:45px auto;}
h1{font-size:38px;margin-bottom:25px;}
.table-box{border:2px solid var(--light-gray);border-radius:18px;overflow:hidden;}
table{width:100%;border-collapse:collapse;}
th,td{padding:16px;border-bottom:1px solid var(--light-gray);text-align:left;}
th{background:#f4f4f4;}
.action a{text-decoration:none;margin-right:12px;font-weight:700;color:var(--dark);}
.approve{color:green!important;}
.reject{color:red!important;}
.empty{text-align:center;font-size:22px;font-weight:700;margin-top:60px;}
.tag{background:var(--light-gray);padding:5px 9px;border-radius:16px;font-size:13px;margin-right:5px;}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="wrapper">

    <h1>Pending Cheat Sheets</h1>

    <c:if test="${empty pendingList}">
        <p class="empty">No pending cheat sheets.</p>
    </c:if>

    <c:if test="${not empty pendingList}">
        <div class="table-box">
            <table>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Category</th>
                    <th>Language</th>
                    <th>Tags</th>
                    <th>Action</th>
                </tr>

                <c:forEach var="c" items="${pendingList}">
                    <tr>
                        <td>${c.title}</td>
                        <td>${c.authorName}</td>
                        <td>${c.categoryName}</td>
                        <td>${c.language}</td>
                        <td>
                            <c:forEach var="t" items="${c.tagList}">
                                <span class="tag">#${t}</span>
                            </c:forEach>
                        </td>
                        <td class="action">
                            <a href="CheatSheetDetailServlet?id=${c.id}">View</a>

                            <a href="ApproveCheatSheetServlet?id=${c.id}"
                               class="approve"
                               onclick="return confirm('Approve this cheat sheet?')">
                                Approve
                            </a>

                            <a href="RejectCheatSheetServlet?id=${c.id}"
                               class="reject"
                               onclick="return confirm('Reject this cheat sheet?')">
                                Reject
                            </a>
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