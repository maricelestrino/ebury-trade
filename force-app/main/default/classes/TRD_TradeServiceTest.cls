@IsTest
public with sharing class TRD_TradeServiceTest {
    
    @IsTest
    public static void createTrade_shouldInsertRecord() {

        Trade__c trade = new Trade__c();
        TRD_TradeService.createTrade(trade);

        Trade__c returnedTrade = [Select Id from Trade__c];

        System.assertEquals(true, trade.Id == returnedTrade.Id, 'Ids should match');
    }
}
