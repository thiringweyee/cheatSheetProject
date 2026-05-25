package model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CategoryBean {

    private long id;
    private String name;
    private Timestamp created_at;
    private String status;
}