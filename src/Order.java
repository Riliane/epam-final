import dao.DAOImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

public class Order extends HttpServlet{
    final int MAX_BORROWS = 3;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("id") == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
        else{
            if (!request.isUserInRole("reader")){
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            }
            else{
                try {
                    DAOImpl dao = DAOImpl.getInstance();
                    int id = Integer.parseInt(request.getRemoteUser());
                    if (dao.getAmountOfBorrows(id) > MAX_BORROWS) {
                        request.setAttribute("error", 1);
                        RequestDispatcher view = request.getRequestDispatcher("order_fail.jsp");
                        view.forward(request, response);
                    }
                    else if (dao.hasOverdue(id)) {
                        request.setAttribute("error", 2);
                        RequestDispatcher view = request.getRequestDispatcher("order_fail.jsp");
                        view.forward(request, response);
                    }
                    else{
                        dao.borrow(id, Integer.parseInt(request.getParameter("id")));
                        PrintWriter out = response.getWriter();
                        out.println("<html><head>");
                        out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
                        out.println("<title>Title</title>");
                        out.println("</head><body>");
                        out.println("Документ успешно заказан");
                        out.println("</body></html>");
                    }
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
        }
    }
}
