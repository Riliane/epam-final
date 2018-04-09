import dao.DAOImpl;
import view.ShortMsgDisplayer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
public class AddLibrarian extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
            try {
                int error = checkInput(request);
                DAOImpl dao = DAOImpl.getInstance();
                if (error != 0) {
                    request.setAttribute("error", error);
                    RequestDispatcher view = request.getRequestDispatcher("addLibrarian.jsp");
                    view.forward(request, response);
                }
                dao.insertLibrarian(request.getParameter("username"), request.getParameter("password"));
                request.setAttribute("username", request.getParameter("username"));
                request.setAttribute("password", request.getParameter("password"));
                RequestDispatcher view = request.getRequestDispatcher("registerSuccess.jsp");
                view.forward(request, response);
            } catch (ClassNotFoundException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
            } catch (SQLException e) {
                ShortMsgDisplayer.getInstance().displayException(response, e, "SQL error");
            } catch (NoSuchAlgorithmException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error encrypting password");
            }
        }

    int checkInput(HttpServletRequest request) throws SQLException, ClassNotFoundException{
        int error = 0;
        if (!request.getParameter("password").equals(request.getParameter("repeat"))) {
            error = 1;
        } else if (!request.getParameter("username").matches("\\S*[a-zA-Z]\\S*")) {
            error = 4;
        } else{
            DAOImpl dao = DAOImpl.getInstance();
            if (!dao.checkUsername(request.getParameter("username"))) {
                error = 3;
            }
        }
        return error;
    }
}
