package view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class ShortMsgDisplayer {
    private ShortMsgDisplayer(){}
    private static ShortMsgDisplayer instance = new ShortMsgDisplayer();
    public static ShortMsgDisplayer getInstance(){
        return instance;
    }

    public void displayMessage(String message, HttpServletResponse response) throws IOException{
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html><head>");
        out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
        out.println("<title>Сообщение</title>");
        out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"/style.css\">");
        out.println("</head><body>");
        out.println("div class=\"message\"" + message + "</div>");
        out.println("</body></html>");

    }
    public void displayErrorMessage(String message, HttpServletResponse response) throws IOException{
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html><head>");
        out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
        out.println("<title>Ошибка</title>");
        out.println("</head><body>");
        out.println("div class=\"error-message\"" + message + "</div>");
        out.println("</body></html>");
    }
}
