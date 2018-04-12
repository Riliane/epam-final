package dao;

import entity.Document;
import entity.Reader;
import entity.User;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.*;
import org.apache.log4j.Logger;

public class DAOImpl {
    public static final String PASSWORD = "********";
    private static DAOImpl instance = new DAOImpl();
    public static DAOImpl getInstance(){
        return instance;
    }

    private DAOImpl() {
        columnMap.put("documents", "document_id, name, author, year_of_publishing");
        columnMap.put("readers", "reader_id, first_name, last_name, date_of_birth");
        creatorMap.put("documents", new DocumentListCreator());
        creatorMap.put("readers", new ReaderListCreator());
    }

    static final Logger logger = Logger.getLogger(DAOImpl.class);

    final String DB_URL = "jdbc:mysql://127.0.0.1:3306/library_db?useUnicode=true&characterEncoding=UTF-8";
    Connection con = null;
    Map<String, String> columnMap = new HashMap<>();
    Map<String, ResultListCreator> creatorMap = new HashMap<>();

    public List search(String criteria, String table) throws SQLException, ClassNotFoundException {
        Statement st = null;
        ResultSet rs = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT " + columnMap.get(table) + " FROM " + table;
        if (!criteria.equals("")) {
            query = query.concat(" WHERE " + criteria);
        }
        rs = st.executeQuery(query);
        ResultListCreator creator = creatorMap.get(table);
        List list = creator.createResultList(rs);
        st.close();
        rs.close();
        return list;
    }
    public Document getDocument(int id) throws SQLException, ClassNotFoundException{
        Document doc = null;
        Statement st = null;
        ResultSet rs = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT * FROM documents WHERE document_id = " + id;
        logger.info("Query: " + query);
        rs = st.executeQuery(query);
        while (rs.next()){
            doc = new Document();
            doc.setId(rs.getInt(1));
            doc.setName(rs.getString(2));
            doc.setAuthor(rs.getString(3));
            doc.setPublisher(rs.getString(4));
            doc.setYear(rs.getInt(5));
            doc.setSeries(rs.getString(6));
            doc.setPeriodicNumber(rs.getString(7));
            doc.setTopic(rs.getString(8));
            doc.setIsbn(rs.getLong(9));
            doc.setRepaired(rs.getBoolean(10));
        }
        st.close();
        rs.close();
        return doc;
    }

    public User getUser(String id) throws SQLException, ClassNotFoundException{
        User user = new User();
        Statement st = null;
        ResultSet rs = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT username, role FROM accounts WHERE username = '" + id + "'";
        logger.info("Query: " + query);
        rs = st.executeQuery(query);
        if (!rs.next()) {return null;}
        if (rs.getString(2).equals("reader")){
            user = getReader(id);
        }
        else{
        user.setUsername(rs.getString(1));
        user.setRole(rs.getString(2));
        }
        st.close();
        rs.close();
        return user;
    }

    public Reader getReader(String id) throws SQLException, ClassNotFoundException{
        Reader reader = new Reader();
        Statement st = null;
        ResultSet rs = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT * FROM readers WHERE reader_id = " + id;
        logger.info("Query: " + query);
        rs = st.executeQuery(query);
        if (!rs.next()) {return null;}
        reader.setUsername(rs.getString(1));
        reader.setFirstname(rs.getString(2));
        reader.setLastname(rs.getString(3));
        reader.setDate(rs.getDate(4));
        reader.setAddress(rs.getString(5));
        reader.setPhone(rs.getString(6));
        reader.setRole("reader");
        st.close();
        rs.close();
        return reader;
    }

    public int getAmountOfBorrows(int id) throws SQLException, ClassNotFoundException{
        int count = 0;
        Statement st = null;
        ResultSet rs = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT COUNT(*) FROM current_borrows WHERE reader = " + id;
        logger.info("Query: " + query);
        rs = st.executeQuery(query);
        while (rs.next()){
            count = rs.getInt(1);
        }
        st.close();
        rs.close();
        return count;
    }

    public boolean hasOverdue(int id) throws SQLException, ClassNotFoundException{
        int count = 0;
        Statement st = null;
        ResultSet rs = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT COUNT(*) FROM current_borrows WHERE reader = " + id + " AND date_of_return < CURRENT_DATE()";
        logger.info("Query: " + query);
        rs = st.executeQuery(query);
        while (rs.next()){
            count = rs.getInt(1);
        }
        st.close();
        rs.close();
        return (count != 0);
    }

    public boolean isBorrowed (int id) throws SQLException, ClassNotFoundException{
        int count = 0;
        Statement st = null;
        ResultSet rs = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT COUNT(*) FROM current_borrows WHERE document = " + id;
        logger.info("Query: " + query);
        rs = st.executeQuery(query);
        while (rs.next()){
            count = rs.getInt(1);
        }
        st.close();
        rs.close();
        return count != 0;
    }

    public void borrow(int reader_id, int document_id) throws SQLException, ClassNotFoundException{
        Statement st = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "INSERT INTO current_borrows (id, document, reader, date_of_borrow, date_of_return) VALUE (NULL, " + document_id + ", " + reader_id + ", CURRENT_DATE(), CURRENT_DATE() + INTERVAL 14 DAY )";
        logger.info("Query: " + query);
        st.executeUpdate(query);
        st.close();
    }

    public boolean checkUsername (String username) throws SQLException, ClassNotFoundException{
        int count = 0;
        Statement st = null;
        ResultSet rs = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT COUNT(*) FROM accounts WHERE username = '" + username + "'";
        logger.info("Query: " + query);
        rs = st.executeQuery(query);
        while (rs.next()){
            count = rs.getInt(1);
        }
        st.close();
        rs.close();
        return (count == 0);
    }

    public int insertReader(String firstname, String lastname, String address, String phone, java.util.Date date, String password) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException{
        PreparedStatement st = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        String query = "INSERT INTO readers (reader_id, first_name, last_name, date_of_birth, address, phone) VALUE (NULL, '" + firstname + "', '" + lastname + "', ?, '" + address + "', '" + phone + "')";
        logger.info("Query: " + query);
        st = con.prepareStatement(query);
        logger.info("Date: " + date);
        st.setDate(1, new java.sql.Date( date.getTime() ));
        st.executeUpdate();
        st.close();
        Statement st2 = con.createStatement();
        String query2 = "SELECT LAST_INSERT_ID()";
        logger.info("Query: " + query2);
        ResultSet rs = st2.executeQuery(query2);
        int id = 0;
        while (rs.next()){
            id = rs.getInt(1);
        }
        insertUser(Integer.toString(id), password, "reader");
        st2.close();
        rs.close();
        return id;
    }

    public void insertLibrarian (String username, String password) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException { insertUser(username, password, "librarian");}

    private void insertUser(String username, String password, String role) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException{
        Statement st = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String digested = md5digest(password);
        String query = "INSERT INTO accounts (username, password, role) VALUE ('" + username + "', '"+ digested +"', '" + role +"');";
        logger.info("Query: " + query);
        st.executeUpdate(query);
        st.close();
    }

    public void changePassword(String username, String password) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException{
        Statement st = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String digested = md5digest(password);
        String query = "UPDATE accounts SET password = '"+ digested + "' WHERE username = '" + username +"'";
        logger.info("Query: " + query);
        st.executeUpdate(query);
        st.close();
    }

    public void deleteUser(String username) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException{
        Statement st = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "SELECT role FROM accounts WHERE username = '" + username +"'";
        logger.info("Query: " + query);
        ResultSet rs = st.executeQuery(query);
        rs.next();
        if (rs.getString(1).equals("reader")){
            query = "DELETE FROM readers WHERE reader_id = '" + username +"'";
        } else {
            query = "DELETE FROM accounts WHERE username = '" + username +"'";
        }
        rs.close();
        logger.info("Query: " + query);
        st.executeUpdate(query);
        st.close();
    }


    private String md5digest (String original) throws NoSuchAlgorithmException{
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(original.getBytes());
        byte[] digest = md.digest();
        StringBuffer sb = new StringBuffer();
        for (byte b : digest) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }

    public int insertDocument (String name, String author, String publisher, String year_of_publishing, String series, String periodic_number, String topic, String isbn) throws SQLException, ClassNotFoundException{
        Statement st = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query = "INSERT INTO documents (document_id, name, author, publisher, year_of_publishing";
        String query2 = " VALUES (NULL, '" + name +"', '" + author +"', '" + publisher +"', " + year_of_publishing;
        if (!series.equals("")){
            query = query.concat(", series");
            query2 = query2.concat(", '" + series + "'");
        }
        if (!periodic_number.equals("")){
            query = query.concat(", periodic_number");
            query2 = query2.concat(", " + periodic_number);
        }
        if (!topic.equals("")){
            query = query.concat(", topic");
            query2 = query2.concat(", '" + topic + "'");
        }
        if (!isbn.equals("")){
            query = query.concat(", isbn");
            query2 = query2.concat(", " + isbn + "");
        }
        query = query.concat(", is_repaired)");
        query2 = query2.concat(", FALSE)");
        query = query.concat(query2);
        logger.info("Query: " + query);
        st.executeUpdate(query);
        query2 = "SELECT LAST_INSERT_ID()";
        logger.info("Query: " + query2);
        ResultSet rs = st.executeQuery(query2);
        int id = 0;
        while (rs.next()){
            id = rs.getInt(1);
        }
        rs.close();
        st.close();
        return id;
    }

    public void updateDocument (int id, String action) throws SQLException, ClassNotFoundException{
        Statement st = null;
        Class.forName("org.gjt.mm.mysql.Driver");
        if (con == null) {con = DriverManager.getConnection(DB_URL, "root", PASSWORD);}
        st = con.createStatement();
        String query;
        if (action.equals("return")){
            query = "DELETE FROM current_borrows WHERE document = "+ id;
            logger.info("Query: " + query);
            st.executeUpdate(query);}
        if (action.equals("delete")){
            query = "DELETE FROM documents WHERE document_id = "+ id;
            logger.info("Query: " + query);
            st.executeUpdate(query);}
        if (action.equals("repair true")){
            query = "UPDATE documents SET is_repaired = TRUE WHERE document_id = "+ id;
            logger.info("Query: " + query);
            st.executeUpdate(query);}
        if (action.equals("repair false")){
            query = "UPDATE documents SET is_repaired = FALSE WHERE document_id = "+ id;
            logger.info("Query: " + query);
            st.executeUpdate(query);}

        st.close();
    }

    public void returnDocument(int id)throws SQLException, ClassNotFoundException{ updateDocument(id, "return");}

    public void deleteDocument (int id) throws SQLException, ClassNotFoundException{
        updateDocument(id, "delete");
    }

    public void repairDocument (int id, boolean set) throws SQLException, ClassNotFoundException{
        if (set){
            updateDocument(id, "repair true");
        }
        updateDocument(id, "repair false");
    }
}
