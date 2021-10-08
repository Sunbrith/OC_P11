public with sharing class OrderOnAccountStatus {


    // "inactive order" 
    // when status "draft" changes to "active" methos must verify if the order has products
    // if NO products on order changement of status is blocked and en error message is displayed

    public void verifyOrderOnAccount() {

        List<Account> inactive = [SELECT active__c
                                  FROM Account
                                  WHERE Id NOT IN (
                                      SELECT AccountId 
                                      FROM Order 
                                      WHERE (Status = 'Activated' OR Status = 'Draft'))];

        List<Account> accToUpdate = new List<Account>();

        for(Account acc : inactive){
            if(acc.Active__c){
                acc.Active__c = false;
            }
            accToUpdate.add(acc);
        }
        update accToUpdate;
    }


    // deactivate custom field active__c
    // on deletion of an order verify that the list of orders is empty 
    // if there are 0 orders untick/deactivate the field
}
