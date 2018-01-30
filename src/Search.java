import dao.DAOImpl;
import entity.Document;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Search extends HttpServlet {
    String[] parameters = {"name", "author", "publisher", "year_of_publishing", "series", "periodic_number", "topic", "ISBN"};
    protected void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String criteria = "";
        for (String param : parameters) {
            if (!request.getParameter(param).equals("")){
                if (criteria.equals("")){ criteria = param + " LIKE '%" + request.getParameter(param) + "%'";}
                else {criteria = criteria.concat(" AND " + param + " LIKE '%" + request.getParameter(param) + "%'");}
            }
        }
        DAOImpl dao = DAOImpl.getInstance();
        try{
            List<Document> list = dao.bookSearch(criteria);
            request.setAttribute("list", list);
            RequestDispatcher view = request.getRequestDispatcher("index.jsp");
            view.forward(request, response);

        } catch (ClassNotFoundException e){
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
        }

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        doGet(request,response);
    }
}
