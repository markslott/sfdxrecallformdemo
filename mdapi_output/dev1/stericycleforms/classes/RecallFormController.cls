public with sharing class RecallFormController {

    public RecallFormController() {}

    @remoteAction 
    public static String getContact(String contactId) {
    	List<Contact> contacts = [SELECT Email,FirstName,LastName,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet
    					   FROM Contact where Id = :contactId];
    	Map<String,String> formData = new Map<String,String>();
    	if (contacts.size() != 0) {
    		Contact contact = contacts[0];
    		formData.put('email',contact.Email);
    		formData.put('firstName',contact.FirstName);
    		formData.put('lastName',contact.LastName);
    		formData.put('city',contact.MailingCity);
    		formData.put('state',contact.MailingState);
    		formData.put('street',contact.MailingStreet);
    		formData.put('postalCode',contact.MailingPostalCode);
    		
    	}  
    	return JSON.serializePretty(formData);
    }
    
    @remoteAction
    public static String registerRecall(String formData) {
    	Map<String,Object> formMap = (Map<String,Object>) JSON.deserializeUntyped(formData);
    	Map<String,String> response = new Map<String,String>();
    	
    	for (Object key : formMap.keySet()) {
    		System.debug((String)key+ ' : '+(String)formMap.get((String)key));
    	}

    	String product = (String)formMap.get('product');

    	Id recType = Schema.SObjectType.Recall__c.getRecordTypeInfosByName().get(product).getRecordTypeId();


    	//get the customer information and see if there is a contact record. If not, then make one.

    	//create a recall record and associate it with the contact record
    	Recall__c recall = new Recall__c();
    	recall.RecordTypeId = recType;
    	recall.Did_you_become_sick_after_taking_Tylenol__c = (String) formMap.get('isSick');
    	recall.NDC__c = (String) formMap.get('ndc');
    	recall.Lot__c = (String) formMap.get('lot');
    	recall.Retailer__c = (String) formMap.get('retailer');
    	recall.Serial_Number__c = (String) formMap.get('serialno');
    	recall.Return_To__c = (String) formMap.get('returnto');

    	//lookup customer using e-mail address and name
    	List<Contact> contacts = [SELECT Email,FirstName,LastName,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet
    					   FROM Contact where Email = : (String)formMap.get('email') AND FirstName = : (String) formMap.get('firstName') AND LastName = :(String) formMap.get('lastName')];

        Contact contact;
    	if (contacts.size() == 0) {
    		contact = new Contact();
    		contact.Email =  (String) formMap.get('email');
    		contact.FirstName = (String) formMap.get('firstName');
    		contact.LastName  = (String) formMap.get('lastName');
    		contact.MailingCity = (String) formMap.get('city');
    		contact.MailingState = (String) formMap.get('state');
    		contact.MailingStreet = (String) formMap.get('street');
    		contact.MailingPostalCode = (String) formMap.get('postalCode');
    		insert contact;
    	}  else {
    		contact = contacts[0];
    	}

    	recall.Contact__c = contact.Id;

    	insert recall;

    	//create and return a response object
    	
    	response.put('Id',recall.Id);
    	return JSON.serialize(response);

    }

}