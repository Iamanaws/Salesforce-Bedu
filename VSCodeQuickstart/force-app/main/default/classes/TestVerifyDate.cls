@isTest
public class TestVerifyDate {
    
    public static Date date1 = Date.newInstance(2022, 1, 1);
    public static Date lastDay = Date.newInstance(2022, 1, 31);
    
	@isTest
    public static void Date2InThePast() {
        Date date2 = Date.newInstance(2021, 12, 24);
        
        Date finalDate = VerifyDate.CheckDates(date1, date2);
        
        system.assertEquals(lastDay, finalDate);
    }
    
    @isTest
    public static void Date2Is30DaysAway() {
        Date date2 = Date.newInstance(2022, 1, 31);
        
        Date finalDate = VerifyDate.CheckDates(date1, date2);
        
        system.assertEquals(lastDay, finalDate);
    }
    
    @isTest
    public static void Date2IsMoreThan30DaysAway() {
        Date date2 = Date.newInstance(2022, 2, 21);
        
        Date finalDate = VerifyDate.CheckDates(date1, date2);
        
        system.assertEquals(lastDay, finalDate);
    }
    
    @isTest
    public static void Date2IsWithinRange() {
        Date date2 = Date.newInstance(2022, 1, 24);
        
        Date finalDate = VerifyDate.CheckDates(date1, date2);
        
        system.assertEquals(date2, finalDate);
    }
}