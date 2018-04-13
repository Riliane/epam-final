package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public interface ResultListCreator {
    public List createResultList(ResultSet rs) throws SQLException;
}
