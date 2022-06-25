@isTest
public class QuotationHelperTest {
    
    public QuotationHelperTest() {
        
    }

    public static QuotationHelper helper = new QuotationHelper();
    
    @isTest
    public static void initialConfigTest (){
        
        Boolean success = true;

        try {
            helper.initialConfig();
        } catch (Exception e) {
            success = false;
        } finally {
            System.assert(success);
        }
    }
    
    @isTest
    public static void productsInInventoryTest (){
        
        List<Inventario__c> invList = new List<Inventario__c>();
        
        for (Integer i = 1; i < 10; i++) {

            invList.add(new Inventario__c(
                Name = 'Test Inv ' + i,
                CodigoProd__c = 'TEST-00' + i,
                Cantidad_dis__c = i * i
                ));
        }

        insert invList;

        system.assertEquals(invList, QuotationHelper.productsInInventory());
    }
    
    @isTest
    public static void confirmProductExistByCodeTest (){
        Product2 prod = new Product2(
            Name = 'Test Prod',
            ProductCode = 'TEST-001'
        );
        
        insert prod;
        
        Boolean t = helper.confirmProductExistByCode(prod.ProductCode);
        Boolean f = helper.confirmProductExistByCode('TEST-002');
        
        system.assertEquals(True, t);
        system.assertEquals(False, f);
    }
    
    @isTest
    public static void searchProductByCodeTest (){
        
        List<Product2> prodList = new List<Product2>();
        List<Inventario__c> invList = new List<Inventario__c>();
        
        for (Integer i = 1; i < 10; i++) {

            prodList.add(new Product2(
                Name = 'Test Prod ' + i,
                ProductCode = 'TEST-00' + i
                ));

            invList.add(new Inventario__c(
                Name = 'Test Inv ' + i,
                CodigoProd__c = 'TEST-00' + i,
                Cantidad_dis__c = i * i
                ));
        }

        prodList.add(new Product2(
                Name = 'Test Prod 10',
                ProductCode = 'TEST-010'
                ));
        
        insert prodList;
        insert invList;
        
        for (Integer i = 1; i < 10; i++) {
            
            system.assertEquals( 
                i * i, 
                helper.searchProductByCode('TEST-00' + i)
                );
        }

        system.assertEquals(
            0, 
            helper.searchProductByCode('TEST-100')
            );
        system.assertEquals(
            0, 
            helper.searchProductByCode('TEST-010')
            );
    }
    
    @isTest
    public static void updateReservedQuantityTest (){
        
        Product2 prod = new Product2(
            Name = 'Test Prod',
            ProductCode = 'TEST-001'
        );
        
        insert prod;

        Inventario__c inv = new Inventario__c(
            Name = 'Test Inv 1',
            CodigoProd__c = 'TEST-001',
            Cantidad_dis__c = 10,
            Cantidad_apart__c = 0
        );
        
        insert inv;

        helper.updateReservedQuantity(new List<Id>{prod.Id}, new List<Double>{2});
        
        system.assertEquals(8, inv.Cantidad_dis__c);
        system.assertEquals(2, inv.Cantidad_apart__c);
    }
    
    @isTest
    public static void StockEmptyAlertTest() {
        
        Inventario__c invList = new Inventario__c(
            Name = 'Test Inv 1',
            CodigoProd__c = 'TEST-001',
            Cantidad_dis__c = 0
        );
        
        insert invList;
        
        Boolean success = true;
        
        try {
            QuotationHelper.StockEmptyAlert();
        } catch (Exception e) {
            success = false;
        } finally {
            System.assert(success);
        }
    }
}