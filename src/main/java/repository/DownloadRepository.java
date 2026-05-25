package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;

import model.DownloadBean;

public class DownloadRepository {

    public boolean saveDownload(DownloadBean d) {

        String sql = "INSERT INTO downloads(users_id, cheatsheets_id) VALUES(?, ?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setLong(1, d.getUsers_id());
            ps.setLong(2, d.getCheatsheets_id());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}