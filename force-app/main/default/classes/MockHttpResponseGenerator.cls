@IsTest
public with sharing class MockHttpResponseGenerator implements HttpCalloutMock{
    
    public HTTPResponse respond(HTTPRequest req) {

        String convertBody = '{'+
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

        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(convertBody);
        response.setStatusCode(200);
        return response;
    }
}
