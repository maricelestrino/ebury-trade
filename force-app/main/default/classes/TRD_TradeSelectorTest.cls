//all test classes were made in the 'standard' way but 
//the main idea is to mock/stub all records to improve the tests
@IsTest
public with sharing class TRD_TradeSelectorTest {

    @IsTest
    public static void getAllOrderedByCreatedDate_shouldReturnTradeList(){

        Trade__c trade = TestDataFactory.createTrade();
        insert trade;

        List<Trade__c> trades = TRD_TradeSelector.getAllOrderedByCreatedDate();

        System.assertEquals(true, trades.size() > 0, 'should return one trade');
    }
}
