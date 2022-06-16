@isTest
global class ParkServiceMock implements WebServiceMock {
	global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               
        // start - specify the response you want to send        
        List<String> parks = new List<String> {
            'Yosemite', 
            'Yellowstone', 
            'Another Park'};
        ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
        response_x.return_x = parks;
        // end
        response.put('response_x', response_x); 
   }
}