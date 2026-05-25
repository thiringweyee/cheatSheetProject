package model;

import java.sql.Timestamp;

public class DownloadBean {

    private long id;
    private long users_id;
    private long cheatsheets_id;
    private Timestamp downloaded_at;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

    public Timestamp getDownloaded_at() {
        return downloaded_at;
    }

    public void setDownloaded_at(Timestamp downloaded_at) {
        this.downloaded_at = downloaded_at;
    }
}