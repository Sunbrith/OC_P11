/**
* Name: BatchCreateTask
* Description:This class implements Database.Batchable<sObject> annd Database.StatefulBatch to create task on Accounts
* if there is no order and no task(Subject = 'Call') linked to the Account
* Author: Solbritt ANDERSEN
* Date: 01/11/2021
*/ 
global class BatchCreateTask implements Database.Batchable<sObject>, Database.Stateful{
	public Integer recordsProcessed = 0;
	global Database.QueryLocator start(Database.BatchableContext bc){
		// Query only Accounts Ids with no order
		return Database.getQueryLocator([SELECT Id
		                                 FROM Account
		                                 WHERE Id NOT IN (SELECT AccountId
		                                                  FROM Order)]);
	}

    global void execute(Database.BatchableContext bc, List<Account> scope){
		// Execute batch of records
		set<ID> accset = new Set<ID>();
		// For loop to store Ids of the filtered Accounts
		for (Account acc : scope){
			if (acc.Id != null)
				accset.add(acc.Id);
		}
		List<Task> taskList = new List<Task>();
		// Query only Tasks linked to a filtered Account and with Subject is equal to 'Call'
		Set<Id> AccountsIdsWithTask = new Map<Id, AggregateResult>([SELECT WhatId Id
		                                                            FROM Task
		                                                            WHERE Subject = 'Call' AND WhatId IN :accset
		                                                            GROUP BY WhatId]).keySet();
		// For loop to store Id and Owner for filtered Accounts with no task
		for (Account a : [SELECT Id, OwnerId
		                  FROM Account
		                  WHERE Id IN :accset AND Id NOT IN :AccountsIdsWithTask]){
			Task task = new Task();
			// Data mapping for tasks creation
			task.WhatId = a.Id;
			task.OwnerId = a.OwnerId;
			task.Status = 'Nouvelle';
			task.Priority = 'Normale';
			task.Subject = 'Call';
			task.IsReminderSet = true;
			task.ReminderDateTime = system.today()+5;
			taskList.add(task);
			// Count of records processed
			recordsProcessed = recordsProcessed + 1;
		}
		// If there is no order and no task (Subject='call') insert a new task
		if (taskList.size() > 0){
			insert taskList;
		}
	}

    global void finish(Database.BatchableContext info){
		// Display job information in debug console
		AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
		                    FROM AsyncApexJob
		                    WHERE Id = :info.getJobId()];
		System.debug(job);
		// Display total of processed records in debug console
		System.debug(recordsProcessed + ' records processed.');
	}
}