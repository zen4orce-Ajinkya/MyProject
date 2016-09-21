trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    List<Task> taskList = new List<Task>();
    
    for (Opportunity opp : [SELECT Id, StageName,enter_Discount_Percent__c FROM Opportunity WHERE StageName = 'Closed Won' AND Id IN :Trigger.new]){
                    
            taskList.add(new Task(Subject = 'Follow Up Test Task',
                                  WhatId = opp.Id));
       
    }

    if(taskList.size()>0){
        
        insert taskList;
        
    }
    
}