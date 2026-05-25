package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.CheatSheetBean;

public class FavoriteRepository {

    public boolean isFavorited(long userId, long cheatId) {

        String sql = "SELECT 1 FROM favorites "
                + "WHERE users_id=? "
                + "AND cheatsheets_id=? "
                + "AND status='active'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, userId);
            ps.setLong(2, cheatId);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean toggleFavorite(long userId, long cheatId) {

        if (existsFavorite(userId, cheatId)) {

            if (isFavorited(userId, cheatId)) {
                return makeInactive(userId, cheatId);
            }

            return makeActive(userId, cheatId);
        }

        return insertFavorite(userId, cheatId);
    }

    private boolean existsFavorite(long userId, long cheatId) {

        String sql = "SELECT 1 FROM favorites "
                + "WHERE users_id=? "
                + "AND cheatsheets_id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, userId);
            ps.setLong(2, cheatId);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private boolean insertFavorite(long userId, long cheatId) {

        String sql = "INSERT INTO favorites "
                + "(users_id, cheatsheets_id, status) "
                + "VALUES (?, ?, 'active')";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, userId);
            ps.setLong(2, cheatId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private boolean makeActive(long userId, long cheatId) {

        String sql = "UPDATE favorites "
                + "SET status='active' "
                + "WHERE users_id=? "
                + "AND cheatsheets_id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, userId);
            ps.setLong(2, cheatId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private boolean makeInactive(long userId, long cheatId) {

        String sql = "UPDATE favorites "
                + "SET status='inactive' "
                + "WHERE users_id=? "
                + "AND cheatsheets_id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, userId);
            ps.setLong(2, cheatId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public int getFavoriteCount(long cheatId) {

        String sql = "SELECT COUNT(*) FROM favorites "
                + "WHERE cheatsheets_id=? "
                + "AND status='active'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, cheatId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<CheatSheetBean> getMyFavoriteCheatSheets(long userId) {

        List<CheatSheetBean> list = new ArrayList<>();

        String sql = "SELECT c.*, u.name AS author_name, ca.name AS category_name "
                + "FROM favorites f "
                + "JOIN cheatsheets c ON f.cheatsheets_id = c.id "
                + "JOIN users u ON c.users_id = u.id "
                + "JOIN categories ca ON c.categories_id = ca.id "
                + "WHERE f.users_id=? "
                + "AND f.status='active' "
                + "AND c.status='active' "
                + "AND c.visibility='PUBLIC' "
                + "AND c.publish_status='APPROVED' "
                + "ORDER BY f.created_at DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CheatSheetBean c = mapCheatSheet(rs);
                c.setTagList(getTagsByCheatSheetId(c.getId()));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    private CheatSheetBean mapCheatSheet(ResultSet rs) throws SQLException {

        CheatSheetBean c = new CheatSheetBean();

        c.setId(rs.getLong("id"));
        c.setTitle(rs.getString("title"));
        c.setDescription(rs.getString("description"));
        c.setCode_content(rs.getString("code_content"));
        c.setLanguage(rs.getString("language"));
        c.setVisibility(rs.getString("visibility"));
        c.setView_count(rs.getInt("view_count"));
        c.setDownload_count(rs.getInt("download_count"));
        c.setCreated_at(rs.getTimestamp("created_at"));
        c.setUpdated_at(rs.getTimestamp("updated_at"));
        c.setUsers_id(rs.getLong("users_id"));
        c.setCategories_id(rs.getLong("categories_id"));
        c.setStatus(rs.getString("status"));
        c.setPublish_status(rs.getString("publish_status"));
        c.setAuthorName(rs.getString("author_name"));
        c.setCategoryName(rs.getString("category_name"));

        return c;
    }

    private List<String> getTagsByCheatSheetId(long cheatId) {

        List<String> tags = new ArrayList<>();

        String sql = "SELECT t.name FROM tags t "
                + "JOIN cheatsheets_tags ct ON t.id = ct.tags_id "
                + "WHERE ct.cheatsheets_id=? "
                + "AND t.status='active'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, cheatId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                tags.add(rs.getString("name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tags;
    }
}