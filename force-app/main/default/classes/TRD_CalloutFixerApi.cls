public with sharing class TRD_CalloutFixerApi{

    //add as variaveis aqui

    public static TRD_FixerApiModel getConversion(String toCurrency, String fromCurrency, String amount){
        /*HttpRequest request = new HttpRequest();
        request.setEndpoint(String.format('callout:FixerApi/convert?to={0}&from={1}&amount={2}',
                                        new String[]{toCurrency, fromCurrency, amount})
                            );
        request.setMethod('GET');
        request.setHeader('apikey', '17hNp8nDMDpX1V9OaiCwFl9arAvUoE9d'); //remove hardcoded information

        Http http = new Http();
        HTTPResponse response = http.send(request);

        String responseBody = response.getBody()
                                      .replace('"date"','"date_Z"')
                                      .replace('"from"', '"from_Z"');
        */

        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:FixerApi/convert?to={toCurrency}&from={fromCurrency}&amount={amount}');

        System.debug(request.getEndpoint());
        String jason = '{'+
            '"date": "2018-02-22",'+
            '"historical": "",'+
            '"info": {'+
                '"rate": 148.972231,'+
                '"timestamp": 1519328414'+
            '},'+
            '"query": {'+
                '"amount": 25,'+
                '"from": "GBP",'+
                '"to": "JPY"'+
            '},'+
            '"result": 3724.305775,'+
            '"success": true'+
        '}'; 
        String responseBody = jason.replace('"date"','"date_Z"')
                                   .replace('"from"', '"from_Z"');

        TRD_FixerApiModel trade = new TRD_FixerApiModel();
        trade = (TRD_FixerApiModel)JSON.deserialize(responseBody, TRD_FixerApiModel.class);

        return trade;
    }
}