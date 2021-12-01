@isTest
public class TestDataFactory{

    public static void createTestRecordsForVerifyOrderOnAccount(Integer numAccts, Integer numCntsPerAcct, Integer numOrds) {
       		//Create Accounts
		List<Account> accts =new List<Account>();
		for (Integer i =0; i <numAccts; i ++){
			Account a =new Account(Name ='TestAccount' +i);
			accts.add(a);
		}
		insert accts;

		//Create Contracts
		List<Contract> cnts =new List<Contract>();
		for (Integer j =0; j <numAccts; j ++){
			Account acct =accts[j];
			for (Integer k =0; k <numCntsPerAcct; k ++){
				cnts.add(new Contract(AccountId =acct.Id, Status ='Draft', StartDate =date.parse('09/12/2021'), ContractTerm =2));
			}
		}
		insert cnts;

		//Create Orders
		List<Order> ords =new List<Order>();
		for (Integer j =0; j <numAccts; j ++){
			Account acct =accts[j];
			for (Integer k =0; k <numCntsPerAcct; k ++){
				Contract cnt =cnts[k];
				for (Integer n =0; n <numOrds; n ++){
					Order o =new Order(AccountId =acct.Id, EffectiveDate =date.parse('09/12/2021'), ContractId =cnt.Id, Status ='Draft');
					ords.add(o);
				}
			}
		}
		insert ords;
	}

public static void createTestRecordsForUpdateActiveCheckbox(Integer numAccts, Integer numCntsPerAcct, Integer numOrds){
    //Create Accounts
    List<Account> accts =new List<Account>();
    for (Integer i =0; i <numAccts; i ++){
        Account a =new Account(Name ='TestAccount' +i);
        accts.add(a);
    }
    insert accts;

    //Create Contracts
    List<Contract> cnts =new List<Contract>();
    for (Integer j =0; j <numAccts; j ++){
        Account acct =accts[j];
        for (Integer k =0; k <numCntsPerAcct; k ++){
            cnts.add(new Contract(AccountId =acct.Id, Status ='Draft', StartDate =date.parse('09/11/2021'), ContractTerm =2));
        }
    }
    insert cnts;

    //Create Orders
    List<Order> ords =new List<Order>();
    for (Integer j =0; j <numAccts; j ++){
        Account acct =accts[j];
        for (Integer k =0; k <numCntsPerAcct; k ++){
            Contract cnt =cnts[k];
            for (Integer n =0; n <numOrds; n ++){
                Order o =new Order(AccountId =acct.Id, EffectiveDate =date.parse('09/11/2021'), ContractId =cnt.Id, Status ='Draft');
                ords.add(o);
            }
        }
    }
    insert ords;
}
public static void createTestRecordsForCreateTasksInBatchCall(Integer numAccts, Integer numCntsPerAcct, Integer numOrds, Integer numTsk){
    //Create Accounts
    List<Account> accts =new List<Account>();
    for (Integer i =0; i <numAccts; i ++){
        Account a =new Account(Name ='TestAccount' +i);
        accts.add(a);
    }
    insert accts;

    //Create Contracts
    List<Contract> cnts =new List<Contract>();
    for (Integer j =0; j <numAccts; j ++){
        Account acct =accts[j];
        for (Integer k =0; k <numCntsPerAcct; k ++){
            cnts.add(new Contract(AccountId =acct.Id, Status ='Draft', StartDate =date.parse('09/11/2021'), ContractTerm =2));
        }
    }
    insert cnts;

    //Create Orders
    List<Order> ords =new List<Order>();
    for (Integer j =0; j <numAccts; j ++){
        Account acct =accts[j];
        for (Integer k =0; k <numCntsPerAcct; k ++){
            Contract cnt =cnts[k];
            for (Integer l =0; l <numOrds; l ++){
                Order o =new Order(AccountId =acct.Id, EffectiveDate =date.parse('09/11/2021'), ContractId =cnt.Id, Status ='Draft');
                ords.add(o);
            }
        }
    }
    insert ords;

    //Create Tasks
    List<Task> tsks =new List<Task>();
    for (Integer j =0; j <numAccts; j ++){
        Account acct =accts[j];
        for (Integer m =0; m <numTsk; m ++){
            tsks.add(new Task(WhatId =acct.Id, Subject ='Call', Status ='Not Started'));
        }
    }
    insert tsks;
}

public static void createTestRecordsForCreateTasksInBatchEmail(Integer numAccts, Integer numCntsPerAcct, Integer numOrds, Integer numTsk){
    //Create Accounts
    List<Account> accts =new List<Account>();
    for (Integer i =0; i <numAccts; i ++){
        Account a =new Account(Name ='TestAccount' +i);
        accts.add(a);
    }
    insert accts;

    //Create Contracts
    List<Contract> cnts =new List<Contract>();
    for (Integer j =0; j <numAccts; j ++){
        Account acct =accts[j];
        for (Integer k =0; k <numCntsPerAcct; k ++){
            cnts.add(new Contract(AccountId =acct.Id, Status ='Draft', StartDate =date.parse('09/11/2021'), ContractTerm =2));
        }
    }
    insert cnts;

    //Create Orders
    List<Order> ords =new List<Order>();
    for (Integer j =0; j <numAccts; j ++){
        Account acct =accts[j];
        for (Integer k =0; k <numCntsPerAcct; k ++){
            Contract cnt =cnts[k];
            for (Integer l =0; l <numOrds; l ++){
                Order o =new Order(AccountId =acct.Id, EffectiveDate =date.parse('09/11/2021'), ContractId =cnt.Id, Status ='Draft');
                ords.add(o);
            }
        }
    }
    insert ords;

    //Create Tasks
    List<Task> tsks =new List<Task>();
    for (Integer j =0; j <numAccts; j ++){
        Account acct =accts[j];
        for (Integer m =0; m <numTsk; m ++){
            tsks.add(new Task(WhatId =acct.Id, Subject ='Email', Status ='Not Started'));
        }
    }
    insert tsks;
}

}

