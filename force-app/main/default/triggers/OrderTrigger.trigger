/**
* Name: OrderTrigger
* Description: This trigger 
* Author: Solbritt ANDERSEN
* Date: 08/10/2021
*/


trigger OrderTrigger on Order (after insert, before update, after delete) {

        if(trigger.isInsert){
        OrderOnAccountStatus.verifyOrderOnAccount(Trigger.new);
    }

    if(trigger.isUpdate){
        OrderOnAccountStatus.verifyOrderOnAccount(Trigger.new);
    }

    if(trigger.isDelete){
        OrderOnAccountStatus.(Trigger.old);
    }
}