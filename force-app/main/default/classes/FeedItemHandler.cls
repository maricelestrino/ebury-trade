public with sharing class FeedItemHandler {

    private static final String BASE_URL_SALESFORCE = URL.getSalesforceBaseUrl().toExternalForm() +'/';
    private static final CustomChatterPost__mdt CUSTOM_CHATTER_POST_MTD = CustomChatterPost__mdt.getInstance('TradeCreated');

    public static void createFeedItems(List<TradeEvent__e> feedItemsEvent){
        List<FeedItem> feedItems = new List<FeedItem>();
        System.debug(feedItemsEvent);

        //Get all users from particular queue
        Set<Id> groupMemberIds = GroupMemberSelector.getAllMemberIdsByQueueName('Trade reviewers');

        //Get custom metadata
        String messageBody = CUSTOM_CHATTER_POST_MTD.Body__c; 
        for(Id userId : groupMemberIds){
            for(TradeEvent__e event : feedItemsEvent){
                List<Object> parameters = new List<Object>{event.SellCurrency__c, 
                                                            event.SellAmount__c, 
                                                            event.BuyCurrency__c, 
                                                            event.BuyAmount__c, 
                                                            event.Rate__c, 
                                                            event.CreatedDate,
                                                            BASE_URL_SALESFORCE+event.TradeId__c};
                messageBody = String.format(messageBody, parameters);
                FeedItem feedItem = new FeedItem();
                feedItem.Body = messageBody;
                feedItem.ParentId = userId;

                feedItems.add(feedItem);
            }
        }
        insert feedItems; //Add service pra fazer insert
    }
}