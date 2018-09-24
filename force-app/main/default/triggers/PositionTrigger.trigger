trigger PositionTrigger on Position__c (before insert, after insert) {
   
    if (Trigger.isAfter && Trigger.isInsert) {
        PositionHelper.handleAfterInsert(Trigger.new, Trigger.newMap);
    } else if (Trigger.isBefore && Trigger.isInsert) {
        PositionHelper.handleBeforeInsert(Trigger.new);
    }
}