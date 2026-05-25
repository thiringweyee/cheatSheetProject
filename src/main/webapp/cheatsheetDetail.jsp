<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${cheat.title}</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/prismjs/themes/prism.css">

<script src="https://cdn.jsdelivr.net/npm/prismjs/prism.js"></script>
<script src="https://cdn.jsdelivr.net/npm/prismjs/components/prism-java.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/prismjs/components/prism-sql.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/prismjs/components/prism-javascript.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/prismjs/components/prism-css.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/prismjs/components/prism-markup.min.js"></script>

<style>
:root{
    --white:#FFFFFF;
    --light-gray:#D4D4D4;
    --gray:#B3B3B3;
    --dark:#2B2B2B;
}

html{scroll-behavior:smooth;}

body{
    margin:0;
    background:var(--white);
    font-family:'Segoe UI',sans-serif;
    color:var(--dark);
}

.top-links{
    width:90%;
    max-width:1100px;
    margin:0 auto 35px;
    padding:18px 24px;
    background:var(--dark);
    border-radius:0 0 18px 18px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    flex-wrap:wrap;
    gap:18px;
    position:sticky;
    top:0;
    z-index:999;
    box-shadow:0 10px 24px rgba(0,0,0,0.15);
}

.top-links a{
    color:var(--white);
    text-decoration:none;
    font-weight:700;
    font-size:15px;
}

.top-right{
    display:flex;
    align-items:center;
    gap:16px;
}

.favorite-btn{
    width:42px;
    height:42px;
    border-radius:50%;
    border:2px solid var(--white);
    display:flex;
    align-items:center;
    justify-content:center;
}

.fa-solid.fa-heart{color:#ff4d6d;}
.fav-count{color:var(--white);font-weight:700;}

.comment-link{
    font-size:18px !important;
    font-weight:700;
    position:relative;
    padding-bottom:4px;
}

.comment-link::after{
    content:'';
    position:absolute;
    left:0;
    bottom:0;
    width:100%;
    border-bottom:2px dotted rgba(255,255,255,0.7);
}

.comment-link i{margin-right:8px;}

.wrapper{
    width:90%;
    max-width:950px;
    margin:35px auto 80px;
}

.title{
    font-size:46px;
    line-height:1.4;
    margin-bottom:12px;
}

.author{
    font-size:22px;
    color:#777;
    font-weight:600;
}

.desc{
    font-size:19px;
    line-height:1.9;
    color:#555;
    margin-top:24px;
}

.code-area{margin-top:55px;}

pre{
    overflow-x:auto;
    padding:18px;
    border-radius:12px;
    background:#f7f7f7;
    border:none;
}

.tags{
    display:flex;
    flex-wrap:wrap;
    gap:10px;
    margin-top:35px;
}

.tag-link{
    background:var(--light-gray);
    color:var(--dark);
    padding:8px 14px;
    border-radius:20px;
    font-size:14px;
    text-decoration:none;
    font-weight:700;
}

.tag-link:hover{
    background:var(--dark);
    color:var(--white);
}

.download-area{margin-top:70px;}

.download-title,
.comment-title{
    font-size:32px;
    margin-bottom:22px;
}

.download-text{
    font-size:17px;
    line-height:1.9;
    color:#555;
    margin-bottom:20px;
}

.download-btn{
    display:inline-block;
    padding:14px 24px;
    border-radius:12px;
    background:var(--dark);
    color:var(--white);
    text-decoration:none;
    font-weight:700;
}

.comment-area{margin-top:80px;}
.comment-form{margin-top:25px;}

.comment-form textarea,
.edit-comment-form textarea{
    width:100%;
    min-height:130px;
    padding:16px;
    border-radius:14px;
    border:2px solid var(--light-gray);
    outline:none;
    resize:vertical;
    box-sizing:border-box;
    font-size:15px;
    font-family:'Segoe UI',sans-serif;
}

.edit-comment-form textarea{
    min-height:90px;
    margin-top:12px;
}

.comment-btn{
    margin-top:15px;
    padding:13px 22px;
    border:none;
    border-radius:12px;
    background:var(--dark);
    color:var(--white);
    font-weight:700;
    cursor:pointer;
}

.cancel-btn{
    background:#777;
    margin-left:8px;
}

.reply-info{
    display:none;
    margin-top:18px;
    padding:12px 15px;
    background:#f5f5f5;
    border-left:4px solid var(--dark);
    color:#555;
    font-weight:600;
}

.cancel-reply{
    margin-left:12px;
    color:red;
    cursor:pointer;
    font-weight:700;
}

.comment-list{margin-top:35px;}

.comment-card{
    border-bottom:1px solid var(--light-gray);
    padding:20px 0;
}

.reply-card{
    margin-left:45px;
    background:#fafafa;
    padding-left:18px;
    border-left:3px solid var(--light-gray);
}

.hidden-comment{
    opacity:0.65;
}

.comment-head{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:12px;
    margin-bottom:8px;
}

.comment-head h4{margin:0;}

.comment-date{
    color:#777;
    font-size:13px;
}

.comment-card p{
    margin:0;
    color:#555;
    line-height:1.8;
}

.reply-btn,
.comment-action{
    display:inline-block;
    margin-top:10px;
    margin-right:12px;
    color:var(--dark);
    font-weight:700;
    text-decoration:none;
    cursor:pointer;
    font-size:14px;
}

.hide-action{color:red;}
.unhide-action{color:green;}

.reply-label,
.hidden-label{
    font-size:13px;
    color:#777;
    margin-bottom:6px;
}

@media(max-width:700px){
    .title{font-size:34px;}
    .author{display:block;margin-top:10px;}
    .top-right{gap:12px;}
    .reply-card{margin-left:20px;}
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="top-links">

    <a href="#download-area">
        <i class="fa fa-download"></i>
        Download This Cheat Sheet (PDF)
    </a>

    <div class="top-right">

        <a href="#comment-area" class="comment-link">
            <i class="fa fa-comment"></i>
            ${commentCount} Comments
        </a>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/ToggleFavoriteServlet?id=${cheat.id}"
                   class="favorite-btn"
                   title="Bookmark">
                    <c:choose>
                        <c:when test="${isFavorited}">
                            <i class="fa-solid fa-heart"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fa-regular fa-heart"></i>
                        </c:otherwise>
                    </c:choose>
                </a>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.jsp"
                   class="favorite-btn"
                   title="Login to bookmark">
                    <i class="fa-regular fa-heart"></i>
                </a>
            </c:otherwise>
        </c:choose>

        <span class="fav-count">${favoriteCount}</span>

    </div>
</div>

<div class="wrapper">

    <h1 class="title">
        ${cheat.title}
        <span class="author">by ${cheat.authorName}</span>
    </h1>

    <p class="desc">${cheat.description}</p>

    <div class="code-area">
        <pre><code class="language-${cheat.language}"><c:out value="${cheat.code_content}"/></code></pre>
    </div>

    <div class="tags">
        <c:forEach var="t" items="${cheat.tagList}">
            <a href="${pageContext.request.contextPath}/CheatSheetByTagServlet?tag=${t}"
               class="tag-link">
                #${t}
            </a>
        </c:forEach>
    </div>

    <div class="download-area" id="download-area">

        <h2 class="download-title">Download</h2>

        <p class="download-text">
            Download this cheat sheet as PDF and keep it for offline reading,
            printing, or sharing with others.
        </p>

        <a href="${pageContext.request.contextPath}/DownloadCheatSheetServlet?id=${cheat.id}"
           class="download-btn">
            <i class="fa fa-file-pdf"></i>
            Download PDF
        </a>

    </div>

    <div class="comment-area" id="comment-area">

        <h2 class="comment-title">Comments</h2>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">

                <div class="reply-info" id="replyInfo">
                    You are replying to <span id="replyUser"></span>
                    <span class="cancel-reply" onclick="cancelReply()">Cancel</span>
                </div>

                <form action="${pageContext.request.contextPath}/AddCommentServlet"
                      method="post"
                      class="comment-form"
                      id="commentForm">

                    <input type="hidden" name="cheatsheets_id" value="${cheat.id}">
                    <input type="hidden" name="parent_comment_id" id="parentCommentId" value="">

                    <textarea name="content"
                              id="commentText"
                              placeholder="Write your comment..."
                              required></textarea>

                    <button type="submit" class="comment-btn">
                        Post Comment
                    </button>

                </form>

            </c:when>

            <c:otherwise>
                <p>Please login to comment.</p>
            </c:otherwise>
        </c:choose>

        <div class="comment-list">

    <c:if test="${empty commentList}">

        <div class="comment-card">
            <p>No comments yet.</p>
        </div>

    </c:if>

    <c:forEach var="cm" items="${commentList}">

        <div class="
            comment-card

            <c:if test='${cm.parent_comment_id != null}'>
                reply-card
            </c:if>

            <c:if test='${cm.status == "hidden"}'>
                hidden-comment
            </c:if>
        ">

            <!-- Reply Label -->
            <c:if test="${cm.parent_comment_id != null}">

                <div class="reply-label">
                    Reply comment
                </div>

            </c:if>

            <!-- Hidden Label -->
            <c:if test="${cm.status == 'hidden'}">

                <div class="hidden-label">
                    This comment is hidden.
                </div>

            </c:if>

            <!-- Header -->
            <div class="comment-head">

                <h4>${cm.userName}</h4>

                <span class="comment-date">
                    ${cm.created_at}
                </span>

            </div>

            <!-- Comment Content -->
            <p id="commentText${cm.id}">

                <c:choose>

                    <c:when test="${cm.status == 'hidden'}">

                        <em>Hidden comment</em>

                    </c:when>

                    <c:otherwise>

                        <c:out value="${cm.content}"/>

                    </c:otherwise>

                </c:choose>

            </p>

            <!-- Reply Button -->
            <c:if test="${not empty sessionScope.user
                         && cm.status == 'active'}">

                <a class="reply-btn"
                   onclick="replyToComment(
                       '${cm.id}',
                       '${cm.userName}'
                   )">

                    Reply

                </a>

            </c:if>

            <!-- Owner Actions -->
            <c:if test="${not empty sessionScope.user
                         && sessionScope.user.id == cm.users_id}">

                <!-- Edit -->
                <c:if test="${cm.status == 'active'}">

                    <a class="comment-action"
                       onclick="showEditForm('${cm.id}')">

                        Edit

                    </a>

                </c:if>

                <!-- Toggle Hide / Unhide -->
                <a class="
                    comment-action

                    <c:choose>

                        <c:when test='${cm.status == "active"}'>
                            hide-action
                        </c:when>

                        <c:otherwise>
                            unhide-action
                        </c:otherwise>

                    </c:choose>
                "

                href="${pageContext.request.contextPath}/ToggleCommentVisibilityServlet?id=${cm.id}&cheatId=${cheat.id}"

                onclick="return confirm(
                    'Change comment visibility?'
                )">

                    <c:choose>

                        <c:when test="${cm.status == 'active'}">

                            Hide

                        </c:when>

                        <c:otherwise>

                            Unhide

                        </c:otherwise>

                    </c:choose>

                </a>

                <!-- Edit Form -->
                <c:if test="${cm.status == 'active'}">

                    <form action="${pageContext.request.contextPath}/EditCommentServlet"
                          method="post"
                          class="edit-comment-form"
                          id="editForm${cm.id}"
                          style="display:none;">

                        <input type="hidden"
                               name="comment_id"
                               value="${cm.id}">

                        <input type="hidden"
                               name="cheatsheets_id"
                               value="${cheat.id}">

                        <textarea name="content"
                                  required><c:out value="${cm.content}"/></textarea>

                        <button type="submit"
                                class="comment-btn">

                            Save

                        </button>

                        <button type="button"
                                class="comment-btn cancel-btn"
                                onclick="hideEditForm('${cm.id}')">

                            Cancel

                        </button>

                    </form>

                </c:if>

            </c:if>

        </div>

    </c:forEach>

</div>

    </div>

</div>

<script>
function replyToComment(commentId, userName){
    document.getElementById("parentCommentId").value = commentId;
    document.getElementById("replyUser").innerText = userName;
    document.getElementById("replyInfo").style.display = "block";
    document.getElementById("commentText").placeholder =
        "Write a reply to " + userName + "...";
    document.getElementById("comment-area").scrollIntoView();
}

function cancelReply(){
    document.getElementById("parentCommentId").value = "";
    document.getElementById("replyUser").innerText = "";
    document.getElementById("replyInfo").style.display = "none";
    document.getElementById("commentText").placeholder =
        "Write your comment...";
}

function showEditForm(commentId){
    document.getElementById("editForm" + commentId).style.display = "block";
}

function hideEditForm(commentId){
    document.getElementById("editForm" + commentId).style.display = "none";
}
</script>

<%@ include file="footer.jsp" %>

</body>
</html>