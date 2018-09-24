public with sharing class PositionHelper {
    
    public static void handleAfterInsert(List<Position__c> newList, Map<ID, Position__c> newMap){
    
    	List<Id> userIds = new List<Id>();
        EmailTemplate emailTemplate = [SELECT Id FROM emailTemplate WHERE Name = 'Our Email'];
        Messaging.Email[] messages = new Messaging.Email[0];
        
        for(User userRecruiter:[SELECT Id FROM User WHERE UserRole.Name = 'Recruiting Manager']){
                userIds.add(userRecruiter.Id);
            }
    	for(Position__c position : newList){
            Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
  			mail.templateId = emailTemplate.Id;
        	mail.targetObjectIds = userIds;
        	mail.saveAsActivity = false;
  			messages.add(mail); 
    	}
        Messaging.sendEmail(messages);
    }
    
    public static void handleBeforeInsert(List<Position__c> newList) {

        Map<Id, User> userMap = new Map<Id, User>([SELECT Id FROM User WHERE UserRole.Name = 'Recruiting Manager']);        
        Group groupQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = 'Unclaimed Positions Queue' LIMIT 1];
		
 		for(Position__c position: newList){
		 	if(!userMap.containsKey(position.OwnerId)){
				position.OwnerId = groupQueue.Id;
		 	}  
		}
	}
}