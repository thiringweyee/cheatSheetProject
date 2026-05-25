package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.UserBean;

public class UserRepository {

    public int insertUser(UserBean obj) {
        int i = 0;
        Connection con = DBConnection.getConnection();
        String sql = "INSERT INTO users(name, email, password, profile_img, role) VALUES(?,?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, obj.getName());
            ps.setString(2, obj.getEmail());
            ps.setString(3, obj.getPassword());
            ps.setString(4, obj.getProfile_img());
            ps.setString(5, obj.getRole());
            i = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Insert failed: " + e.getMessage());
        }
        return i;
    }

    public UserBean login(String email, String password) {
        UserBean ub = null;
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ub = new UserBean();
                ub.setId(rs.getLong("id"));
                ub.setName(rs.getString("name"));
                ub.setEmail(rs.getString("email"));
                ub.setPassword(rs.getString("password"));
                ub.setProfile_img(rs.getString("profile_img"));
                ub.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            System.out.println("Login failed: " + e.getMessage());
        }
        return ub;
    }

    public boolean isEmailExists(String email) {
        boolean exists = false;
        Connection con = DBConnection.getConnection();
        String sql = "SELECT id FROM users WHERE email=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) exists = true;
        } catch (SQLException e) {
            System.out.println("Email check failed: " + e.getMessage());
        }
        return exists;
    }
    
    public UserBean findByEmail(String email) {
        UserBean ub = null;
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE email=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ub = new UserBean();
                ub.setId(rs.getLong("id"));
                ub.setName(rs.getString("name"));
                ub.setEmail(rs.getString("email"));
                ub.setPassword(rs.getString("password")); // hashed password
                ub.setProfile_img(rs.getString("profile_img"));
                ub.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            System.out.println("Find user failed: " + e.getMessage());
        }
        return ub;
    }
    
    public List<UserBean> searchActiveUsers(String keyword, int page, int pageSize) {
        List<UserBean> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM users WHERE role='USER' AND status='active' " +
                     "AND (name LIKE ? OR email LIKE ?) LIMIT ? OFFSET ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setInt(3, pageSize);
            ps.setInt(4, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserBean u = new UserBean();
                u.setId(rs.getLong("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setCreated_at(rs.getTimestamp("created_at"));
                u.setStatus(rs.getString("status"));
                u.setRole(rs.getString("role"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSearchActiveUsers(String keyword) {
        String sql = "SELECT COUNT(*) FROM users WHERE role='USER' AND status='active' " +
                     "AND (name LIKE ? OR email LIKE ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


    
    public boolean softDeleteUser(long id) {
        String sql = "UPDATE users SET status='inactive' WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProfile(UserBean user) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            "UPDATE users SET name=?, email=?, password=?, profile_img=? WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getProfile_img());
            ps.setLong(5, user.getId());

            int row = ps.executeUpdate();

            if(row > 0){
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
}
