import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getRateAndAmount from '@salesforce/apex/TRD_TradeAppController.getRateAndAmount';
import createTrade from '@salesforce/apex/TRD_TradeAppController.createTrade';
import getCurrencies from '@salesforce/apex/TRD_TradeAppController.getCurrencies';

export default class CreateTrade extends LightningElement {

    @api showModal;
    rate;
    sellCurrency;
    buyCurrency;
    sellAmount;
    buyAmount;
    options = [];

    typingTimer;

    connectedCallback() {
        this.getCurrencyOptions();
    }

    getCurrencyOptions() {
        getCurrencies()
            .then(result => {
                result.forEach(element => {
                    const option = {
                        value: element,
                        label: element
                    }
                    this.options = [...this.options, option];
                });
            })
    }

    setRate() {
        getRateAndAmount({ amount: this.sellAmount, fromCurrency: this.sellCurrency, toCurrency: this.buyCurrency })
            .then(result => {
                let trade = JSON.parse(result);
                this.rate = trade.rate;
                this.buyAmount = trade.buyAmount;
            })
            .catch(error => {
                this.error = error;
            })
    }

    handleCurrencyChange(event) {
        if (event.target.name == 'buyCurrency') {
            this.buyCurrency = event.target.value;
        } else {
            this.sellCurrency = event.target.value;
        }
        this.checkFields();
    }

    checkFields() {
        if (this.buyCurrency != null && this.sellCurrency != null && this.sellAmount != null) {
            this.setRate();
        }
    }

    handleSellAmountChange(event) {
        this.sellAmount = event.target.value;
        clearTimeout(this.typingTimer);
        //wait 2 seconds for typing
        this.typingTimer = setTimeout(() => {
            if (this.sellAmount) {
                this.checkFields();
            }
        }, 2000);
    }

    saveTrade() {

        let trade = {};
        trade.sellCurrency = this.sellCurrency;
        trade.buyCurrency = this.buyCurrency;
        trade.buyAmount = this.buyAmount;
        trade.sellAmount = this.sellAmount;
        trade.rate = this.rate;

        this.createTradeRecord(JSON.stringify(trade));
    }

    createTradeRecord(tradeJson) {
        createTrade({ trade: tradeJson })
            .then(() => {
                this.showToast('Trade Created','Your new trade has been created','success'); //Create variable to handle it
                this.dispatchEvent(new CustomEvent('add'));
                this.closeModal();
            }
            )
            .catch(error =>{
                this.showToast('Error',error.body.message,'error');
            })
    }

    showToast(title, message, variant){
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    closeModal() {
        this.showModal = false;
        this.dispatchEvent(new CustomEvent('close'));
    }
}