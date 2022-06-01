//all test classes were made in the 'standard' way but 
//the main idea is to mock/stub all records to improve the tests
@IsTest
public with sharing class TRD_TradeAppControllerTest {

    @IsTest
    public static void getAllTrades_shouldReturnTrades(){
        
        Trade__c trade = TestDataFactory.createTrade();
        insert trade;

        List<Trade__c> trades = TRD_TradeAppController.getAllTrades();

        System.assertEquals(true, trades.size() > 0, 'should return trades');
    }

    @IsTest
    public static void getCurrencies_shouldReturnCurrencies(){
        
        List<String> currencies = TRD_TradeAppController.getCurrencies();

        System.assertEquals(true, currencies.size() > 0, 'should return currencies');
    }

    @IsTest
    public static void getRateAndAmount_shouldReturnRate(){
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
    
        String rateAndAmount = TRD_TradeAppController.getRateAndAmount('BRL', 'EUR', '1000');
        
        System.assertEquals(true, rateAndAmount != null, 'rateAndAmount should not be null');
    }

    @IsTest
    public static void createTrade_shouldCreateTrade(){

        String tradeInfo = JSON.serialize(TestDataFactory.createTradeInfo());

        TRD_TradeAppController.createTrade(tradeInfo);
        
        Trade__c trade = [Select Id from Trade__c];

        System.assertEquals(true, trade != null, 'should return the trade');
    }

    @IsTest
    public static void createTrade_shouldNotCreateTrade(){

        TRD_TradeAppController.TradeInfo trade = new TRD_TradeAppController.TradeInfo();
        trade.buyAmount = 10;

        String tradeInfo = JSON.serialize(trade);

        try{
            TRD_TradeAppController.createTrade(tradeInfo);
        }catch(Exception ex){
            System.assertEquals(true, ex.getMessage() != null, 'should return an error message');
        }
    }
}