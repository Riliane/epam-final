import dao.DAOImpl;
import view.ShortMsgDisplayer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class Return extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("id") == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } else if (!request.isUserInRole("librarian")) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        } else {
            try {
                DAOImpl dao = DAOImpl.getInstance();
                dao.returnDocument(Integer.parseInt(request.getParameter("id")));
                ShortMsgDisplayer.getInstance().displayMessage("documentReturned", request, response);
            } catch (ClassNotFoundException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
            } catch (SQLException e) {
                ShortMsgDisplayer.getInstance().displayException(response, e, "SQL error");
            }
        }
    }
}
