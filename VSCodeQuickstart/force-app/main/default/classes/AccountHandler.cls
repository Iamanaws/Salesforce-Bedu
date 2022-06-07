public class AccountHandler {
	
    public static Account insertNewAccount(String name) {
        try {
            // Create the account sObject 
            Account acct = new Account(Name = name);
            // Insert the account by using DML
            insert acct;
            
            system.debug(acct);
            return acct;
            
        } catch (DmlException e) {
            System.debug('A DML exception has occurred: ' + e.getMessage());
            return null;
        }     
        
    }
}