public class QuotationHelper implements QuotationSync{
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

    public Boolean confirmProductExistByCode(String productCode) {
        
        Product__c product = [
            SELECT ID 
            FROM Product__c
            WHERE ProductCode__c = :productCode
        ];
        
        if (product != null) {
            return true;
        }
        
        return false;
    }

    public Integer searchProductByCode(String productCode) {
        
        if (confirmProductExistByCode(productCode)) {
            
            List<Inventario__c> existencias = [
                SELECT Cantidad_dis__c
                FROM Inventario__c
                WHERE CodigoProd__c = :productCode
                LIMIT 1
            ];

            Integer disponible = Integer.valueOf(existencias[0].Cantidad_dis__c);

            if (disponible != null) {
                return disponible;
            }
        }
        else {
            system.debug('No existe un producto para el codigo capturado');
        }

        return 0;
    }
}