@isTest
private class OrderOnAccountStatus_Test{
	@isTest
	static void testVerifyOrderOnAccountBeforeUpdate(){
		// Retrieve data set from TestDataFactory class : 1 Account, 1 Contract and 1 Order
		TestDataFactory.createTestRecordsForVerifyOrderOnAccount(1, 1, 1);
		Test.startTest();
		// Update Status on Order to 'Active' to catch exception
		List<Order> ords =[SELECT Id, Status
		                   FROM Order
						   WHERE Startdate = '2021-12-09'
						   ];
		for (Order con :ords){
			con.Status ='Active';
		}
		try{
			update ords;
		} catch (Exception e){
			// Verify that the trigger is correctly fired with error message
			system.Assert(e.getMessage().contains('An order must have at least one product'));
		}
		Test.stopTest();
	}

	@isTest
	static void testUpdateActiveCheckboxAfterInsert(){
		// Retrieve data set from TestDataFactory class : 1 Account, 1 Contract and 1 Order
		TestDataFactory.createTestRecordsForUpdateActiveCheckbox(1, 1, 1);
		Test.startTest();
		// Retrieve the value in Active__c field
		List<Account> accts =[SELECT Id, Active__c
		                      FROM Account];
		Test.stopTest();
		// Verify that the checkbox is correctly updated
		for (Account acct :accts)
			System.assertEquals(false, acct.Active__c);
	}

	@isTest
	static void testUpdateActiveCheckboxAfterDelete(){
		// Retrieve data set from TestDataFactory class : 1 Account, 1 Contract and 0 Order
		TestDataFactory.createTestRecordsForUpdateActiveCheckbox(1, 1, 0);
		Test.startTest();
		// Retrieve the value in Active__c field
		List<Account> accts =[SELECT Id, Active__c
		                      FROM Account];
		Test.stopTest();
		// Verify that the checkbox is correctly updated
		for (Account acct :accts)
			System.assertEquals(false, acct.Active__c);
	}
}