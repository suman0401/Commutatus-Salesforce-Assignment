@isTest
private class EmailTestClass {

    @isTest static void testSendEmail() {
        // Create a test recipient email
        String recipientEmail = 'test@example.com';
        
        // Call the sendEmail method
        Test.startTest();
        EmailTriggerHandler.sendEmail(recipientEmail);
        Test.stopTest();
        
        // Verify that an email was sent
        List<EmailMessage> sentEmails = [SELECT Id, ToAddress, Subject, HtmlBody FROM EmailMessage WHERE ToAddress = :recipientEmail];
        System.assertEquals(1, sentEmails.size(), 'Expected one email to be sent');
        
        EmailMessage sentEmail = sentEmails[0];
        System.assertEquals(recipientEmail, sentEmail.ToAddress, 'Recipient email should match');
        System.assertEquals('Record Update Link', sentEmail.Subject, 'Subject should match');
        
        // Verify HTML body contains the masked link
        String maskedLink = 'https://ruby-inspiration-4420.scratch.lightning.force.com/apex/MaskedLinkPage';
        String maskedText = 'Click here to update details';
        String expectedHtmlBody = '<a href="' + maskedLink + '">' + maskedText + '</a>';
        System.assertEquals(expectedHtmlBody, sentEmail.HtmlBody, 'HTML body should contain masked link');
    }
}