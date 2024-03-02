global class MaskedLinkController {
    
    public String recordId { get; set; } // Original record ID
    public String recordIdParam { get; set; } // Parameter to store the record ID
    public String phone { get; set; }
    public String PersonBirthdate { get; set; }
    public String T_Shirt_Size { get; set; }
    public String Shoe_size { get; set; }
    public Account account {get;set;}
    
    public MaskedLinkController() {
        // Retrieve the record ID from the parameter
        recordId = ApexPages.currentPage().getParameters().get('id');
        account=new Account();
    }
    
    public PageReference updateRecord() {
        if (recordId != null) {
            try {
                // Query the Account record using the recordId
                Account acc = [SELECT Id,phone,T_Shirt_Size__c,Shoe_size__c,PersonBirthdate FROM Account WHERE Id = :recordId LIMIT 1];
                
                // Update the Phone field with the value from phoneNumber
                acc.Phone = phone;
                acc.PersonBirthdate=Date.valueOf(PersonBirthdate);
                acc.T_Shirt_Size__c=T_Shirt_Size;
                acc.Shoe_size__c=Shoe_size;
                
                // Update the Account record
                update acc;
                ApexCallout.sendHttpPostRequest(acc.id);
                return Page.SuccessPage;
            } catch (Exception e) {
                // Handle any exceptions
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error updating record: ' + e.getMessage()));
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Record ID is null'));
        }
        
        // Redirect to null to stay on the same page
        return null;
    }
}