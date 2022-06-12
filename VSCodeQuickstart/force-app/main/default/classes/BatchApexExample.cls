global with sharing class BatchApexExample implements Database.Batchable<sObject>, Database.Stateful{
    
    global BatchApexExample() {

    }

    public Integer contador = 0;

    global Database.QueryLocator start(Database.BatchableContext BC){

        return Database.getQueryLocator([SELECT id, Name FROM Account WHERE Name = 'BEDU']);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accList){
        List<Account> lst = new List<Account>();
        
        for(Account acc: accList){
            acc.Name = 'Bedu';
            lst.add(acc);
            contador++;
        }

        update lst;
    }
    global void finish(Database.BatchableContext BC){

        System.debug('Resultado contado: '+ contador);

        Database.executeBatch(new BatchApexExample());
    }
}