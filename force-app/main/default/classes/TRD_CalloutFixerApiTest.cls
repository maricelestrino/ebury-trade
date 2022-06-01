//all test classes were made in the 'standard' way but 
//the main idea is to mock/stub all records to improve the tests
@IsTest
public with sharing class TRD_CalloutFixerApiTest {

    @IsTest 
    static void getConversion_shouldMockResponse() {

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
    
        TRD_FixerApiModel trade = TRD_CalloutFixerApi.getConversion('BRL', 'EUR', '1000');
        
        System.assertEquals(true, trade != null, 'trade value should return');
    }
}