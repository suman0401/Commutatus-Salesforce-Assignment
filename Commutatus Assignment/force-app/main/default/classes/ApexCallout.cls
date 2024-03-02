global class ApexCallout {
    @future(callout=true)
    public static void sendHttpPostRequest(String recordId) {
        // Define the URL endpoint
       try {
        String endpoint = 'https://integrations.commutatus.com/webhook/719ce78d-c2c5-47a8-986a-39d7e7a5652d';
        Account acc=getAccountRecordId(recordId);
        // Define the request body
        String requestBody = '{ "email":"'+ acc.PersonEmail+'", "tshirtSize":"'+acc.T_Shirt_Size__c+'", "shoeSize":"'+acc.Shoe_size__c+'" }';
        
        System.debug('requestBody'+requestBody);
        // Create a new HTTP request
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint(endpoint);
        httpRequest.setMethod('POST');
        httpRequest.setHeader('Content-Type', 'application/json');
        httpRequest.setBody(requestBody);
        
        // Create a new HTTP object to send the request
        Http http = new Http();
        
        
            // Send the request and get the response
            HttpResponse httpResponse = http.send(httpRequest);
            
            system.debug('httpResponse '+httpResponse);
            // Check the response status
            if (httpResponse.getStatusCode() == 200) {
                // Parse the response JSON
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(httpResponse.getBody());
                system.debug('responseMap '+responseMap);
                String customerId = String.valueOf(responseMap.get('customer_id'));
                system.debug('customerId '+customerId);
                // Update the Account record with the customer ID
                updateAccountWithCustomerId(customerId,acc);
            } else {
                System.debug('Request failed with status code: ' + httpResponse.getStatusCode() + ' and message: ' + httpResponse.getStatus());
            }
        } catch (Exception e) {
            System.debug('Exception caught: ' + e.getMessage());
        }
    }
    @testvisible
    private static void updateAccountWithCustomerId(String customerId,Account acc) {
        try {
            
            // Update the Account records with the customer ID
            Account account =acc;
            account.Loyalty_Customer_ID__c = customerId;
            account.Profile_Completed__c=true;
            
            // Perform DML operation to update the records
            
            update account;
        } catch (Exception e ) {
            System.debug('Error updating Account records: ' + e.getMessage());
        }
    }
    
    @testvisible
    private static Account getAccountRecordId(String recordId){
        Account acc=[select id,PersonEmail,T_Shirt_Size__c,Shoe_size__c,Loyalty_Customer_ID__c FROM Account where id = : recordId];
        return acc;
    }
}