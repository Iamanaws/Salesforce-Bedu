public class AddPrimaryContact implements Queueable {
    
    Contact contact;
    String stateAbv;
    
    public AddPrimaryContact(Contact contact, String stateAbv) {
        this.contact = contact;
        this.stateAbv = stateAbv;
    }
    
    public void execute(QueueableContext context) {
        List<Account> accounts = [
            SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts)
            FROM Account
            WHERE BillingState = :stateAbv
            LIMIT 200
        ];
        
        List<Contact> primaryContacts = new List<Contact>();
        Contact c = contact.clone();
        
        for(Account acc: accounts) {            
            c.AccountId = acc.Id;
            primaryContacts.add(c);
        } 
        
        if(primaryContacts.size() > 0) {
            insert primaryContacts;
        }
        
    }
}