public class CustomWebInventoryController {
	
	public final sObject parent;
    public String prodCode {get;set;}
    public List<Product2> prodList {get;set;}
    public String ReservarCantidad {get;set;}
    public Boolean showDetails {get;set;}   
    
    public CustomWebInventoryController(ApexPages.StandardController controller) {
        parent = controller.getRecord();
    }
    
    public void search() {
        showDetails = false;
        QuotationHelper helper = new QuotationHelper();
        
        if (helper.confirmProductExistByCode(prodCode)) {
            
            prodList = [
                SELECT Id, Name, ProductCode, 
                (SELECT Id, Pricebook2Id, UnitPrice FROM PricebookEntries 
                WHERE Pricebook2Id = '01sIY000002bf3NYAQ'), 
                (SELECT Cantidad_apart__c, Cantidad_dis__c FROM Inventarios__r)
                FROM Product2
                WHERE ProductCode = :prodCode             	
                LIMIT 1
            ];

            if (prodList[0].PricebookEntries.size() > 0 && 
                prodList[0].Inventarios__r.size() > 0
            ) {                
                update prodList;            
                showDetails = true;            
            }
            else {                
                message('Error', 
                        'El producto ingresado no contiene los datos requeridos.'
                        + '<br/>'
                        + 'Revisa que este asociado a Price Book Entry e Inventario.'
                        );
            }
        }
        else if (prodCode == '') {
            message('Error', 'Ingrese un codigo de producto.');
        }
        else {
            message('Error', 'No existe ningun producto con el código ingresado.');
        }  
    } 
    
    public PageReference save() {
        
        if ( ReservarCantidad.isNumeric() ) {
            
            if (Integer.valueOf(ReservarCantidad) > 0) {  
                
                QuoteLineItem QLI = new QuoteLineItem(
                    QuoteId = parent.Id,
                    PricebookEntryId = prodList[0].PricebookEntries[0].Id,
                    Product2Id = prodList[0].Id,
                    Quantity = Integer.valueOf(ReservarCantidad),
                    UnitPrice = prodList[0].PricebookEntries[0].UnitPrice
                );
                
                insert QLI;        
                
                PageReference pg = new PageReference('/' + QLI.Id);
                pg.setRedirect(true);
                return pg;
            }
            else {
                message('Error', 'La cantidad a reservar debe ser de al menos 1.');
            }            
        }
        else {
            message('Error', 'La cantidad a reservar debe ser un numero entero.');            
        }
        
        return null;
    }
    
    public void message (String severity, String message) {
        ApexPages.Message msg;
            
        switch on severity {
            when 'Error', 'error', 'ERROR' {
                msg = new ApexPages.Message(ApexPages.Severity.Error, message);
            }
            when 'Warning', 'warning', 'WARNING' {
                msg = new ApexPages.Message(ApexPages.Severity.Error, message);
            }
            when 'Info', 'info', 'INFO' {
                msg = new ApexPages.Message(ApexPages.Severity.Error, message);
            }
            when 'Fatal', 'fatal', 'FATAL' {
                msg = new ApexPages.Message(ApexPages.Severity.Error, message);
            }
            when 'Confirm', 'confirm', 'CONFIRM' {
                msg = new ApexPages.Message(ApexPages.Severity.Error, message);
            }
            
        }
        
        ApexPages.addMessage(msg);
    }
}