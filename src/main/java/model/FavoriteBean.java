package model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FavoriteBean {

    private long users_id;

    private long cheatsheets_id;

    private Timestamp created_at;

    private String status;
}