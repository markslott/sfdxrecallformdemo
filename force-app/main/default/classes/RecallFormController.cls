public with sharing class RecallFormController {

    public RecallFormController() {}
    
    @remoteAction
    public static String registerRecall(String formData) {
    	Map<String,Object> formMap = (Map<String,Object>) JSON.deserializeUntyped(formData);
    	System.debug((String)formMap.get('streetNumber'));
    	Recall__c recall = new Recall__c();
    	insert recall;
    	Map<String,String> response = new Map<String,String>();
    	response.put('Id',recall.Id);
    	return JSON.serialize(response);

    }

}
