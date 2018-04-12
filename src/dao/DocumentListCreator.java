package dao;

import entity.Document;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DocumentListCreator implements ResultListCreator {

    @Override
    public List<Document> createResultList(ResultSet rs) throws SQLException {
        List<Document> list = new ArrayList<>();
        while (rs.next()) {
            Document document = new Document();
            document.setId(rs.getInt(1));
            document.setName(rs.getString(2));
            document.setAuthor(rs.getString(3));
            document.setYear(rs.getInt(4));
            list.add(document);
        }
        return list;
    }
}
