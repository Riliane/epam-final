public class ReaderSearch extends Search {
    public ReaderSearch() {
        super();
        parameters = new String[]{"first_name", "last_name", "date_of_birth", "address", "phone"};
        page = "/admin/admin.jsp";
        table = "readers";
    }
}
