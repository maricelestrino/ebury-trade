public with sharing class TRD_CalloutFixerApi{

    private static final String API_KEY = '17hNp8nDMDpX1V9OaiCwFl9arAvUoE9d';
    private static final String CONVERT_PATH = 'FixerApi/convert?to={0}&from={1}&amount={2}';
    private static final String GET_METHOD = 'GET';

    public static TRD_FixerApiModel getConversion(String toCurrency, String fromCurrency, String amount){
        
        HttpRequest request = new HttpRequest();
        String url = String.format(CONVERT_PATH, new String[]{toCurrency, fromCurrency, amount});

        request.setEndpoint('callout:' +url);
        request.setMethod(GET_METHOD);
        request.setHeader('apikey', API_KEY);

        Http http = new Http();
        HTTPResponse response = http.send(request);

        String responseBody = response.getBody()
                                      .replace('"date"','"date_Z"')
                                      .replace('"from"', '"from_Z"');

        TRD_FixerApiModel trade = new TRD_FixerApiModel();
        trade = (TRD_FixerApiModel)JSON.deserialize(responseBody, TRD_FixerApiModel.class);

        return trade;
    }
}