import dao.DAOImpl;
import entity.BorrowRecord;
import entity.Document;
import view.ShortMsgDisplayer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

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
                List<BorrowRecord> currentList = dao.getBorrows(Integer.toString(doc.getId()), "current_borrows", "readers");
                List<BorrowRecord> archiveList = dao.getBorrows(Integer.toString(doc.getId()), "archive", "readers");
                request.setAttribute("doc", doc);
                request.setAttribute("currentList", currentList);
                request.setAttribute("archiveList", archiveList);
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
