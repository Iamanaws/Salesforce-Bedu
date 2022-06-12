/*
 * Desarrollado por Angel Juarez
 * Este trigger se ejecuta cuando una cuenta xxxx
 * Fecha: 07/06/2022
 * Version: 1.0 
 */

trigger AccountTrigger on Account (before insert, before update, after update) {
	
    if(Trigger.isBefore && Trigger.isInsert) {
        system.debug('I am in AccountTrigger before insert context');
    }
    
    if(Trigger.isUpdate) {
        if(Trigger.isBefore) {
            for(Account acc: Trigger.New) {
                system.debug('New Name: ' + acc.Name);
                system.debug('Old Name: ' + Trigger.oldMap.get(acc.id).Name);
            }
        }
    }
}