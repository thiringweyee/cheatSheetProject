package model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserBean {
    private long id;
    private String name;
    private String email;
    private String password;
    private String profile_img;
    private Timestamp created_at;
    private String status;
    private String role;
}
