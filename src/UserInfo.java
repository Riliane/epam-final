import dao.DAOImpl;
import entity.Document;
import entity.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;

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
            RequestDispatcher view = request.getRequestDispatcher("userInfo.jsp");
            view.forward(request, response);
        }
    }catch (ClassNotFoundException e){
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
    }catch (SQLException e){
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        String sStackTrace = sw.toString();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "SQL error\n" + sStackTrace);
    }
}
}
