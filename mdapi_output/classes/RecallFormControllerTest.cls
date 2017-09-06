@isTest
public class RecallFormControllerTest {
    public RecallFormControllerTest() {

    }

    private static testmethod void testRegisterRecall() {

    	String formData = '{ "streetNumber" : "123"}';
    	String result = RecallFormController.registerRecall(formData);
    	System.assert(result != null);


    }
}
