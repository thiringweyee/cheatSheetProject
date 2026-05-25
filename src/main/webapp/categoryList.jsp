<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category List</title>

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

/* Wrapper */
.category-wrapper{
    width:90%;
    margin:45px auto;
}

/* Header */
.category-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:30px;
}

/* Title */
.category-title{
    font-size:34px;
    margin:0;
    color:var(--dark);
}

/* Add Button */
.add-btn{
    background:var(--dark);
    color:var(--white);

    text-decoration:none;

    padding:12px 20px;

    border-radius:12px;

    font-weight:600;

    transition:0.3s;
}

.add-btn:hover{
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
.category-table{
    width:100%;

    border-collapse:collapse;

    background:var(--white);

    border:2px solid var(--light-gray);

    border-radius:18px;

    overflow:hidden;
}

/* Head */
.category-table th{
    background:var(--dark);

    color:var(--white);

    padding:18px;

    text-align:left;

    font-size:15px;
}

/* Data */
.category-table td{
    padding:18px;

    border-bottom:1px solid var(--light-gray);

    font-size:15px;
}

/* Hover */
.category-table tr:hover{
    background:var(--light-gray);
}

/* Actions */
.actions{
    display:flex;
    align-items:center;
    gap:10px;
}

/* Edit Link */
.edit-btn{
    background:var(--gray);

    color:var(--dark);

    text-decoration:none;

    padding:8px 14px;

    border-radius:10px;

    font-size:14px;
    font-weight:600;

    transition:0.3s;
}

.edit-btn:hover{
    background:var(--dark);
    color:var(--white);
}

/* Delete Button */
.delete-btn{
    background:var(--dark);

    color:var(--white);

    border:none;

    padding:8px 14px;

    border-radius:10px;

    cursor:pointer;

    font-size:14px;
    font-weight:600;

    transition:0.3s;
}

.delete-btn:hover{
    background:var(--gray);
    color:var(--dark);
}

</style>

</head>

<body>

<%@ include file="header.jsp" %>

<div class="category-wrapper">

    <!-- Header -->
    <div class="category-header">

        <h1 class="category-title">
            Category List
        </h1>

        <a href="createCategory.jsp"
           class="add-btn">

            <i class="fa fa-plus"></i>
            Add Category

        </a>

    </div>

    <!-- Empty -->
    <c:if test="${empty categoryList}">

        <p class="empty-text">
            No Category Found.
        </p>

    </c:if>

    <!-- Table -->
    <c:if test="${not empty categoryList}">

        <table class="category-table">

            <tr>

                <th>ID</th>
                <th>Name</th>
                <th>Created At</th>
                <th>Actions</th>

            </tr>

            <c:forEach var="c"
                       items="${categoryList}">

                <tr>

                    <td>${c.id}</td>

                    <td>
                        <strong>${c.name}</strong>
                    </td>

                    <td>${c.created_at}</td>

                    <td>

                        <div class="actions">

                            <a href="EditCategoryServlet?id=${c.id}"
                               class="edit-btn">

                                <i class="fa fa-pen"></i>
                                Edit

                            </a>

                            <form action="DeleteCategoryServlet"
                                  method="post"
                                  style="display:inline;">

                                <input type="hidden"
                                       name="id"
                                       value="${c.id}">

                                <button type="submit"
                                        class="delete-btn">

                                    <i class="fa fa-trash"></i>
                                    Delete

                                </button>

                            </form>

                        </div>

                    </td>

                </tr>

            </c:forEach>

        </table>

    </c:if>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>