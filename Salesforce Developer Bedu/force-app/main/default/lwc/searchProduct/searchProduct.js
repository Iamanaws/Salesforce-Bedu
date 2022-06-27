import { LightningElement, api } from 'lwc';
import search from '@salesforce/apex/LightningController.search'
import save from '@salesforce/apex/LightningController.save'

import {ShowToastEvent} from 'lightning/platformShowToastEvent'

export default class SearchProduct extends LightningElement {
    
    prod;
    priceBookEntry;    
    productName;
    productCode;
    unitPrice;
    disponible;

    prodCode = '';
    ReservarCantidad = '';
    @api recordId;

    showDetails = false;
    
    searchValue(event) {
        this.prodCode = event.target.value;
    }
    saveValue(event) {
        this.ReservarCantidad = event.target.value;
    }

    searchProduct() {
        if(this.prodCode !== '') {
            search({
                prodCode: this.prodCode
            })
            .then(result => {
                this.prod = result;
                this.priceBookEntry = result.PricebookEntries[0];
                this.inventario = result.Inventarios__r[0];

                this.productName = result.Name;
                this.productCode = result.ProductCode;
                this.unitPrice = result.PricebookEntries[0].UnitPrice;
                this.disponible = result.Inventarios__r[0].Cantidad_dis__c;

                this.showDetails = true;
            })
            .catch(error => {
                this.dispatchEvent(new ShowToastEvent({
                    variant:'error',
                    message: error.body.message
                }));

                this.clear();
            })
        }
        else {
            this.dispatchEvent(new ShowToastEvent({
                variant: 'error',
                message: 'No se a ingresado un codigo de Producto'
                }));
            
            this.clear();
        }
    }

    saveProduct() {
        if(this.ReservarCantidad !== '') {
            save({
                QuoteId: this.recordId,
                PricebookEntryId: this.priceBookEntry.Id,
                Product2Id: this.prod.Id,
                ReservarCantidad: this.ReservarCantidad,
                UnitPrice: this.unitPrice
            })
            .then(result => {
                eval("$A.get('e.force:refreshView').fire();");
                this.dispatchEvent(new ShowToastEvent({
                    variant:'success',
                    message: 'El producto se agrego correctamente.'
                }));
                this.clear();
            })
            .catch(error => {
                this.dispatchEvent(new ShowToastEvent({
                    variant:'error',
                    message: error.body.message
                }));                
            })
        }
        else {
            this.dispatchEvent(new ShowToastEvent({
                variant: 'error',
                message: 'No se ha indicado la cantidad a reservar.'
                }));
        }
    }

    clear() {
        this.prodCode = '';
        this.showDetails = false;
        this.ReservarCantidad = '';
    }
}