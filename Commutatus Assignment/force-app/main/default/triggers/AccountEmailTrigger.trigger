trigger AccountEmailTrigger on Account (after insert) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        for (Account acc : Trigger.new) {
            if (acc.PersonEmail != null) {
                EmailTriggerHandler.sendEmail(acc.PersonEmail,acc.id);
            }
        }
    }
}