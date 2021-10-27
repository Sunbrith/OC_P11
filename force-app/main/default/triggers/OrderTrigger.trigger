/**
* Name: OrderTrigger
* Description: This trigger 
* Author: Solbritt ANDERSEN
* Date: 08/10/2021
*/


trigger OrderTrigger on Order (before update, after delete) {

        //if(trigger.isInsert){
       //OrderOnAccountStatus.verifyOrderOnAccount(Trigger.new);
    //}

    if(Trigger.IsBefore && Trigger.isUpdate){
        OrderOnAccountStatus.verifyOrderOnAccount(Trigger.new);
    }

    if(Trigger.IsAfter && Trigger.isDelete){
        OrderOnAccountStatus.updateActiveCheckbox(Trigger.old);
    }
}