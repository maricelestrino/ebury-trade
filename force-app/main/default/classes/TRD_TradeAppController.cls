public with sharing class TRD_TradeAppController {

    @AuraEnabled
    public static List<Trade__c> getAllTrades(){
        return TRD_TradeSelector.getAllOrderedByCreatedDate(); //Treat to not return Id to LWC
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

            Trade__c tradeRecord = new Trade__c(); //use some model to create the record
            tradeRecord.SellCurrency__c = tradeToCreate.sellCurrency;
            tradeRecord.BuyCurrency__c = tradeToCreate.buyCurrency;
            tradeRecord.BuyAmount__c = tradeToCreate.buyAmount;
            tradeRecord.SellAmount__c = tradeToCreate.sellAmount;
            tradeRecord.Rate__c = tradeToCreate.rate;
            
            try{
                TRD_TradeService.createTrade(tradeRecord);
                trades.add(tradeRecord); 
            }catch(System.DmlException ex){
                throw new AuraHandledException(ex.getDmlMessage(0));
            }
            TRD_TradeHandler.publishTradeEvent(trades); //event to trigger chatter creation
    }

    @TestVisible
    private class TradeInfo{
        @TestVisible
        String sellCurrency;
        @TestVisible
        String buyCurrency;
        @TestVisible
        Decimal buyAmount;
        @TestVisible
        Decimal sellAmount;
        @TestVisible
        Decimal rate;

    }
}