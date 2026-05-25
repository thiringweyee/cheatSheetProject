package repository;

import java.sql.*;
import java.util.*;
import model.CheatSheetBean;

public class CheatSheetRepository {

    public long createCheatSheet(CheatSheetBean c) {
        long cheatId = 0;

        String sql = "INSERT INTO cheatsheets "
                + "(title, description, code_content, language, visibility, users_id, categories_id, status, publish_status, ban_status) "
                + "VALUES (?, ?, ?, ?, 'PRIVATE', ?, ?, 'active', 'PRIVATE', 'ACTIVE')";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {
            ps.setString(1, c.getTitle());
            ps.setString(2, c.getDescription());
            ps.setString(3, c.getCode_content());
            ps.setString(4, c.getLanguage());
            ps.setLong(5, c.getUsers_id());
            ps.setLong(6, c.getCategories_id());

            int row = ps.executeUpdate();

            if (row > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    cheatId = rs.getLong(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cheatId;
    }

    public void saveTags(long cheatId, String tagsText) {
        if (tagsText == null || tagsText.trim().isEmpty()) return;

        String[] tags = tagsText.split(",");

        for (String tagName : tags) {
            tagName = tagName.trim().toLowerCase();

            if (!tagName.isEmpty()) {
                long tagId = findOrCreateTag(tagName);
                insertCheatSheetTag(cheatId, tagId);
            }
        }
    }

    private long findOrCreateTag(String name) {
        long tagId = 0;

        String findSql = "SELECT id FROM tags WHERE name=? AND status='active'";
        String insertSql = "INSERT INTO tags(name, status) VALUES(?, 'active')";

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement findPs = con.prepareStatement(findSql);
            findPs.setString(1, name);
            ResultSet rs = findPs.executeQuery();

            if (rs.next()) {
                tagId = rs.getLong("id");
            } else {
                PreparedStatement insertPs =
                        con.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);

                insertPs.setString(1, name);
                insertPs.executeUpdate();

                ResultSet keyRs = insertPs.getGeneratedKeys();
                if (keyRs.next()) {
                    tagId = keyRs.getLong(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tagId;
    }

    private void insertCheatSheetTag(long cheatId, long tagId) {
        String sql = "INSERT IGNORE INTO cheatsheets_tags(tags_id, cheatsheets_id) VALUES(?, ?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, tagId);
            ps.setLong(2, cheatId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<CheatSheetBean> getPublicCheatSheets() {
        List<CheatSheetBean> list = new ArrayList<>();

        String sql = "SELECT c.*, u.name AS author_name, ca.name AS category_name "
                + "FROM cheatsheets c "
                + "JOIN users u ON c.users_id = u.id "
                + "JOIN categories ca ON c.categories_id = ca.id "
                + "WHERE c.status='active' "
                + "AND c.visibility='PUBLIC' "
                + "AND c.publish_status='APPROVED' "
                + "AND c.ban_status='ACTIVE' "
                + "ORDER BY c.created_at DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
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

    public List<CheatSheetBean> getMyCheatSheets(long userId) {
        List<CheatSheetBean> list = new ArrayList<>();

        String sql = "SELECT c.*, u.name AS author_name, ca.name AS category_name "
                + "FROM cheatsheets c "
                + "JOIN users u ON c.users_id = u.id "
                + "JOIN categories ca ON c.categories_id = ca.id "
                + "WHERE c.status='active' AND c.users_id=? "
                + "ORDER BY c.created_at DESC";

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

    public CheatSheetBean getCheatSheetById(long id) {
        CheatSheetBean c = null;

        String sql = "SELECT c.*, u.name AS author_name, ca.name AS category_name "
                + "FROM cheatsheets c "
                + "JOIN users u ON c.users_id = u.id "
                + "JOIN categories ca ON c.categories_id = ca.id "
                + "WHERE c.id=? \n"
                + "AND c.status='active'\n"
                + "AND c.ban_status='ACTIVE'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = mapCheatSheet(rs);
                List<String> tags = getTagsByCheatSheetId(id);
                c.setTagList(tags);
                c.setTagsText(String.join(", ", tags));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }

    public boolean updateCheatSheet(CheatSheetBean c) {
        boolean status = false;

        String sql = "UPDATE cheatsheets "
                + "SET title=?, description=?, code_content=?, language=?, "
                + "categories_id=? "
                + "WHERE id=? "
                + "AND users_id=? "
                + "AND ban_status='ACTIVE' "
                + "AND publish_status!='APPROVED'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, c.getTitle());
            ps.setString(2, c.getDescription());
            ps.setString(3, c.getCode_content());
            ps.setString(4, c.getLanguage());
            ps.setLong(5, c.getCategories_id());
            ps.setLong(6, c.getId());
            ps.setLong(7, c.getUsers_id());

            status = ps.executeUpdate() > 0;

            if (status) {
                deleteTagsByCheatSheetId(c.getId());
                saveTags(c.getId(), c.getTagsText());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public boolean softDeleteCheatSheet(long id, long userId) {
        String sql = "UPDATE cheatsheets SET status='inactive' WHERE id=? AND users_id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, id);
            ps.setLong(2, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean requestPublish(long id, long userId) {
        String sql = "UPDATE cheatsheets "
                + "SET publish_status='PENDING', visibility='PRIVATE' "
                + "WHERE id=? AND users_id=? "
                + "AND status='active' "
                + "AND ban_status='ACTIVE' "
                + "AND publish_status IN ('PRIVATE','REJECTED')";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, id);
            ps.setLong(2, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

            public List<CheatSheetBean> getPendingCheatSheets() {
                List<CheatSheetBean> list = new ArrayList<>();

                String sql = "SELECT c.*, u.name AS author_name, ca.name AS category_name "
                        + "FROM cheatsheets c "
                        + "JOIN users u ON c.users_id = u.id "
                        + "JOIN categories ca ON c.categories_id = ca.id "
                        + "WHERE c.status='active' AND c.publish_status='PENDING' "
                        + "AND c.ban_status='ACTIVE' "
                        + "ORDER BY c.created_at DESC";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()
                ) {
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

            public boolean approveCheatSheet(long id) {
                String sql = "UPDATE cheatsheets "
                        + "SET visibility='PUBLIC', publish_status='APPROVED' "
                        + "WHERE id=? "
                        + "AND status='active' "
                        + "AND ban_status='ACTIVE' "
                        + "AND publish_status='PENDING'";

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

            public boolean rejectCheatSheet(long id) {
                String sql = "UPDATE cheatsheets "
                        + "SET visibility='PRIVATE', publish_status='REJECTED' "
                        + "WHERE id=? "
                        + "AND status='active' "
                        + "AND ban_status='ACTIVE' "
                        + "AND publish_status='PENDING'";

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

            public void increaseViewCount(long id) {
                String sql = "UPDATE cheatsheets SET view_count = view_count + 1 WHERE id=?";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {
                    ps.setLong(1, id);
                    ps.executeUpdate();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            private void deleteTagsByCheatSheetId(long cheatId) {
                String sql = "DELETE FROM cheatsheets_tags WHERE cheatsheets_id=?";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {
                    ps.setLong(1, cheatId);
                    ps.executeUpdate();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            private List<String> getTagsByCheatSheetId(long cheatId) {
                List<String> tags = new ArrayList<>();

                String sql = "SELECT t.name FROM tags t "
                        + "JOIN cheatsheets_tags ct ON t.id = ct.tags_id "
                        + "WHERE ct.cheatsheets_id=? AND t.status='active'";

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
                c.setBan_status(rs.getString("ban_status"));
                c.setAuthorName(rs.getString("author_name"));
                c.setCategoryName(rs.getString("category_name"));

                return c;
            }
            
            public List<CheatSheetBean> getPublicCheatSheetsByCategory(long categoryId) {
                List<CheatSheetBean> list = new ArrayList<>();

                String sql = "SELECT c.*, u.name AS author_name, ca.name AS category_name "
                        + "FROM cheatsheets c "
                        + "JOIN users u ON c.users_id = u.id "
                        + "JOIN categories ca ON c.categories_id = ca.id "
                        + "WHERE c.status='active' "
                        + "AND c.visibility='PUBLIC' "
                        + "AND c.publish_status='APPROVED' "
                        + "AND c.ban_status='ACTIVE' "
                        + "AND c.categories_id=? "
                        + "ORDER BY c.created_at DESC";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {
                    ps.setLong(1, categoryId);

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
            
            public List<CheatSheetBean> getPublicCheatSheetsByTag(String tagName) {
                List<CheatSheetBean> list = new ArrayList<>();

                String sql = "SELECT c.*, u.name AS author_name, ca.name AS category_name "
                        + "FROM cheatsheets c "
                        + "JOIN users u ON c.users_id = u.id "
                        + "JOIN categories ca ON c.categories_id = ca.id "
                        + "JOIN cheatsheets_tags ct ON c.id = ct.cheatsheets_id "
                        + "JOIN tags t ON ct.tags_id = t.id "
                        + "WHERE c.status='active' "
                        + "AND c.visibility='PUBLIC' "
                        + "AND c.publish_status='APPROVED' "
                        + "AND c.ban_status='ACTIVE' "
                        + "AND t.status='active' "
                        + "AND t.name=? "
                        + "ORDER BY c.created_at DESC";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {
                    ps.setString(1, tagName.toLowerCase());

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
            
            public boolean makePrivate(long cheatId, long userId) {
                String sql = "UPDATE cheatsheets "
                        + "SET visibility='PRIVATE', publish_status='PRIVATE' "
                        + "WHERE id=? AND users_id=? AND status='active'";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {
                    ps.setLong(1, cheatId);
                    ps.setLong(2, userId);
                    return ps.executeUpdate() > 0;

                } catch (Exception e) {
                    e.printStackTrace();
                }

                return false;
            }
            
            public List<CheatSheetBean> searchPublicCheatSheetsByTagPrefix(String keyword) {

                List<CheatSheetBean> list = new ArrayList<>();

                String sql = "SELECT DISTINCT c.*, u.name AS author_name, ca.name AS category_name "
                        + "FROM cheatsheets c "
                        + "JOIN users u ON c.users_id = u.id "
                        + "JOIN categories ca ON c.categories_id = ca.id "
                        + "JOIN cheatsheets_tags ct ON c.id = ct.cheatsheets_id "
                        + "JOIN tags t ON ct.tags_id = t.id "
                        + "WHERE c.status='active' "
                        + "AND c.visibility='PUBLIC' "
                        + "AND c.publish_status='APPROVED' "
                        + "AND c.ban_status='ACTIVE' "
                        + "AND t.status='active' "
                        + "AND t.name LIKE ? "
                        + "ORDER BY c.created_at DESC";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {
                    ps.setString(1, keyword.toLowerCase() + "%");

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
            
            public List<CheatSheetBean> getPopularCheatSheets() {

                List<CheatSheetBean> list = new ArrayList<>();

                String sql = "SELECT c.*, u.name AS author_name, ca.name AS category_name "
                        + "FROM cheatsheets c "
                        + "JOIN users u ON c.users_id = u.id "
                        + "JOIN categories ca ON c.categories_id = ca.id "
                        + "WHERE c.status='active' "
                        + "AND c.visibility='PUBLIC' "
                        + "AND c.publish_status='APPROVED' "
                        + "AND c.ban_status='ACTIVE' "
                        + "ORDER BY c.view_count DESC, c.download_count DESC, c.created_at DESC "
                        + "LIMIT 20";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()
                ) {

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
            
            public List<CheatSheetBean> getAllCheatSheetRecords() {
                List<CheatSheetBean> list = new ArrayList<>();

                String sql = "SELECT c.*, "
                        + "u.name AS author_name, "
                        + "cat.name AS category_name "
                        + "FROM cheatsheets c "
                        + "JOIN users u ON c.users_id = u.id "
                        + "JOIN categories cat ON c.categories_id = cat.id "
                        + "WHERE c.visibility='PUBLIC' "
                        + "AND c.status='active' "
                        + "ORDER BY c.created_at DESC";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()
                ) {
                    while (rs.next()) {
                        CheatSheetBean c = mapCheatSheet(rs);
                        list.add(c);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }

                return list;
            }

            public boolean updateBanStatus(long id, String banStatus) {
                String sql = "UPDATE cheatsheets SET ban_status=? WHERE id=?";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {
                    ps.setString(1, banStatus);
                    ps.setLong(2, id);

                    return ps.executeUpdate() > 0;

                } catch (Exception e) {
                    e.printStackTrace();
                }

                return false;
            }
            
            public CheatSheetBean getCheatSheetByIdForAdmin(long id) {

                CheatSheetBean c = null;

                String sql = "SELECT c.*, "
                        + "u.name AS author_name, "
                        + "ca.name AS category_name "
                        + "FROM cheatsheets c "
                        + "JOIN users u ON c.users_id = u.id "
                        + "JOIN categories ca ON c.categories_id = ca.id "
                        + "WHERE c.id=? "
                        + "AND c.status='active'";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {

                    ps.setLong(1, id);

                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {

                        c = mapCheatSheet(rs);

                        List<String> tags =
                                getTagsByCheatSheetId(id);

                        c.setTagList(tags);

                        c.setTagsText(
                                String.join(", ", tags)
                        );
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }

                return c;
            }
            
            public boolean increaseDownloadCount(long cheatId) {

                String sql = "UPDATE cheatsheets "
                        + "SET download_count = download_count + 1 "
                        + "WHERE id=? "
                        + "AND status='active' "
                        + "AND ban_status='ACTIVE'";

                try (
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql)
                ) {
                    ps.setLong(1, cheatId);
                    return ps.executeUpdate() > 0;

                } catch (Exception e) {
                    e.printStackTrace();
                }

                return false;
            }
        }