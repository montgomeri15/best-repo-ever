trigger aws_PositionAfterInsert on Position__c (after insert) {
    
    
    System.debug('>>> begin PositionAfterInsert trigger with ' + Trigger.new);
    List<Position__c> positionsForInterviewers = new List<Position__c>();               //list of positions we will work with
    for (Position__c p : Trigger.new) {                                                 //loop through all trigger Positions
        if (p.Status__c != null && !String.valueof(p.Status__c).equals('Closed')){
            positionsForInterviewers.add(p);                                            //add this position to the list to act on
        }
    }
    
    if (positionsForInterviewers.size() > 0){
        System.debug('>>> there are ' +positionsForInterviewers.size()+ ' Positions with status not Closed ');
        List<Interviewer__c> newInterviewers = new List<Interviewer__c>();              //create a list of interviewers to fill with new records
        newInterviewers = aws_PositionHelper.createHiringManagerInterviewers(positionsForInterviewers); // call the helper to return the interviewers
        insert newInterviewers;                                                         //save the interviewers
        System.debug('>>> interviewers inserted' +newInterviewers);
    }
    System.debug('>>> finished PositionAfterInsert trigger');
}