public class LeadProcessor implements Database.Batchable<SObject> {
    
	public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator([SELECT Id, Name FROM Lead]);
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> leads){
        // process each batch of records
        for(Lead ld: leads) {
            ld.LeadSource = 'Dreamforce';
        }
        
        update leads;
    }
    
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        system.debug('Done');
	}
}