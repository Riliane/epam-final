package dao;

import entity.Reader;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReaderListCreator implements ResultListCreator {
    public List<Reader> createResultList(ResultSet rs) throws SQLException {
        List<Reader> list = new ArrayList<>();
        while (rs.next()) {
            Reader reader = new Reader();
            reader.setUsername(rs.getString(1));
            reader.setFirstname(rs.getString(2));
            reader.setLastname(rs.getString(3));
            reader.setDate(rs.getDate(4));
            list.add(reader);
        }
        return list;
    }
}
