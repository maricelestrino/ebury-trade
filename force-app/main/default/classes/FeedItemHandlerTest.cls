//all test classes were made in the 'standard' way but 
//the main idea is to mock/stub all records to improve the tests
@IsTest
public with sharing class FeedItemHandlerTest {
 
    @IsTest
    public static void createFeedItems_withValidEvent_shouldCreateRecord(){

        List<TradeEvent__e> tradeEvents = new List<TradeEvent__e>();
        tradeEvents.add(createTradeEvent());
        FeedItemHandler.createFeedItems(tradeEvents);

        FeedItem feedItem = [Select Id from FeedItem];
        System.assertEquals(true, feedItem!= null, 'FeedItem record should be created');
    }

    private static TradeEvent__e createTradeEvent(){

        TradeEvent__e tradeEvent = new TradeEvent__e(
            BuyAmount__c = 3000,
            BuyCurrency__c = 'EUR',
            Rate__c = 1.5,
            SellAmount__c = 1000,
            SellCurrency__c = 'BRL'
        );
        return tradeEvent;
    }
}
