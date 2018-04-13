import dao.DAOImpl;
import entity.BorrowRecord;
import entity.User;
import view.ShortMsgDisplayer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class UserInfo extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    DAOImpl dao = DAOImpl.getInstance();
    try {
        if (request.getParameter("id") == null){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No user ID specified");
        }
        else{
            User user = dao.getUser(request.getParameter("id"));
            request.setAttribute("user", user);
            if (user.getRole().equals("reader")) {
                List<BorrowRecord> currentList = dao.getBorrows(user.getUsername(), "current_borrows", "documents");
                request.setAttribute("currentList", currentList);
                List<BorrowRecord> archiveList = dao.getBorrows(user.getUsername(), "archive", "documents");
                request.setAttribute("archiveList", archiveList);
            }

            RequestDispatcher view = request.getRequestDispatcher("userInfo.jsp");
            view.forward(request, response);
        }
    }catch (ClassNotFoundException e){
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
    }catch (SQLException e){
        ShortMsgDisplayer.getInstance().displayException(response, e, "SQL error");
    }
}
}
