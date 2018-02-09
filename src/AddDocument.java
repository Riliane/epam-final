import dao.DAOImpl;
import entity.Document;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;

/**
 * Created by Nana on 26.01.2018.
 */
public class AddDocument extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            DAOImpl dao = DAOImpl.getInstance();
            int id = dao.insertDocument(request.getParameter("name"), request.getParameter("author"), request.getParameter("publisher"), request.getParameter("year_of_publishing"),
                    request.getParameter("series"), request.getParameter("periodic_number"), request.getParameter("topic"), request.getParameter("ISBN"));
            response.sendRedirect("/document?id=" + id);
        } catch (ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
        } catch (SQLException e) {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            String sStackTrace = sw.toString();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "SQL error\n" + sStackTrace);
        }
    }
}
