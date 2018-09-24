trigger JobApplicationTrigger on Job_Application__c (after insert, after update) {
    
    if(Trigger.isAfter && Trigger.isInsert) {
        JobApplicationHelper.handleAfterInsert(Trigger.new, Trigger.newMap);
    }
    else if (Trigger.isAfter && Trigger.isUpdate) {
        JobApplicationHelper.handleAfterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
    }
}