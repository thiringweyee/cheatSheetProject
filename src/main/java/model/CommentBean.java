package model;

import java.sql.Timestamp;

public class CommentBean {

    private long id;
    private String content;
    private Timestamp created_at;

    private long users_id;
    private long cheatsheets_id;

    private Long parent_comment_id;

    private String status;

    private String userName;
    private String cheatTitle;

    public CommentBean() {}

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public long getUsers_id() {
        return users_id;
    }

    public void setUsers_id(long users_id) {
        this.users_id = users_id;
    }

    public long getCheatsheets_id() {
        return cheatsheets_id;
    }

    public void setCheatsheets_id(long cheatsheets_id) {
        this.cheatsheets_id = cheatsheets_id;
    }

    public Long getParent_comment_id() {
        return parent_comment_id;
    }

    public void setParent_comment_id(Long parent_comment_id) {
        this.parent_comment_id = parent_comment_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getCheatTitle() {
        return cheatTitle;
    }

    public void setCheatTitle(String cheatTitle) {
        this.cheatTitle = cheatTitle;
    }

}