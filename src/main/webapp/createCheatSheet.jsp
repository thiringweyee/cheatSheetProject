<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Cheat Sheet</title>

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
    width:900px;
    margin:50px auto;
}

.card{
    border:2px solid var(--light-gray);
    border-radius:22px;
    padding:40px;
}

h1{
    margin-top:0;
    font-size:38px;
}

.form-group{
    margin-bottom:22px;
}

label{
    display:block;
    margin-bottom:9px;
    font-weight:700;
}

input, textarea, select{
    width:100%;
    padding:15px;
    border:2px solid var(--light-gray);
    border-radius:14px;
    box-sizing:border-box;
    font-size:15px;
    outline:none;
}

textarea{
    resize:vertical;
}

input:focus,
textarea:focus,
select:focus{
    border-color:var(--gray);
}

.btn{
    width:100%;
    padding:16px;
    border:none;
    border-radius:14px;
    background:var(--dark);
    color:var(--white);
    font-weight:700;
    font-size:16px;
    cursor:pointer;
}

.btn:hover{
    background:var(--gray);
    color:var(--dark);
}

.msg{
    text-align:center;
    font-weight:700;
    margin-bottom:20px;
}

.note{
    font-size:13px;
    color:#666;
    margin-top:7px;
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="wrapper">
    <div class="card">

        <h1>Create Cheat Sheet</h1>

        <p class="msg">${msg}</p>

        <c:if test="${empty categoryList}">
            <p class="msg">
                No categories found. Please ask admin to create categories first.
            </p>
        </c:if>

        <c:if test="${not empty categoryList}">

            <form action="CreateCheatSheetServlet" method="post">

                <div class="form-group">
                    <label>Title</label>
                    <input type="text" name="title" required>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="4" required></textarea>
                </div>

                <div class="form-group">
                    <label>Content</label>
                    <textarea name="code_content" rows="14" required></textarea>
                    <div class="note">
                        You can write code, notes, commands, examples, or cheat sheet content here.
                    </div>
                </div>

                <div class="form-group">
                    <label>Language</label>
                    <input type="text"
                           name="language"
                           placeholder="java, sql, html, css, javascript"
                           required>
                </div>

                <div class="form-group">
                    <label>Category</label>
                    <select name="categories_id" required>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat.id}">
                                ${cat.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Tags</label>
                    <input type="text"
                           name="tags"
                           placeholder="jsp, servlet, jdbc, java">
                    <div class="note">
                        Separate tags with commas, for example: java, jsp, servlet
                    </div>
                </div>

                <button type="submit" class="btn">
                    Create Cheat Sheet
                </button>

            </form>
            </c:if>

    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>