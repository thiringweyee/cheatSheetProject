package model;

import java.sql.Timestamp;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheatSheetBean {
    private long id;
    private String title;
    private String description;
    private String code_content;
    private String language;
    private String visibility;
    private int view_count;
    private int download_count;
    private Timestamp created_at;
    private Timestamp updated_at;
    private long users_id;
    private long categories_id;
    private String status;
    private String publish_status;
    private String ban_status;

    private String authorName;
    private String categoryName;
    private List<String> tagList;
    private String tagsText;
}