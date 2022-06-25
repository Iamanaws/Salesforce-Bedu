@isTest
public class InventoryDataSchedulerTest {
    
    @isTest
    public static void ExternalLegacyConnectionTest() {

        Test.setMock(HttpCalloutMock.class, new InventoryDataSchedulerMock());
        
        Test.startTest();
        InventoryDataScheduler.ExternalLegacyConnection();            
        Test.stopTest();

        List<Inventario__c> mockList = new List<Inventario__c>{
            new Inventario__c(
                Name = 'CL1010_Inv',
                CodigoProd__c = 'CL1010',
                Cantidad_dis__c = 8589,
                Cantidad_apart__c = 40
            ),
            new Inventario__c(
                Name = 'MC1020_Inv',
                CodigoProd__c = 'MC1020',
                Cantidad_dis__c = 7605,
                Cantidad_apart__c = 75
            ),
            new Inventario__c(
                Name = 'DLL1030_Inv',
                CodigoProd__c = 'DLL1030',
                Cantidad_dis__c = 9784,
                Cantidad_apart__c = 14
            )
        };

        List<Inventario__c> invList = [
            SELECT Name, CodigoProd__c, Cantidad_dis__c, Cantidad_apart__c
            FROM Inventario__c
            WHERE CodigoProd__c = 'CL1010' OR CodigoProd__c = 'MC1020' OR CodigoProd__c = 'DLL1030'
        ];
        
        for(Integer i = 0; i < invList.size(); i++) {
            system.assertEquals(mockList[i].Name, invList[i].Name);
            system.assertEquals(mockList[i].CodigoProd__c, invList[i].CodigoProd__c);
            system.assertEquals(mockList[i].Cantidad_dis__c, invList[i].Cantidad_dis__c);
            system.assertEquals(mockList[i].Cantidad_apart__c, invList[i].Cantidad_apart__c);
        }
    }
	
    @isTest
    public static void executeTest() {        
        
        Test.setMock(HttpCalloutMock.class, new InventoryDataSchedulerMock());
        
        Test.startTest();
        String jobId = system.schedule('ExternalLegacyConnectionTest', 
                                       '0 0 19 1/1 * ? *', new InventoryDataScheduler());
        List<Inventario__c> invList = [
            SELECT Name, CodigoProd__c, Cantidad_dis__c, Cantidad_apart__c
            FROM Inventario__c
            WHERE CodigoProd__c = 'CL1010' OR CodigoProd__c = 'MC1020' OR CodigoProd__c = 'DLL1030'
        ];
        
        system.assertEquals(0, invList.size());
        Test.stopTest();     
        
        invList = [
            SELECT Name, CodigoProd__c, Cantidad_dis__c, Cantidad_apart__c
            FROM Inventario__c
            WHERE CodigoProd__c = 'CL1010' OR CodigoProd__c = 'MC1020' OR CodigoProd__c = 'DLL1030'
        ];
                
        system.assertEquals(3, invList.size());
    }
}