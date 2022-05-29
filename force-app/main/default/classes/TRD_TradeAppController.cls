public with sharing class TRD_TradeAppController {

    @AuraEnabled
    public static List<Trade__c> getAllTrades(){
        try {
            return TRD_TradeSelector.getAllOrderedByCreatedDate(); //Treat to not return Id to LWC
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<String> getCurrencies(){

        SObjectType tradeObject = Trade__c.SObjectType;
        Schema.SObjectField buyCurrencyField = Trade__c.BuyCurrency__c;

        List<String> currencyList = PicklistUtils.getPicklistValuesList(tradeObject, buyCurrencyField);

        return currencyList;
    }

    @AuraEnabled
    public static String getRateAndAmount(String amount, String fromCurrency, String toCurrency){

        TRD_FixerApiModel returnedConversion = TRD_CalloutFixerApi.getConversion(toCurrency, fromCurrency, amount);

        TradeInfo tradeToReturn = new TradeInfo();
        tradeToReturn.buyAmount = returnedConversion.result;
        tradeToReturn.rate = returnedConversion.Info.rate;

        return JSON.serialize(tradeToReturn);
    }

    @AuraEnabled
    public static void createTrade(String trade){

            TradeInfo tradeToCreate = (TradeInfo)JSON.deserialize(trade, TradeInfo.class);
            List<Trade__c> trades = new List<Trade__c>();

            Trade__c tradeRecord = new Trade__c();
            tradeRecord.SellCurrency__c = tradeToCreate.sellCurrency;
            tradeRecord.BuyCurrency__c = tradeToCreate.buyCurrency;
            tradeRecord.BuyAmount__c = tradeToCreate.buyAmount;
            tradeRecord.SellAmount__c = tradeToCreate.sellAmount;
            tradeRecord.Rate__c = tradeToCreate.rate;
            
            TRD_TradeService.createTrade(tradeRecord);
            trades.add(tradeRecord);

            TRD_TradeHandler.publishTradeEvent(trades);
    }

    private class TradeInfo{

        String sellCurrency;
        String buyCurrency;
        Decimal buyAmount;
        Decimal sellAmount;
        Decimal rate;

    }
}