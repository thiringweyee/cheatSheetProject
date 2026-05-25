package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.CommentBean;

public class CommentRepository {

    public boolean addComment(CommentBean comment) {

        boolean success = false;

        String sql = "INSERT INTO comments "
                   + "(content, users_id, cheatsheets_id, parent_comment_id, status) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try(
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
        ){

            ps.setString(1, comment.getContent());
            ps.setLong(2, comment.getUsers_id());
            ps.setLong(3, comment.getCheatsheets_id());

            if(comment.getParent_comment_id() == null){
                ps.setNull(4, java.sql.Types.BIGINT);
            }else{
                ps.setLong(4, comment.getParent_comment_id());
            }

            ps.setString(5, "active");

            int row = ps.executeUpdate();

            success = row > 0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return success;
    }

    public List<CommentBean> getCommentsByCheatSheetId(long cheatsheetId) {

        List<CommentBean> list = new ArrayList<>();

        String sql = "SELECT c.*, u.name AS userName "
                + "FROM comments c "
                + "JOIN users u "
                + "ON c.users_id = u.id "
                + "WHERE c.cheatsheets_id=? "
                + "AND c.status IN ('active','hidden') "
                + "ORDER BY "
                + "COALESCE(c.parent_comment_id, c.id), "
                + "c.parent_comment_id, "
                + "c.created_at";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, cheatsheetId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CommentBean c = new CommentBean();

                c.setId(rs.getLong("id"));
                c.setContent(rs.getString("content"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setUsers_id(rs.getLong("users_id"));
                c.setCheatsheets_id(rs.getLong("cheatsheets_id"));
                c.setUserName(rs.getString("userName"));

                long parentId = rs.getLong("parent_comment_id");
                if (!rs.wasNull()) {
                    c.setParent_comment_id(parentId);
                }

                c.setStatus(rs.getString("status"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean hideOwnComment(long commentId, long userId) {

        String sql = "UPDATE comments "
                + "SET status='hidden' "
                + "WHERE id=? "
                + "AND users_id=? "
                + "AND status='active'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, commentId);
            ps.setLong(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateOwnComment(long commentId, long userId, String content) {

        String sql = "UPDATE comments "
                + "SET content=? "
                + "WHERE id=? "
                + "AND users_id=? "
                + "AND status='active'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, content);
            ps.setLong(2, commentId);
            ps.setLong(3, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public boolean toggleOwnCommentVisibility(long commentId, long userId) {

        String sql = "UPDATE comments "
                + "SET status = CASE "
                + "WHEN status='active' THEN 'hidden' "
                + "WHEN status='hidden' THEN 'active' "
                + "ELSE status END "
                + "WHERE id=? "
                + "AND users_id=? "
                + "AND status IN ('active','hidden')";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, commentId);
            ps.setLong(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public List<CommentBean> getAllComments() {

        List<CommentBean> list = new ArrayList<>();

        String sql = "SELECT cm.*, "
                + "u.name AS userName, "
                + "c.title AS cheatTitle "
                + "FROM comments cm "
                + "JOIN users u "
                + "ON cm.users_id = u.id "
                + "JOIN cheatsheets c "
                + "ON cm.cheatsheets_id = c.id "
                + "ORDER BY cm.created_at DESC";

        try(
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ){

            while(rs.next()){

                CommentBean cm = new CommentBean();

                cm.setId(rs.getLong("id"));
                cm.setContent(rs.getString("content"));
                cm.setStatus(rs.getString("status"));
                cm.setCreated_at(rs.getTimestamp("created_at"));

                cm.setUsers_id(rs.getLong("users_id"));
                cm.setCheatsheets_id(rs.getLong("cheatsheets_id"));

                cm.setUserName(rs.getString("userName"));
                cm.setCheatTitle(rs.getString("cheatTitle"));

                list.add(cm);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean adminUpdateCommentStatus(long commentId,
            String status){

String sql = "UPDATE comments "
+ "SET status=? "
+ "WHERE id=?";

try(
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(sql);
){

ps.setString(1, status);
ps.setLong(2, commentId);

return ps.executeUpdate() > 0;

}catch(Exception e){
e.printStackTrace();
}

return false;
}

}