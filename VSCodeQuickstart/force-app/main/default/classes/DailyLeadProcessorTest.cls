@isTest
public class DailyLeadProcessorTest {
    
    public testMethod static void tests() {
        List<Lead> leads = new List<Lead>();
        
        for(Integer i = 0; i < 200; i++) {
            leads.add(new Lead(
                LastName = 'Lead ' + i,
                Company = 'Lead Company'
            ));
        }
        
        insert leads;
        
        Test.startTest();
        String jobId = system.schedule('ScheduleApexTest', 
                                       '0 0 0 15 6 ? 2022', new DailyLeadProcessor()); 
        Test.stopTest();     
        
        List<Lead> ld = [SELECT Id
            FROM Lead
            WHERE LeadSource = 'Dreamforce' AND Company = 'Lead Company'];
        
        system.assertEquals(200, ld.size(), 'Leads were not created');
    }
}