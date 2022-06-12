/*
* Creado por Angel Juarez
*/

global class AccBatchScheduleClass implements Schedulable{
    
    global void execute(SchedulableContext ctx) {
        BatchApexExample  accCls = new BatchApexExample();
        
    }    
}

// Call from DevConsole
/*
AccBatchScheduleClass accCls = new AccBatchScheduleClass();
String cronStr = '20 30 8 10 2 ?';
String jobID = system.schedule('Process Acc Records', cronStr, accCls);
*/