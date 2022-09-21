import { LightningElement, api } from 'lwc';
import retrieveReport from '@salesforce/apex/ReportConverterController.retrieveReport';

export default class Converter extends LightningElement {
    @api reportId;
    @api view;
    @api target;
    report;

    connectedCallback() {
        console.log(this.reportId);
        console.log(this.view);
        console.log(this.target);
    }

    doConvert() {
        retrieveReport({reportId : this.reportId})
        .then(result => {
            console.log(result);
            this.report = JSON.parse(result);
            console.log(this.report);
        })
        .catch(error => {console.log(error.message)})
         
    }
}