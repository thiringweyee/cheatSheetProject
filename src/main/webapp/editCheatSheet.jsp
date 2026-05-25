<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Cheat Sheet</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{--white:#FFFFFF;--light-gray:#D4D4D4;--gray:#B3B3B3;--dark:#2B2B2B;}
body{margin:0;background:var(--white);font-family:'Segoe UI',sans-serif;color:var(--dark);}
.wrapper{width:900px;margin:50px auto;}
.card{border:2px solid var(--light-gray);border-radius:22px;padding:40px;}
h1{margin-top:0;font-size:38px;}
.form-group{margin-bottom:22px;}
label{display:block;margin-bottom:9px;font-weight:700;}
input,textarea,select{width:100%;padding:15px;border:2px solid var(--light-gray);border-radius:14px;box-sizing:border-box;font-size:15px;outline:none;}
textarea{resize:vertical;}
.btn{width:100%;padding:16px;border:none;border-radius:14px;background:var(--dark);color:var(--white);font-weight:700;font-size:16px;cursor:pointer;}
.msg{text-align:center;font-weight:700;}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="wrapper">
    <div class="card">

        <h1>Edit Cheat Sheet</h1>

        <p class="msg">${msg}</p>

        <form action="UpdateCheatSheetServlet" method="post">

            <input type="hidden" name="id" value="${cheat.id}">

            <div class="form-group">
                <label>Title</label>
                <input type="text" name="title" value="${cheat.title}" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="4" required>${cheat.description}</textarea>
            </div>

            <div class="form-group">
                <label>Code Content</label>
                <textarea name="code_content" rows="14" required>${cheat.code_content}</textarea>
            </div>

            <div class="form-group">
                <label>Language</label>
                <input type="text" name="language" value="${cheat.language}" required>
            </div>

            <div class="form-group">
                <label>Category</label>
                <select name="categories_id" required>
                    <c:forEach var="cat" items="${categoryList}">
                        <option value="${cat.id}"
                            <c:if test="${cat.id == cheat.categories_id}">selected</c:if>>
                            ${cat.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label>Tags</label>
                <input type="text" name="tags" value="${cheat.tagsText}">
            </div>


            <button type="submit" class="btn">Update Cheat Sheet</button>

        </form>

    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>