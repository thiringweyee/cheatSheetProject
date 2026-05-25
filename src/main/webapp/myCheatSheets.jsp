<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cheat Sheets</title>

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
    max-width:1100px;
    margin:45px auto;
}

.top{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:30px;
}

.top h1{
    font-size:38px;
    margin:0;
}

.create-btn{
    background:var(--dark);
    color:var(--white);
    padding:13px 20px;
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
    padding:16px;
    border-bottom:1px solid var(--light-gray);
    text-align:left;
}

th{
    background:#f4f4f4;
}

.action a{
    text-decoration:none;
    margin-right:12px;
    color:var(--dark);
    font-weight:700;
}

.action span{
    font-weight:700;
    color:#666;
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
        <h1>My Cheat Sheets</h1>

        <a href="CreateCheatSheetPageServlet" class="create-btn">
            <i class="fa fa-plus"></i> Create New
        </a>
    </div>

    <c:if test="${empty myCheatList}">
        <p class="empty">No cheat sheets yet.</p>
    </c:if>

    <c:if test="${not empty myCheatList}">
        <div class="table-box">
            <table>
                <tr>
                    <th>Title</th>
                    <th>Category</th>
                    <th>Language</th>
                    <th>Publish Status</th>
                    <th>Views</th>
                    <th>Downloads</th>
                    <th>Action</th>
                </tr>

                <c:forEach var="c" items="${myCheatList}">
                    <tr>
                        <td>${c.title}</td>
                        <td>${c.categoryName}</td>
                        <td>${c.language}</td>
                        <td>${c.publish_status}</td>
                        <td>${c.view_count}</td>
                        <td>${c.download_count}</td>

                        <td class="action">
                            <a href="CheatSheetDetailServlet?id=${c.id}">View</a>

                            <c:if test="${c.publish_status != 'APPROVED'}">
                                <a href="EditCheatSheetPageServlet?id=${c.id}">Edit</a>
                            </c:if>

                            <a href="DeleteCheatSheetServlet?id=${c.id}"
                               onclick="return confirm('Delete this cheat sheet?')">
                                Delete
                            </a>

                            <c:if test="${c.publish_status == 'PRIVATE' || c.publish_status == 'REJECTED'}">
                                <a href="RequestPublishServlet?id=${c.id}"
                                   onclick="return confirm('Request admin approval for public publish?')">
                                    Request Publish
                                </a>
                            </c:if>

                            <c:if test="${c.publish_status == 'PENDING'}">
                                <span>Waiting Approval</span>
                            </c:if>

                            <c:if test="${c.publish_status == 'APPROVED'}">
                                <span>Published</span>
                            </c:if>
                            
                            <c:if test="${c.publish_status == 'APPROVED'}">

							    <a href="MakePrivateServlet?id=${c.id}"
							       onclick="return confirm('Make this cheat sheet private?')">
							
							        Make Private
							
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