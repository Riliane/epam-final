import dao.DAOImpl;
import view.ShortMsgDisplayer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

public class ChangePassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("id") == null){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
        else if (request.getRemoteUser().equals(request.getParameter("id")) || request.isUserInRole("admin")){
            if (!request.getParameter("password").equals(request.getParameter("repeat"))){
                request.setAttribute("error", 1);
                RequestDispatcher view = request.getRequestDispatcher("changePassword.jsp");
                view.forward(request, response);
            }
            else {
                try {
                    DAOImpl dao = DAOImpl.getInstance();
                    dao.changePassword(request.getParameter("id"), request.getParameter("password"));
                    ShortMsgDisplayer.getInstance().displayMessage("Пароль успешно изменен", response);
                } catch (ClassNotFoundException e) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
                } catch (SQLException e) {
                    StringWriter sw = new StringWriter();
                    PrintWriter pw = new PrintWriter(sw);
                    e.printStackTrace(pw);
                    String sStackTrace = sw.toString();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "SQL error\n" + sStackTrace);
                } catch (NoSuchAlgorithmException e) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error encrypting password");
                }
            }
        } else {response.sendError(HttpServletResponse.SC_FORBIDDEN);}
    }
}
