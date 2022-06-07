public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(String name) {
        
        List<List<sObject>> searchList = [
            FIND :name IN ALL FIELDS
            RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName)
        ];
            
        system.debug(searchList);
        return searchList;
            
    }

}