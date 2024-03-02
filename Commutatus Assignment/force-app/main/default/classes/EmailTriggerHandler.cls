public class EmailTriggerHandler {
    public static void sendEmail(String recipientEmail,String recordId) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
      //  String recordId = generateMaskedLink(); // Generate masked link here
        String maskedLink = 'https://ruby-inspiration-4420.scratch.lightning.force.com/apex/MaskedLinkPage?id='+recordId;
        
        mail.setToAddresses(new String[]{recipientEmail});
        mail.setSubject('Record Update Link');
       // String maskedLink = 'https://ruby-inspiration-4420.scratch.lightning.force.com/MaskedLinkPage?id=b823d968-723f-42aa-bdfb-7fc0d4113590';
        String maskedText = 'Click here to update details'; // Replace with your desired masked text

       String maskedLinkHtml = '<a href="' + maskedLink + '">' + maskedText + '</a>';

         mail.setHtmlBody(maskedLinkHtml);
       // mail.setHtmlBody('Your basic data has been added. Please click the link below to add or update more details:<br/><a href="' + maskedLink + '">' + maskedLink + '</a>');
        
        
        Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
    
  /*  private static String generateMaskedLink() {
        // Generate and return a unique token as the masked link
        UUID uuIdV4 = UUID.randomUUID(); // returns a UUID instance, having a random UUID v4 Id.
        String uuIdV4Str = UUID.randomUUID().toString(); // Get its String representation.
        return uuIdV4Str;
    }*/
}