public with sharing class JobApplicationHelper {
    
    public static List<Task> taskList = new List<Task>();
    private static String closedRejected = 'Closed - Rejected';
    private static String offerExtended = 'Offer Extended';
    
    public static void handleAfterInsert(List<Job_Application__c> newList, Map<ID, Job_Application__c> newMap) {
        
        for(Job_Application__c jobApp : newList){ 
            if(jobApp.Stage__c == closedRejected){
                createTaskHandler(jobApp.OwnerId, System.Label.Send_Rejection_Letter);
        	}
            if(jobApp.Stage__c == offerExtended){
                createTaskHandler(jobApp.OwnerId, System.Label.Extend_an_Offer);
        	}
        }
        insertTaskHandler(newList);
    }
    
    public static void handleAfterUpdate(List<Job_Application__c> oldList, Map<ID, Job_Application__c> oldMap,
                                   		 List<Job_Application__c> newList, Map<ID, Job_Application__c> newMap) {
                                             
        for(Job_Application__c jobApp : newList){ 
            if(jobApp.Stage__c == closedRejected && oldMap.get(jobApp.Id).Stage__c != closedRejected){
                createTaskHandler(jobApp.OwnerId, System.Label.Send_Rejection_Letter);
        	}
            if(jobApp.Stage__c == offerExtended && oldMap.get(jobApp.Id).Stage__c != offerExtended){
                createTaskHandler(jobApp.OwnerId, System.Label.Extend_an_Offer);
        	}
        }
        insertTaskHandler(newList);
    }
    
    public static void insertTaskHandler(List<Job_Application__c> jobAppList){
        try{
            insert taskList; 
        } catch(DMLException e){
            System.debug('We have a problem here: ' + e.getMessage());
        }
    }
                   
    public static void createTaskHandler(Id ownId, String subj){
        Task task = new Task(
            OwnerId = ownId,
            Subject = subj
        );
        taskList.add(task);
    }
}