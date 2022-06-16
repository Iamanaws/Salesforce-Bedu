@isTest
public class AnimalLocatorTest {
	
    @isTest
    public static void getAnimalNameByIdTest() {
        
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        
        String response = AnimalLocator.getAnimalNameById(1); 
        
        System.assertEquals('chicken', response);
    }
}