package view;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Locale;
import java.util.ResourceBundle;

public class ShortMsgDisplayer {
    private ShortMsgDisplayer(){}
    private static ShortMsgDisplayer instance = new ShortMsgDisplayer();
    public static ShortMsgDisplayer getInstance(){
        return instance;
    }

    public void displayMessage(String message, HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);
        Locale locale = (Locale) session.getAttribute("locale");
        if (locale == null) {
            locale = new Locale("ru", "RU");
            session.setAttribute("locale", locale);
        }
        ResourceBundle bundle = ResourceBundle.getBundle("text", locale);
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html><head>");
        out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
        out.println("<title>Сообщение</title>");
        out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"/style.css\">");
        out.println("</head><body>");
        out.println("div class=\"message\"" + bundle.getString(message) + "</div>");
        out.println("</body></html>");

    }

    public void displayErrorMessage(String message, HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);
        Locale locale = (Locale) session.getAttribute("locale");
        if (locale == null) {
            locale = new Locale("ru", "RU");
            session.setAttribute("locale", locale);
        }
        ResourceBundle bundle = ResourceBundle.getBundle("text", locale);
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html><head>");
        out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
        out.println("<title>" + bundle.getString("error") + "</title>");
        out.println("</head><body>");
        out.println("div class=\"error-message\"" + message + "</div>");
        out.println("</body></html>");
    }

    public void displayException(HttpServletResponse response, Exception e, String message) throws IOException{
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        String sStackTrace = sw.toString();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, message + "\n" + sStackTrace);
    }
}
