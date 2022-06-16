@isTest
public class AddPrimaryContactTest {
    
    static testMethod void testQueueable() {
        List<Account> testAccounts = new List<Account>();
    
        for(Integer i = 0; i < 50; i++) {
            testAccounts.add(new Account(Name = 'Account ' + i, BillingState = 'CA'));
            testAccounts.add(new Account(Name = 'Account ' + i, BillingState = 'NY'));
        }
        
        insert testAccounts;
        
        Contact testContact = new Contact(FirstName = 'John', Lastname = 'Sales');        
        insert testContact;  
        
        AddPrimaryContact addIt = new AddPrimaryContact(testContact, 'CA');
        
        Test.startTest();
        system.enqueueJob(addIt);
        Test.stopTest();
        
        system.assertEquals(50, [SELECT count() FROM Contact 
                                 WHERE AccountID in 
                                 (SELECT Id FROM Account WHERE BillingState = 'CA')]);
    }
        
}