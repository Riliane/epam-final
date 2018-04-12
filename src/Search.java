import dao.DAOImpl;
import entity.Document;
import view.ShortMsgDisplayer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public abstract class Search extends HttpServlet {
    String[] parameters;
    String page;
    String table;
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
            List list = dao.search(criteria, table);
            request.setAttribute("list", list);
            RequestDispatcher view = request.getRequestDispatcher(page);
            view.forward(request, response);

        } catch (ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading SQL connection driver");
        } catch (SQLException e) {
            ShortMsgDisplayer.getInstance().displayException(response, e, "SQL error");
        }

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        doGet(request,response);
    }
}
