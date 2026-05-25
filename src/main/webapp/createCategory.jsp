<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Category</title>

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
.form-wrapper{
    display:flex;
    justify-content:center;
    align-items:center;

    padding:60px 20px;
}

/* Form Card */
.category-form{
    width:500px;

    background:var(--white);

    border:2px solid var(--light-gray);

    border-radius:20px;

    padding:40px;

    box-sizing:border-box;
}

/* Title */
.category-form h2{
    margin-top:0;
    margin-bottom:30px;

    text-align:center;

    font-size:34px;

    color:var(--dark);
}

/* Input Group */
.input-group{
    margin-bottom:25px;
}

/* Label */
.input-group label{
    display:block;

    margin-bottom:10px;

    font-size:16px;
    font-weight:600;

    color:var(--dark);
}

/* Input */
.input-group input{
    width:100%;

    padding:15px;

    border:2px solid var(--light-gray);

    border-radius:14px;

    outline:none;

    font-size:15px;

    box-sizing:border-box;
}

/* Focus */
.input-group input:focus{
    border-color:var(--gray);
}

/* Button */
.submit-btn{
    width:100%;

    background:var(--dark);

    color:var(--white);

    border:none;

    padding:16px;

    border-radius:14px;

    cursor:pointer;

    font-size:16px;
    font-weight:700;

    transition:0.3s;
}

/* Hover */
.submit-btn:hover{
    background:var(--gray);
    color:var(--dark);
}

/* Icon */
.form-icon{
    text-align:center;

    margin-bottom:18px;
}

.form-icon i{
    font-size:55px;

    color:var(--dark);
}

</style>

</head>

<body>

<%@ include file="header.jsp" %>

<div class="form-wrapper">

    <div class="category-form">

        <div class="form-icon">

            <i class="fa fa-folder-plus"></i>

        </div>

        <h2>Create Category</h2>

        <form action="CreateCategoryServlet"
              method="post">

            <div class="input-group">

                <label>
                    Category Name
                </label>

                <input type="text"
                       name="name"
                       placeholder="Enter category name..."
                       required>

            </div>

            <button type="submit"
                    class="submit-btn">

                Create Category

            </button>

        </form>

    </div>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>