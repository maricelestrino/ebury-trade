@IsTest
public with sharing class TestDataFactory {

    public static User createUserAdmin(){

        User user = new User();
        user.FirstName = 'Teste Name';
        user.LastName = 'Last Name';
        user.Username = 'ebury@teste.Mariana';
        user.Email = 'ebury@teste.Mariana';
        user.Alias = 'alias';
        user.ProfileId = getProfile().Id;
        user.TimeZoneSidKey = 'Europe/Lisbon';
        user.LocaleSidKey = 'pt_BR';
        user.EmailEncodingKey = 'UTF-8';
        user.LanguageLocaleKey = 'en_US';

        return user;
    }

    public static Profile getProfile(){
        return [Select Id from Profile Where Name='System Administrator' Limit 1];
    }

    public static Group createQueue(String groupName){

        Group queue = new Group();
        queue.Name = groupName;
        queue.Type = 'Queue';

        return queue;
    }

    public static GroupMember createGroupMember(Id userId, Id groupId){

        GroupMember groupMember = new GroupMember();
        groupMember.GroupId = groupId;
        groupMember.UserOrGroupId = userId;

        return GroupMember;
    }

    public static Trade__c createTrade(){
        Trade__c trade = new Trade__c();
        trade.Rate__c = 1;
        trade.SellCurrency__c = 'BRL';
        trade.BuyCurrency__c = 'EUR';
        trade.SellAmount__c = 1000;
        trade.BuyAmount__c = 2000;

        return trade;
    }

    public static TRD_TradeAppController.TradeInfo createTradeInfo(){

        TRD_TradeAppController.TradeInfo tradeInfo = new TRD_TradeAppController.TradeInfo();
        tradeInfo.buyAmount = 100;
        tradeInfo.buyCurrency = 'BRL';
        tradeInfo.rate = 1;
        tradeInfo.sellAmount = 10000;
        tradeInfo.sellCurrency = 'EUR';

        return tradeInfo;
    }
}
