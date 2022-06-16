@isTest
public class TestRestrictContactByName {
	
    @isTest
    public static void createInvalidContact() {
        
        Contact c = new Contact(LastName = 'INVALIDNAME');           
        
        Test.startTest();
        Database.SaveResult result = Database.insert(c, false);
        Test.stopTest();        
        
        system.assertEquals('The Last Name INVALIDNAME is not allowed for DML', 
                            result.getErrors()[0].getMessage());
    }
    
    @isTest
    public static void updateToInvalidName() {
        
        Contact c = new Contact(LastName = 'GOODLASTNAME');   
		insert c;        
        
        c.LastName = 'INVALIDNAME';
        
        Test.startTest();
        Database.SaveResult result = Database.update(c, false);
        Test.stopTest();        
        
        system.assertEquals('The Last Name INVALIDNAME is not allowed for DML', 
                            result.getErrors()[0].getMessage());
    }
}