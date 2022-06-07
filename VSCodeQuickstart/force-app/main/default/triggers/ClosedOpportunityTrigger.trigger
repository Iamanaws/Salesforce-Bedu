trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    List<Task> tasksToInsert = new List<Task>();
    
    for(Opportunity opp: Trigger.New) {
        
        if(opp.StageName == 'Closed Won') {
            
            Task oppTask = new Task(Subject='Follow Up Test Task', WhatId=opp.ID);
            tasksToInsert.add(oppTask);
            
        }        
    }
    
    insert tasksToInsert;
}