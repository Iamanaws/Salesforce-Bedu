public class AnimalLocator {
	
    public static String getAnimalNameById(Integer Id) {
        String animalName;
        
        Http http = new Http();
        
        HttpRequest request = new HttpRequest();        
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + Id);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            animalName = (String) ((Map<String, Object>) results.get('animal')).get('name');
    	}

        return animalName;
    }
}