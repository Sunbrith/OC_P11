@isTest
public class BatchCreateTask_Test {
    @isTest
    static void testCreationOfTasksIfNoOrderNoTask(){
		// Retrieve data set from TestDataFactory class : 1 Account, 0 Contract, 0 Order and 0 Task
		TestDataFactory.createTestRecordsForCreateTasksInBatchEmail(1, 0, 0, 0);
		// Execute Batch
		Test.startTest();
		BatchCreateTask ct =new BatchCreateTask();
		Id BatchId =Database.executeBatch(ct);
		Test.stopTest();
		// After the testing stops, assert task was created properly
		List<Task> tsks =[SELECT Id
		                  FROM Task];
		for (Task tsk :tsks)
			system.assertEquals(1, tsks.size());
	}

    @isTest
	static void testNoCreationOfTasksIfOneOrderNoTask(){
		// Retrieve data set from TestDataFactory class : 1 Account, 1 Contract, 1 Order and 0 Task
		TestDataFactory.createTestRecordsForCreateTasksInBatchEmail(1, 1, 1, 0);
		// Execute Batch
		Test.startTest();
		BatchCreateTask ct =new BatchCreateTask();
		Id BatchId =Database.executeBatch(ct);
		Test.stopTest();
		// After the testing stops, assert no task was created
		List<Task> tsks =[SELECT Id
		                  FROM Task];
		for (Task tsk :tsks)
			system.assertEquals(0, tsks.size());
	}

    @isTest
	static void testCreationOfTasksIfNoOrderOneEmailTask(){
		// Retrieve data set from TestDataFactory class : 1 Account, 0 Contract, 0 Order and 1 Task(Email)
		TestDataFactory.createTestRecordsForCreateTasksInBatchEmail(1, 0, 0, 1);
		// Execute Batch
		Test.startTest();
		BatchCreateTask ct =new BatchCreateTask();
		Id BatchId =Database.executeBatch(ct);
		Test.stopTest();
		// After the testing stops, assert additional task was created properly
		List<Task> tsks =[SELECT Id
		                  FROM Task];
		for (Task tsk :tsks)
			system.assertEquals(2, tsks.size());
	}

    @isTest
	static void testNoCreationOfTasksIfNoOrderOneCallTask(){
		// Retrieve data set from TestDataFactory class : 1 Account, 0 Contract, 0 Order and 1 Task(Call)
		TestDataFactory.createTestRecordsForCreateTasksInBatchCall(1, 0, 0, 1);
		// Execute Batch
		Test.startTest();
		BatchCreateTask ct =new BatchCreateTask();
		Id BatchId =Database.executeBatch(ct);
		Test.stopTest();
		// After the testing stops, assert no additional task was created
		List<Task> tsks =[SELECT Id
		                  FROM Task];
		for (Task tsk :tsks)
			system.assertEquals(1, tsks.size());
	}
}
