public class QuotationHelper implements QuotationSync{
    public QuotationHelper() {

    }
    
    public void initialConfig() {
        List<Account> accs = new List<Account> {
                                new Account(Name = 'Compumundo'), 
                                new Account(Name = 'Compuworld')
                            };
        insert accs;
    }
    
    public List<Inventario__c> productsInInventory() {
        
        List<Inventario__c> products = [
            SELECT ID, Name, CodigoProd__c, Product__c, Cantidad_dis__c, Cantidad_apart__c
            FROM Inventario__C
        ];
        
        return products;
    }

    public Boolean confirmProductExistByCode(String productCode) {
        
        Product2 product = [
            SELECT ID 
            FROM Product2
            WHERE ProductCode = :productCode
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

    public void updateReservedQuantity(List<ID> productID, List<Double> Quantity) {
        
        Inventario__c inv;
        
        List<Product2> products = [
            SELECT ProductCode FROM Product2
            WHERE ID = :productID
        ];
        
        for(Integer i = 0; i < products.size(); i++) {
            
            Double disp = searchProductByCode(products[i].ProductCode);
        
            if(disp > Quantity[i]) {
                inv = [
                    SELECT Id, Name, Cantidad_dis__c, Cantidad_apart__c
                    FROM Inventario__c
                    WHERE CodigoProd__c = :products[i].productCode
                    LIMIT 1
                ];
                
                inv.Cantidad_apart__c = inv.Cantidad_apart__c + Quantity[i];
                inv.Cantidad_dis__c = inv.Cantidad_dis__c - Quantity[i];                
            }
        }
        
        update inv;
    }
}