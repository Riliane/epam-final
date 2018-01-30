import dao.DAOImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Created by Nana on 26.01.2018.
 */
public class RepairDocument extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("id") == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } else if (!request.isUserInRole("librarian")) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        } else {
            try {
                DAOImpl dao = DAOImpl.getInstance();
                dao.repairDocument(Integer.parseInt(request.getParameter("id")), Boolean.parseBoolean(request.getParameter("set")));
                response.sendRedirect("document?id="+ request.getParameter("id"));
            } catch (ClassNotFoundException e) {
                PrintWriter out = response.getWriter();
                out.println("<html><head>");
                out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
                out.println("<title>Title</title>");
                out.println("</head><body>");
                out.println("Error loading driver");
                out.println("</body></html>");
            } catch (SQLException e) {
                PrintWriter out = response.getWriter();
                out.println("<html><head>");
                out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
                out.println("<title>Title</title>");
                out.println("</head><body>");
                out.println("SQL error");
                e.printStackTrace(out);
                out.println("</body></html>");
            }
        }
    }
}
