public with sharing class TRD_TradeHandler {
    
    public static void publishTradeEvent(List<Trade__c> trades){

        List<TradeEvent__e> tradeEvents = new List<TradeEvent__e>();
        
        for(Trade__c trade : trades){//Use some model to create the event
            TradeEvent__e tradeEvent = new TradeEvent__e(
                BuyAmount__c = trade.BuyAmount__c,
                BuyCurrency__c = trade.BuyCurrency__c,
                Rate__c = trade.Rate__c,
                SellAmount__c = trade.SellAmount__c,
                SellCurrency__c = trade.SellCurrency__c,
                TradeId__c = trade.Id
            );
            tradeEvents.add(tradeEvent);
        }
        EventBus.publish(tradeEvents);
    }
}