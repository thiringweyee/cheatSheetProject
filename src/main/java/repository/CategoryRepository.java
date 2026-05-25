package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.CategoryBean;

public class CategoryRepository {

    // Create
    public int insertCategory(CategoryBean c) {

        int result = 0;

        String sql = "INSERT INTO categories(name) VALUES(?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, c.getName());

            result = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Read All
    public List<CategoryBean> getAllCategories() {

        List<CategoryBean> list = new ArrayList<>();

        String sql = "SELECT * FROM categories WHERE status='active'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while(rs.next()) {

                CategoryBean c = new CategoryBean();

                c.setId(rs.getLong("id"));
                c.setName(rs.getString("name"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setStatus(rs.getString("status"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
    }
        return list;
    }
    
 // Find By Id
    public CategoryBean findById(long id) {

        CategoryBean c = null;

        String sql = "SELECT * FROM categories WHERE id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setLong(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                c = new CategoryBean();

                c.setId(rs.getLong("id"));
                c.setName(rs.getString("name"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }
    
    // Update
    public boolean updateCategory(CategoryBean c) {

        String sql = "UPDATE categories SET name=? WHERE id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, c.getName());
            ps.setLong(2, c.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Soft Delete
    public boolean deleteCategory(long id) {

        String sql = "UPDATE categories SET status='inactive' WHERE id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setLong(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    public String getCategoryNameById(long id) {

        String name = null;

        String sql = "SELECT name FROM categories WHERE id=? AND status='active'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return name;
    }
}
