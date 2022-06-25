global class InventoryDataScheduler implements Schedulable {
    
    @future (callout=true)
    global static void ExternalLegacyConnection() {
        Http http = new Http();
        
        HttpRequest request = new HttpRequest();        
        request.setEndpoint('https://64bjp0q5wg.execute-api.us-east-2.amazonaws.com/Implement/');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = 
                (Map<String, Object>) ( (Map<String, Object>) JSON.deserializeUntyped(
                    response.getBody()) ).get('body');

            List<Object> inventory = (List<Object>) results.get('Inventory');

            List<Inventario__c> invList = new List<Inventario__c>();
            
            for (object item : inventory) {
				Map<String, Object> fields = (Map<String, Object>) item;
                
                invList.add(new Inventario__c(
                    Name = (String) fields.get('name'),
                    CodigoProd__c = (String) fields.get('ProductID'),
                    Cantidad_dis__c = (Integer) fields.get('Quan'),
                    Cantidad_apart__c = (Integer) fields.get('BlockedQuan')
                ));
            }     
            
            upsert invList;
        }
    }

    global void execute(SchedulableContext SC){
        ExternalLegacyConnection();
    }
}
/* Schedule Execution From Dev Console
InventoryDataScheduler m = new InventoryDataScheduler();
String sch = '0 0 19 1/1 * ? *';
String jobID = system.schedule('ExternalLegacyConnection', sch, m);
*/