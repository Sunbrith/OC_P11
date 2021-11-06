/**
* Name: SchedulerCreateTask
* Description:This class implements Schedulable to execute BatchCreateTask class
* Author: Solbritt ANDERSEN
* Date: 01/11/2021
*/

global class SchedulerCreateTask implements Schedulable{
	global void execute(SchedulableContext info){
		//Call BatchCreateTask class and schedule it through User Interface
		BatchCreateTask ct = new BatchCreateTask();
		Database.ExecuteBatch(ct);
	}
}