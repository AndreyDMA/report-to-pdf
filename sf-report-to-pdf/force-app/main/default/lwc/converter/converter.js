import { LightningElement, api } from 'lwc';
import { composeHeaderHTML, composeTableHTML, composeListHTML } from './converterHelper.js';
import retrieveReport from '@salesforce/apex/ReportConverterController.retrieveReport';
import setId from '@salesforce/apex/ReportConverterController.setId';

export default class Converter extends LightningElement {
    @api reportId;
    @api view;
    @api target;
    reportData;
    reportDescr;
    reportHTML='';

    doConvert() {
        this.transferId();
        // this.loadData();
        // this.composeData();
    }

    loadData() {
        retrieveReport({reportId : this.reportId})
        .then(result => {
            this.reportData = JSON.parse(result.data);
            this.reportDescr = JSON.parse(result.description);
        })
        .catch(error => {console.log(error.message)})
    }

    transferId() {
        setId({repId : this.reportId})
        .then(result => {
            console.log('success');
        })
        .catch(error => {console.log(error.message)})
    }

    composeData() {
        if (this.target === "HTML") {
            this.composeHTML();
        } else if (this.target === "PDF") {
            this.composePDF();
        }
    }

    composeHTML() {
        this.reportHTML += composeHeaderHTML(this.reportDescr);
        
        if (this.view === 'List view') {
            this.reportHTML += composeListHTML(this.reportData);
        } else if (this.view === 'Tabular view') {
            this.reportHTML += composeTableHTML(this.reportData);
        }
        console.log(this.reportHTML);
    }

    composePDF() {}
}