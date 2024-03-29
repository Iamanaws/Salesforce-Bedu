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
    
    public static List<Inventario__c> productsInInventory() {
        
        List<Inventario__c> products = [
            SELECT ID, Name, CodigoProd__c, Product__c, Cantidad_dis__c, Cantidad_apart__c
            FROM Inventario__C
        ];
        
        return products;
    }

    public Boolean confirmProductExistByCode(String productCode) {
        
        try {
            Product2 product = [
                SELECT ID 
                FROM Product2
                WHERE ProductCode = :productCode
            ];
            
            if (product != null) {
                return true;
            }
        }
        catch (Exception ex) {
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
            
            Integer disponible = null;            
            
            try {
                disponible = Integer.valueOf(existencias[0].Cantidad_dis__c);
            } catch (Exception e) {
                system.debug(e);                
            }          
			
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
                
                inv.Cantidad_apart__c += Quantity[i];
                inv.Cantidad_dis__c -= Quantity[i];                
            }
        }
        
        update inv;
    }

    @InvocableMethod
    public static void StockEmptyAlert() {
        List<Inventario__c> products = productsInInventory();

        for (Inventario__c product : products) {

            if (product.Cantidad_dis__c == 0) {
                system.debug('Crear Post en Chatter');
                //Post to chatter
                FeedItem objPost = new FeedItem(
                    ParentId = UserInfo.getUserId(),
                    Body = 'Producto sin Inventario: ' + product.Name
                );
                
                insert objPost;

                String fecha_hora =  system.now().format();
            }

        }
    }
}