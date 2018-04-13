package dao;

import entity.BorrowRecord;
import entity.Document;
import entity.Reader;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Nana on 13.04.2018.
 */
public class BorrowListCreator implements ResultListCreator {
    String parameter;

    private BorrowListCreator() {
    }

    BorrowListCreator(String p) {
        parameter = p;
    }

    public List<BorrowRecord> createResultList(ResultSet rs) throws SQLException {
        List<BorrowRecord> list = new ArrayList<>();
        while (rs.next()) {
            BorrowRecord record = new BorrowRecord();
            if (parameter.equals("documents")) {
                Document document = new Document();
                document.setId(rs.getInt(1));
                document.setName(rs.getString(2));
                document.setAuthor(rs.getString(3));
                record.setDocument(document);
            } else if (parameter.equals("readers")) {
                Reader reader = new Reader();
                reader.setUsername(rs.getString(1));
                reader.setFirstname(rs.getString(2));
                reader.setLastname(rs.getString(3));
                record.setReader(reader);
            }
            record.setDateOfBorrow(rs.getDate("date_of_borrow"));
            record.setDateOfReturn(rs.getDate("date_of_return"));
            list.add(record);
        }
        return list;
    }
}
