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
    	insert recall;

    	//create and return a response object
    	
    	response.put('Id',recall.Id);
    	return JSON.serialize(response);

    }

}
