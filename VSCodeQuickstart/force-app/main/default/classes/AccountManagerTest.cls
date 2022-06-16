@isTest
public class AccountManagerTest {
	@isTest static void testGetCaseById() {
        
        Id accId = createTestAccount();
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://empathetic-raccoon-epce15-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + accId 
            +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Call the method to test
        Account thisAcc = AccountManager.getAccount();
        // Verify results
        System.assert(thisAcc != null);
        System.assertEquals([
            SELECT Id, Name, (SELECT Id, Name FROM Contacts)
            FROM Account
            WHERE Id = :accId
        ], thisAcc);
    }
    
    static Id createTestAccount() {
        Account testAcc = new Account(
        Name = 'Test 1');
        
        insert testAcc;        
        return testAcc.id;
    }
}