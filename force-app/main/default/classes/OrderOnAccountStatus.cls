/**
* Name: OrderOnAccountStatus
* Description: This handler class has 2 features:
* 1/Display an error message if status changes from 'Draft' to 'Active' and if there is no Order Products linked to the Order
* 2/Update Active__c checkbox field of Accounts if there are orders linked to the account or not (true if orders and false if no order)
* Author: Solbritt ANDERSEN
* Date: 08/10/2021
*/


public with sharing class OrderOnAccountStatus {

    public static void verifyOrderOnAccount(List<Order> listOfOrders){
        //create a set with order ID
        Set<Id> ordSet = new Set<Id>();
        //loop through the list of orders to add Id
        for (Order ord :listOfOrders){
            ordset.add(ord.Id);
            //store old order values in a map
            Order oldOrder = (Order)Trigger.oldMap.get(ord.Id);
            //retrieve orders with its products 
            List<OrderItem> resultList = [SELECT OrderId, Order.Status
                                            FROM OrderItem
                                           WHERE OrderId IN :ordset];

            //if there's no product on order and status changes from 'Draft' to 'Active' an error 
            //message will be displayed and status update will be blocked
            if (resultList.size() == 0 && oldOrder.Status == 'Draft' && ord.Status == 'Active'){
                ord.addError('An order must have at least one product');
            }  
        }
     }

    public static void updateActiveCheckbox(List<Order> listOfOrders){

        // Create a map with Accounts and its Id's 
		map<id, Account> updateMap =new Map<id, Account>();
        // Create a set with order ID
		set<ID> ordset =new Set<ID>();

		// Loop through the list of Orders concerned by the trigger
		for (Order ord :listOfOrders){
			if (ord.AccountId !=null)
				ordset.add(ord.AccountId);
		}
		// Create list and query orders
		List<Order> ResultList =[SELECT AccountId, Account.Active__c
		                           FROM Order
		                          WHERE AccountId IN :ordset];

		// If there are orders attached to Account and Active__c field is equal to true, 
        // the checkbox stays checked
		if (ResultList !=null && ResultList.size() >0){
			for (Order res :ResultList){
				Account acc = new Account();
				acc.Id =(id)res.get('AccountId');
				acc.Active__c =true;
				updateMap.put(acc.Id, acc);
			}

		// If there are no orders attached to Account, the checkbox is unchecked
		} else{
			for (id idSet :ordset){
				Account acc = new Account();
				acc.Id =idSet;
				acc.Active__c =false;
				updateMap.put(acc.Id, acc);
			}
		}
		update updateMap.values();
	}
}