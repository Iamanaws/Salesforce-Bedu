public class NewMethod {
    public void DML(){
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Test 1';
        inv.Cantidad_apart__c = 3;
        inv.CodigoProd__c = 'PROD001';
        
        Inventario__c inv2 = new Inventario__c();
        inv2.Name = 'Test 2';
        inv2.Cantidad_apart__c = 3;
        inv2.CodigoProd__c = 'PROD002';
        
        List<Inventario__c> lst = new List<Inventario__c>();
        lst.add(inv);
        lst.add(inv2);
        
        insert lst;
        
        Inventario__c inv3 = [SELECT id, Name, CodigoProd__c FROM Inventario__c WHERE Name = 'Test 1' LIMIT 1];
        
        delete inv3;
    }

}