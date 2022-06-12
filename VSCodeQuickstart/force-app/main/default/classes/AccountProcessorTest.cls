@isTest
public class AccountProcessorTest {
    
    @isTest
	public static void countContacts() {
        
        // Data Load
        List<Account> accounts = new List<Account>();
        
        for(Integer i = 0; i < 300; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        
        insert accounts;
        
        List<Contact> contacts = new List<Contact>();
        List<Id> accountIDs = new List<Id>();
        
        for(Account acc: accounts) {
            contacts.add(
                new Contact(
                    FirstName = acc.Name, LastName = 'TestContact', AccountId = acc.Id
                )
            );
            
            accountIDs.add(acc.Id);
        }
        
        insert contacts;
        
        // Test Execution
        Test.startTest();
        AccountProcessor.countContacts(accountIDs);
        Test.stopTest();
        
        // Verify Results
        List<Account> accs = [SELECT Id, Number_of_Contacts__c FROM Account];
        
        for(Account acc: accs) {
            system.assertEquals(1, acc.Number_Of_Contacts__c, 'Error: At least 1 Account record with incorrect Contacts');
        }
    }
}