public with sharing class RecallFormController {

    public RecallFormController() {}
    
    @remoteAction
    public static String registerRecall(String formData) {
    	Map<String,Object> formMap = (Map<String,Object>) JSON.deserializeUntyped(formData);
    	Map<String,String> response = new Map<String,String>();
    	System.debug((String)formMap.get('streetNumber'));


    	//get the customer information and see if there is a contact record. If not, then make one.

    	//create a recall record and associate it with the contact record
    	Recall__c recall = new Recall__c();
    	/*
    	recall.Did_you_become_sick_after_taking_Tylenol__c = (String) formMap.get('isSick');
    	recall.NDC__c = (String) formMap.get('ndc');
    	recall.Lot__c = f(String) ormMap.get('lot');
    	recall.Retailer__c = (String) formMap.get('retailer');
    	recall.Serial_Number__c = (String) formMap.get('serialno');
    	recall.Return_To__c = (String) formMap.get('returnto');

    	//lookup customer using e-mail address and name
    	List<Contact> contacts = [SELECT Email,FirstName,LastName,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet
    					   FROM Contact where Email = : (String)formMap.get('email') AND FirstName = : (String) formMap.get('firstname') AND LastName = :(String) formMap.get('lastname')];

        Contact contact;
    	if (contacts.size() == 0) {
    		contact = new Contact();
    		contact.Email =  (String) formMap.get('email');
    		contact.FirstName = (String) formMap.get('firstname');
    		contact.LastName  = (String) formMap.get('lastname');
    		contact.MailingCity = (String) formMap.get('city');
    		contact.MailingState = (String) formMap.get('state');
    		contact.MailingStreet = (String) formMap.get('street');
    		contact.MailingPostalCode = (String) formMap.get('postalCode');
    		insert contact;
    	}  else {
    		contact = contacts[0];
    	}

    	recall.Contact__c = contact.Id;
    	*/
    	insert recall;

    	//create and return a response object
    	
    	response.put('Id',recall.Id);
    	return JSON.serialize(response);

    }

}
