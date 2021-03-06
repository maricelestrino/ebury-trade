import { LightningElement, track } from 'lwc';
import getAllTrades from '@salesforce/apex/TRD_TradeAppController.getAllTrades';

export default class BookedTrades extends LightningElement {

    @track showModal = false;
    error;

    trades;
    visibleTrades;

    /*Improvement: create a field set on Trade__c Object to dinamically get all fields there
    so if some user request to add or remove a field, would be simple to do*/
    columns = [{ label: 'Sell CCY', fieldName: 'SellCurrency__c', type: 'text' },
               { label: 'Sell Amount', fieldName: 'SellAmount__c', type: 'number', 
                 cellAttributes:{ 
                    alignment: 'left' 
                 },               
                 typeAttributes:{
                     minimumFractionDigits: '2',
                     maximumFractionDigits: '2'
                 }},
               { label: 'Buy CCY', fieldName: 'BuyCurrency__c', type: 'text' },
               { label: 'Buy Amount', fieldName: 'BuyAmount__c', type: 'number', 
                  cellAttributes:{ 
                    alignment: 'left' 
                  },
                 typeAttributes:{
                     minimumFractionDigits: '2',
                     maximumFractionDigits: '2'
                 }},
               { label: 'Rate', fieldName: 'Rate__c', type: 'number', 
                 cellAttributes:{ 
                     alignment: 'left' 
                 },
                 typeAttributes:{
                     minimumFractionDigits: '4'
                 }},
               { label: 'Date Booked', fieldName: 'CreatedDate', type: 'date',
                 typeAttributes: {
                    day: 'numeric',
                    month: 'numeric',
                    year: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
               } }
                ];

    connectedCallback() {
		this.getTradeRecords();
	}

    getTradeRecords(){
        getAllTrades()
        .then(result => {
            this.trades = result;
            console.log(this.trades);
        })
        .catch(error => {
            this.error = error;
        })
    }

    updatePagination(event){
        console.log(event.detail.records)
        this.visibleTrades=[...event.detail.records]
    }

    showCreateTrade() {
        this.showModal = true;
    }

    closeCreateTrade() {
        this.showModal = false;
    }
}