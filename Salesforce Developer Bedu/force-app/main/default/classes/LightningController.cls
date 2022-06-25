public class LightningController {
    public LightningController() {

    }

    @AuraEnabled(cacheable=true)
    public static Product2 search(String prodCode) {
        
        QuotationHelper helper = new QuotationHelper();        
        
        if (helper.confirmProductExistByCode(prodCode)) {
            
            Product2 prodData = [
                SELECT Id, Name, ProductCode, 
                (SELECT Id, Pricebook2Id, UnitPrice FROM PricebookEntries 
                WHERE Pricebook2Id = '01sIY000002bf3NYAQ'), 
                (SELECT Cantidad_apart__c, Cantidad_dis__c FROM Inventarios__r)
                FROM Product2
                WHERE ProductCode = :prodCode             	
                LIMIT 1
            ];

            if (prodData.PricebookEntries.size() > 0 && 
                prodData.Inventarios__r.size() > 0
            ) { 
                return prodData;          
            }
            else {                
                throw new AuraHandledException( 
                    'El producto ingresado no contiene los datos requeridos.'
                    + ' Revisa que este asociado a Price Book Entry e Inventario.'
                    );
            }
            
        }
        else if (prodCode == '') {
            throw new AuraHandledException('Ingrese un codigo de producto.');
        }
        else {
            throw new AuraHandledException('No existe ningun producto con el código ingresado.');
        }    
    }

    @AuraEnabled
    public static QuoteLineItem save(
        Id QuoteId, Id PricebookEntryId, Id Product2Id, 
        String ReservarCantidad, Integer UnitPrice) {
        
        if ( ReservarCantidad.isNumeric() ) {
            
            if (Integer.valueOf(ReservarCantidad) > 0) {  
                
                QuoteLineItem QLI = new QuoteLineItem(
                    QuoteId = QuoteId,
                    PricebookEntryId = PricebookEntryId,
                    Product2Id = Product2Id,
                    Quantity = Integer.valueOf(ReservarCantidad),
                    UnitPrice = UnitPrice
                );
                
                insert QLI;

                return QLI;   
            }
            else {
                throw new AuraHandledException('La cantidad a reservar debe ser mayor a cero');
            }
        }
        else {
            throw new AuraHandledException('La cantidad a reservar debe ser un número');
        }
    }    
}