/**
* Name: OrderOnAccountStatus
* Description: This handler class has 2 features:
* 1: Display an error message when status chages from 'Draft' to 'Active' 
* when there are no products on the order  
* 2:
*
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
            if (resultList.size() == 0 && old.Order.Status == 'Draft' && ord.Status == 'Active'){
                ord.addError('The order must have at least one product');
            }  

        }
        
                  
    
    }


    //FUNCTION 2:
    // deactivate custom field active__c
    // on deletion of an order verify that the list of orders is empty 
    // if there are 0 orders untick/deactivate the field
}
