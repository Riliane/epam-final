import dao.DAOImpl;
import entity.Document;
import view.ShortMsgDisplayer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class DocumentInfo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOImpl dao = DAOImpl.getInstance();
        try {
            if (request.getParameter("id") == null){
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No user ID specified");
            }
            else{
                Document doc = dao.getDocument(Integer.parseInt(request.getParameter("id")));
                request.setAttribute("doc", doc);
                request.setAttribute("isBorrowed", dao.isBorrowed(Integer.parseInt(request.getParameter("id"))));
                RequestDispatcher view = request.getRequestDispatcher("documentInfo.jsp");
                view.forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
        } catch (SQLException e) {
            ShortMsgDisplayer.getInstance().displayException(response, e, "SQL error");
        }
    }
}
