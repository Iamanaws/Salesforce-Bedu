@isTest
public class LeadProcessorTest {
	
    @isTest
    private static void testBatchClass() {
        
        // Data Load
        List<Lead> leads = new List<Lead>();
        
        for(Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'Connock', Company = 'Salesforce'));
        }
        
        insert leads;
        
        // Test Execution
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchID = Database.executeBatch(lp);
        Test.stopTest();
		
        // Verify Results
        List<Lead> updateLeads = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        system.assertEquals(200, updateLeads.size(), 'Error: At least 1 Lead record not specified correctly');
    }
}