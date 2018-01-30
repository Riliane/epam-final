import dao.DAOImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
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
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<html><head>");
                out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
                out.println("<title>Title</title>");
                out.println("</head><body>");
                out.println("Пользователь удален");
                out.println("</body></html>");
            }catch (ClassNotFoundException e){
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
            }catch (SQLException e){
                StringWriter sw = new StringWriter();
                PrintWriter pw = new PrintWriter(sw);
                e.printStackTrace(pw);
                String sStackTrace = sw.toString();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "SQL error\n" + sStackTrace);
            }catch (NoSuchAlgorithmException e){
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error calculating MD5");
            }
        }
    }
}
