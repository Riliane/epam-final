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
import java.text.SimpleDateFormat;

public class AddReader extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if (!request.getParameter("password").equals(request.getParameter("repeat"))){
            request.setAttribute("error", 1);
            RequestDispatcher view = request.getRequestDispatcher("addReader.jsp");
            view.forward(request, response);
        }
        else {
            try {
                DAOImpl dao = DAOImpl.getInstance();

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String date = request.getParameter("dateofbirth");
                int id = dao.insertReader(request.getParameter("firstname"), request.getParameter("lastname"), request.getParameter("address"),
                        request.getParameter("phone"), sdf.parse(date), request.getParameter("password"));
                request.setAttribute("username", id);
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
            }catch (ParseException e){
                request.setAttribute("error", 2);
                RequestDispatcher view = request.getRequestDispatcher("addReader.jsp");
                view.forward(request, response);
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
