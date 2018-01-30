import dao.DAOImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.ParseException;

/**
 * Created by Nana on 25.01.2018.
 */
public class AddLibrarian extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if (!request.getParameter("password").equals(request.getParameter("repeat"))){
            request.setAttribute("error", 1);
            RequestDispatcher view = request.getRequestDispatcher("addLibrarian.jsp");
            view.forward(request, response);
        }
        else if (!request.getParameter("username").matches("\\S*[a-zA-Z]\\S*")){
            request.setAttribute("error", 4);
            RequestDispatcher view = request.getRequestDispatcher("addLibrarian.jsp");
            view.forward(request, response);
        }
        else {
            try {
                DAOImpl dao = DAOImpl.getInstance();
                if (!dao.checkUsername(request.getParameter("username"))){
                    request.setAttribute("error", 3);
                    RequestDispatcher view = request.getRequestDispatcher("addLibrarian.jsp");
                    view.forward(request, response);
                }
                dao.insertLibrarian(request.getParameter("username"), request.getParameter("password"));
                request.setAttribute("username", request.getParameter("username"));
                request.setAttribute("password", request.getParameter("password"));
                RequestDispatcher view = request.getRequestDispatcher("registerSuccess.jsp");
                view.forward(request, response);
            }catch (ClassNotFoundException e){
                PrintWriter out = response.getWriter();
                out.println("<html><head>");
                out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
                out.println("<title>Title</title>");
                out.println("</head><body>");
                out.println("Error loading driver");
                out.println("</body></html>");
            }catch (SQLException e){
                PrintWriter out = response.getWriter();
                out.println("<html><head>");
                out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
                out.println("<title>Title</title>");
                out.println("</head><body>");
                out.println("SQL error");
                e.printStackTrace(out);
                out.println("</body></html>");
            }catch (NoSuchAlgorithmException e){
                PrintWriter out = response.getWriter();
                out.println("<html><head>");
                out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
                out.println("<title>Title</title>");
                out.println("</head><body>");
                out.println("Error encrypting password");
                out.println("</body></html>");
            }
            }
        }
}
