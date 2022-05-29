public with sharing class FeedItemHandler {

    public static void createFeedItems(List<TradeEvent__e> feedItemsEvent){
        List<FeedItem> feedItems = new List<FeedItem>();
        System.debug(feedItemsEvent);

        //Get all users from particular queue
        Set<Id> groupMemberIds = GroupMemberSelector.getAllMemberIdsByQueueName('Trade reviewers');

        //Get custom metadata
        CustomChatterPost__mdt customChatterPost = CustomChatterPost__mdt.getInstance('TradeCreated');
        String messageBody = customChatterPost.Body__c; //Add os parametros na mensagem

        //criar um feed Item pra cada event
        for(TradeEvent__e event : feedItemsEvent){
            FeedItem feedItem = new FeedItem();
            feedItem.Body = messageBody;

            for(Id userId : groupMemberIds){
                feedItem.ParentId = userId;
            }
            feedItems.add(feedItem);
        }

        insert feedItems; //Add service pra fazer insert
    }
}