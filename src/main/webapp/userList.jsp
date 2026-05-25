<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Management</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

:root{
    --white:#FFFFFF;
    --light-gray:#D4D4D4;
    --gray:#B3B3B3;
    --dark:#2B2B2B;
}

/* Body */
body{
    margin:0;
    background:var(--white);
    font-family:'Segoe UI',sans-serif;
    color:var(--dark);
}

/* Header */
.user-header{
    width:90%;
    margin:40px auto 25px;

    display:flex;
    align-items:center;
    justify-content:space-between;
}

/* Title */
.user-header h2{
    font-size:34px;
    margin:0;
    color:var(--dark);
}

.user-header span{
    color:var(--gray);
}

/* Search */
.search-box{
    display:flex;
    gap:10px;
}

.search-box input[type="text"]{
    width:240px;

    padding:12px 16px;

    border:2px solid var(--light-gray);

    border-radius:12px;

    outline:none;

    font-size:15px;

    background:var(--white);
}

.search-box input[type="text"]:focus{
    border-color:var(--gray);
}

.search-box input[type="submit"]{
    background:var(--dark);
    color:var(--white);

    border:none;

    padding:12px 18px;

    border-radius:12px;

    cursor:pointer;

    font-weight:600;
}

.search-box input[type="submit"]:hover{
    background:var(--gray);
    color:var(--dark);
}

/* Empty */
.empty-text{
    text-align:center;

    margin-top:60px;

    font-size:22px;
    font-weight:700;

    color:var(--dark);
}

/* Table */
.user-table{
    width:90%;

    margin:0 auto 35px;

    border-collapse:collapse;

    background:var(--white);

    border:2px solid var(--light-gray);

    overflow:hidden;

    border-radius:16px;
}

/* Head */
.user-table th{
    background:var(--dark);

    color:var(--white);

    padding:18px;

    text-align:left;

    font-size:15px;
}

/* Data */
.user-table td{
    padding:18px;

    border-bottom:1px solid var(--light-gray);

    font-size:15px;
}

/* Row Hover */
.user-table tr:hover{
    background:var(--light-gray);
}

/* Role */
.role{
    background:var(--gray);

    color:var(--dark);

    padding:6px 12px;

    border-radius:30px;

    font-size:13px;
    font-weight:700;
}

/* Actions */
.actions button{
    background:none;
    border:none;
    cursor:pointer;
}

.actions i{
    font-size:18px;
    color:var(--dark);
}

.actions i:hover{
    color:var(--gray);
}

/* Pagination */
.pagination{
    text-align:center;
    margin-bottom:50px;
}

/* Pagination Links */
.pagination a,
.pagination strong{

    display:inline-block;

    padding:10px 16px;

    margin:0 5px;

    border-radius:10px;

    text-decoration:none;

    font-weight:600;

    border:2px solid var(--light-gray);
}

/* Normal */
.pagination a{
    color:var(--dark);
    background:var(--white);
}

/* Hover */
.pagination a:hover{
    background:var(--light-gray);
}

/* Active */
.pagination strong{
    background:var(--dark);
    color:var(--white);
}

</style>

</head>

<body>

<%@ include file="header.jsp" %>

<div class="user-header">

    <h2>
        <span>DevNote</span>
        User Management
    </h2>

    <form class="search-box"
          action="UserListServlet"
          method="get">

        <input type="text"
               name="keyword"
               value="${keyword}"
               placeholder="Search by name...">

        <input type="submit"
               value="Search">

    </form>

</div>

<c:if test="${empty userList}">

    <p class="empty-text">
        No Users Found.
    </p>

</c:if>

<c:if test="${not empty userList}">

    <table class="user-table">

        <tr>

            <th>No</th>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Created At</th>
            <th>Actions</th>

        </tr>

        <c:forEach var="u"
                   items="${userList}"
                   varStatus="i">

            <tr>

                <td>${i.count}</td>

                <td>${u.id}</td>

                <td>
                    <strong>${u.name}</strong>
                </td>

                <td>

                    <i class="fa-regular fa-envelope"></i>

                    ${u.email}

                </td>

                <td>

                    <span class="role">
                        ${u.role}
                    </span>

                </td>

                <td>${u.created_at}</td>

                <td class="actions">

                    <form action="DeleteUserServlet"
                          method="post"
                          style="display:inline;">

                        <input type="hidden"
                               name="id"
                               value="${u.id}">

                        <button type="submit">

                            <i class="fa-solid fa-trash"></i>

                        </button>

                    </form>

                </td>

            </tr>

        </c:forEach>

    </table>

    <div class="pagination">

        <c:forEach var="i"
                   begin="1"
                   end="${totalPages}">

            <c:choose>

                <c:when test="${i == currentPage}">

                    <strong>${i}</strong>

                </c:when>

                <c:otherwise>

                    <a href="UserListServlet?page=${i}&keyword=${keyword}">
                        ${i}
                    </a>

                </c:otherwise>

            </c:choose>

        </c:forEach>

    </div>

</c:if>

<%@ include file="footer.jsp" %>

</body>
</html>