public class DocumentSearch extends Search {
    public DocumentSearch() {
        super();
        parameters = new String[]{"name", "author", "publisher", "year_of_publishing", "series", "periodic_number", "topic", "ISBN"};
        page = "index.jsp";
        table = "documents";
    }
}
