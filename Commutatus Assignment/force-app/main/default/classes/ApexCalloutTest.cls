@istest
private class ApexCalloutTest {
    
    @testsetup
    private static void accountData(){
        Account testAccount=new Account(FirstName='sample',lastName='test',Phone='1234567890',PersonEmail = 'test@example.com', T_Shirt_Size__c = 'M', Shoe_size__c = '9');
        insert testAccount;
    }
    
    @istest static Account getAccountdata(){
        Account acc=[select id,PersonEmail,T_Shirt_Size__c,Shoe_size__c,Loyalty_Customer_ID__c FROM Account];
        return   ApexCallout.getAccountRecordId(acc.Id);
        
    }
    
    @istest static void updateAccountdata(){
        Account acc=[select id,PersonEmail,T_Shirt_Size__c,Shoe_size__c,Loyalty_Customer_ID__c FROM Account];   
        ApexCallout.updateAccountWithCustomerId('123455', acc);  
    }
    
    @istest static void negativeUpdateAccountdata(){
        Account acc=[select id,PersonEmail,T_Shirt_Size__c,Shoe_size__c,Loyalty_Customer_ID__c FROM Account];   
        try{
            ApexCallout.updateAccountWithCustomerId('1223', null); 
        }catch(Exception e){
            String expectedErrorMessage = 'System.NullPointerException: Attempt to de-reference a null object';
            System.assertEquals(expectedErrorMessage, e.getMessage(), 'Exception message should match');
            System.assertEquals(false, acc.Profile_Completed__c, 'Profile_Completed__c should not be updated');
        }
        
    }
    
    @istest static void httpCallout(){
        Account acc=[select id,PersonEmail,T_Shirt_Size__c,Shoe_size__c,Loyalty_Customer_ID__c FROM Account];   
        Test.startTest();
        // Call the method being tested
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        ApexCallout.sendHttpPostRequest(acc.Id);
        Test.stopTest(); 
    }
    
    @istest static void negativeHttpCallout(){
        Account acc=[select id,PersonEmail,T_Shirt_Size__c,Shoe_size__c,Loyalty_Customer_ID__c FROM Account];   
        Test.startTest();
        // Call the method being tested
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        try{
            ApexCallout.sendHttpPostRequest(null);
            Test.stopTest(); 
        }catch(Exception e){
            String expectedErrorMessage = 'System.NullPointerException: Attempt to de-reference a null object';
            System.assertEquals(expectedErrorMessage, e.getMessage(), 'Exception message should match');
            
        }
    }
}