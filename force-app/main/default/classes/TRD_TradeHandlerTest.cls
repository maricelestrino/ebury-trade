@IsTest
public with sharing class TRD_TradeHandlerTest {

    @IsTest
    public static void publishTradeEvent_eventShouldBePublished(){

        Trade__c trade = TestDataFactory.createTrade();
        List<Trade__c> trades = new List<Trade__c>();
        trades.add(trade);

        TRD_TradeHandler.publishTradeEvent(trades);

        FeedItem feedItem = [Select Id from FeedItem];
    }
}
