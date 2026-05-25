<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

:root{
    --white:#FFFFFF;
    --light-gray:#D4D4D4;
    --gray:#B3B3B3;
    --dark:#2B2B2B;
}

/* Footer */
.footer{
    background:var(--light-gray);
    margin-top:60px;
    padding:50px 30px 25px;
    border-top:4px solid var(--dark);
}

/* Container */
.footer-container{
    display:flex;
    justify-content:space-between;
    flex-wrap:wrap;
    gap:30px;
}

/* Section */
.footer-section{
    flex:1;
    min-width:250px;
}

/* Heading */
.footer-section h3{
    color:var(--dark);
    margin-bottom:18px;
    font-size:22px;
}

/* Text */
.footer-section p{
    color:var(--dark);
    line-height:1.8;
    font-size:15px;
}

/* Links */
.footer-links{
    list-style:none;
    padding:0;
}

.footer-links li{
    margin-bottom:12px;
}

.footer-links a{
    text-decoration:none;
    color:var(--dark);
    font-weight:600;
}

.footer-links a:hover{
    color:var(--gray);
}

/* Divider */
.footer hr{
    margin:35px 0 25px;
    border:none;
    border-top:2px solid var(--gray);
}

/* Social */
.footer-social{
    text-align:center;
    margin-bottom:15px;
}

.footer-social i{
    width:42px;
    height:42px;
    line-height:42px;
    border-radius:50%;
    background:var(--dark);
    color:var(--white);
    margin:0 8px;
    cursor:pointer;
}

.footer-social i:hover{
    background:var(--gray);
    color:var(--dark);
}

/* Copyright */
.footer-copy{
    text-align:center;
    color:var(--dark);
    font-size:14px;
    font-weight:600;
}

</style>

<footer class="footer">

    <div class="footer-container">

        <div class="footer-section">
            <h3>About DevNote</h3>
            <p>
                DevNote is a collection of developer cheat sheets,
                quick references, and study resources for programmers,
                frameworks, and modern tools.
            </p>
        </div>

        <div class="footer-section">
            <h3>Behind the Scenes</h3>
            <p>
                Created and maintained by
                <strong>Thiri & Team</strong>.
            </p>
            <p>
                We aim to make learning easier and faster
                for developers worldwide.
            </p>
        </div>

        <div class="footer-section">
            <h3>Quick Links</h3>

            <ul class="footer-links">
                <li><a href="HomeServlet">Home</a></li>
                <li><a href="cheatsheets.jsp">Cheat Sheets</a></li>
                <li><a href="create.jsp">Create Cheat Sheet</a></li>
                <li><a href="profile.jsp">Profile</a></li>
            </ul>
        </div>

    </div>

    <hr>

    <div class="footer-social">
        <i class="fab fa-facebook-f"></i>
        <i class="fab fa-twitter"></i>
        <i class="fab fa-instagram"></i>
        <i class="fab fa-github"></i>
    </div>

    <div class="footer-copy">
        © 2026 DevNote | All Rights Reserved
    </div>

</footer>