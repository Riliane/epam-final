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
            } catch (ClassNotFoundException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
            } catch (SQLException e) {
                ShortMsgDisplayer.getInstance().displayException(response, e, "SQL error");
            } catch (NoSuchAlgorithmException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error encrypting password");
            }catch (ParseException e){
                request.setAttribute("error", 2);
                RequestDispatcher view = request.getRequestDispatcher("addReader.jsp");
                view.forward(request, response);
            }
        }
    }
}
