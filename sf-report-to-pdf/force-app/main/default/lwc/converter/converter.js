import { LightningElement, api } from 'lwc';
import retrieveReport from '@salesforce/apex/ReportConverterController.retrieveReport';

export default class Converter extends LightningElement {
    @api reportId;
    @api view;
    @api target;
    reportData;
    reportDescr;

    doConvert() {
        retrieveReport({reportId : this.reportId})
        .then(result => {
            this.reportData = JSON.parse(result.data);
            this.reportDescr = JSON.parse(result.description);
            console.log(this.reportData);
            console.log(this.reportDescr);
        })
        .catch(error => {console.log(error.message)})
    }
}