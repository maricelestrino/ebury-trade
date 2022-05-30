public with sharing class TRD_TradeSelector {

    public static List<Trade__c> getAllOrderedByCreatedDate(){
        return [Select SellCurrency__c, BuyCurrency__c, CreatedDate, SellAmount__c, BuyAmount__c, Rate__c From Trade__c Order by CreatedDate Desc];
    }
}