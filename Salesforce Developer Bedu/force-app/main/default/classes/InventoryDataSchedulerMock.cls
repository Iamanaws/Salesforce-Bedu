@isTest
global class InventoryDataSchedulerMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"body":{'
            + '"inventory":['
            + '{"name":"CL1010_Inv","ProductID":"CL1010","Quan":8589,"BlockedQuan":40},'
            + '{"name":"MC1020_Inv","ProductID":"MC1020","Quan":7605,"BlockedQuan":75},'
            + '{"name":"DLL1030_Inv","ProductID":"DLL1030","Quan":9784,"BlockedQuan":14}'
            + ']}}'
            );
        response.setStatusCode(200);
        
        return response;
    }
}