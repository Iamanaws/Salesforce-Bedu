@isTest
public class ParkLocatorTest {
    @isTest static void testCallout() {            
        
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Call the method that invokes a callout
        String country = 'United States';            
        List<String> result = ParkLocator.country(country);
        
        // Verify that a fake result is returned
        List<String> parks = new List<String> {
        	'Yosemite', 
            'Yellowstone', 
            'Another Park'};
                
        System.assertEquals(parks, result); 
    }
}