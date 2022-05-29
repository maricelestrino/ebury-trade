public with sharing class TRD_FixerApiModel {
    
    public String date_Z {get;set;}
    public String historical {get;set;} 
    public Info info {get;set;} 
    public Query query {get;set;} 
    public Double result {get;set;} 
    public Boolean success {get;set;}

    public class Query {
        public Integer amount {get;set;} 
        public String from_Z {get;set;}
        public String to {get;set;}
    }

    public class Info {
        public Decimal rate {get;set;} 
        public Integer timestamp {get;set;} 
    }
}
