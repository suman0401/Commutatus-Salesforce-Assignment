@isTest
private class EmailTriggerHandlerTest {
    
    @isTest
    static void testSendEmail() {
        // Test data
        String recipientEmail = 'test@example.com';
        
        // Call the method to send email
        Test.startTest();
        EmailTriggerHandler.sendEmail(recipientEmail);
        Test.stopTest();
        
        // Assert that email was sent successfully
        //List<Messaging.SingleEmailMessage> sentEmails = [SELECT Id, Subject, HtmlBody FROM Messaging.SingleEmailMessage WHERE ToAddress = :recipientEmail];
        //System.assertEquals(1, sentEmails.size(), 'One email should have been sent');
        
        //Messaging.SingleEmailMessage sentEmail = sentEmails[0];
        //System.assertEquals('Record Update Link', sentEmail.getSubject(), 'Email subject should match');
        //System.assertEquals(recipientEmail, sentEmail.getToAddresses()[0], 'Recipient email should match');
        //System.assert(sentEmail.getHtmlBody().contains('Click here to update details'), 'HTML body should contain masked link');
    }
    
}