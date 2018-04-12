import dao.DAOImpl;
import view.ShortMsgDisplayer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

public class DeleteUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("id") == null){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
        if (!request.isUserInRole("admin")){
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
        else{
            try {
                DAOImpl dao = DAOImpl.getInstance();
                dao.deleteUser(request.getParameter("id"));
                ShortMsgDisplayer.getInstance().displayMessage("userDeleted", request, response);
            }catch (ClassNotFoundException e){
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
            }catch (SQLException e){
                ShortMsgDisplayer.getInstance().displayException(response, e, "SQL error");
            }catch (NoSuchAlgorithmException e){
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error calculating MD5");
            }
        }
    }
}
