trigger TradeEventTrigger on TradeEvent__e (after insert) {

    //Use dispatch to do it.
    FeedItemHandler.createFeedItems(Trigger.new);
}