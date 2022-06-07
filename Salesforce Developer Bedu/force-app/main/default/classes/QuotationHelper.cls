public with sharing class QuotationHelper {
    public QuotationHelper() {

    }
    
    public void initialConfig() {
        Account compumundo = new Account(Name = 'Compumundo');
        Account compuworld = new Account(Name = 'Compuworld');
        
        insert compumundo;
        insert compuworld;
    }
    
    public List<Inventario__c> productsInInventory() {
        
        List<Inventario__c> products = [
            SELECT ID, Name, CodigoProd__c, Product__c, Cantidad_dis__c, Cantidad_apart__c
            FROM Inventario__C
        ];
        
        return products;
    }
}